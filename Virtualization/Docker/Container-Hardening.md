# Container Hardening

[[Docker]] uses the container abstraction to run applications with only the utilities that the application needs on top of a host OS. Hardening containers is important to prevent resource mismanagement, [[Docker-Hacking]] and your containers being vulnerable.

#### Review and Audit Docker Images

Why?
- Some images are malicious and are used for BotNets, Cyptomining, Ransomware, etc similar to review any Windows Images for IR Active Directory - check your backups to!
How?
- Check the Docker file
- [Dive](https://github.com/wagoodman/dive) can aid in reverse engineering a Docker image by inspecting what is executed and changed at each layer of the image during the build process.

Vulnerability scanning with:
- [Grype](https://github.com/anchore/grype)
```bash
# Vulnerability scan:
grype $imagename --scope all-layers
# Scan exported container filesystem:
grype /path/to/image.tar 
```
#### Docker Daemon

**If you must expose the Docker Daemon** use secure communication to prevent unauthorised access

Implement Docker Contexts for communication and [RBAC per context]((https://docs.docker.com/security/for-admins/roles-and-permissions/)
```bash
# Create the context - ideally container administrator would create and assign
docker context create
--docker host=ssh://$user@remotehost
--description="Development Environment" 
development-environment-host
# use the context to comunicate with the container
docker context use development-environment-host
# Exit the context
docker context use default
```

Daemon is interacted with HTTP/S - [[SSL-TLS]] remembering or review best practices for TLS certificate management
```bash
# Run docker in TLS mode
dockerd --tlsverify --tlscacert=myca.pem --tlscert=myserver-cert.pem --tlskey=myserver-key.pem -H=0.0.0.0:2376
# Authenticate with TLS
docker --tlsverify --tlscacert=myca.pem --tlscert=client-cert.pem --tlskey=client-key.pem -H=SERVERIP:2376 info
```

#### Control Groups

Implement Control groups (cgroups) to control system resource a process can use.
```bash
# Inspect resources limits set for a container
docker inspect containername
# Core Count number
docker run -it --cpus="1" $container
# Provision docker with some amount N of either k - kilobyte,m megabyte, g gigabytes 
docker run -it --memory="20m"
```

#### Container Privileges

Over-Privileged container can lead to full host compromise as it shares the same namespace as the host. Use capability to manage root level access requirements per service **individual** if required abiding by the [[Principle-Of-Least-Privilege]]. 

| [THM Container Hardening Room](https://tryhackme.com/room/containerhardening)- stated these as standard used  | [THM Container Hardening Room](https://tryhackme.com/room/containerhardening) - stated these as standard used  | [THM Container Hardening Room](https://tryhackme.com/room/containerhardening)- stated these as standard used  |
|---|---|---|
|**Capability**|**Description**|**Use Case**|
|CAP_NET_BIND_SERVICE|This capability allows services to bind to ports, specifically those under 1024, which usually requires root privileges.|Allowing a web server to bind on port 80 without root access.|
|CAP_SYS_ADMIN|This capability provides a variety of administrative privileges, including being able to mount/unmount file systems, changing network settings, performing system reboots, shutdowns, and more.|You may find this capability in a process that automates administrative tasks. For example, modifying a user or starting/stopping a service.|
|CAP_SYS_RESOURCE|This capability allows a process to modify the maximum limit of resources available. For example, a process can use more memory or bandwidth.|This capability can control the number of resources a process can consume on a granular level. This can be either increasing the amount of resources or reducing the amount of resources.|

```bash
# run a docker container  
docker run -it --rm --cap-drop=ALL --cap-add=NET_BIND_SERVICE $webserver
# Display capabilities that are assign
capsh --print
```

#### Seccomp

system call operates on the Secure Computing ([seccomp](https://man7.org/linux/man-pages/man2/seccomp.2.html)) state of the calling process. Consider reviewing [openshift - Managing security context constraints](https://docs.openshift.com/container-platform/4.11/authentication/managing-security-context-constraints.html)

[THM Container Hardening Room](https://tryhackme.com/room/containerhardening) example of web server `seccomp` profile
```json
{
  "defaultAction": "SCMP_ACT_ALLOW",
  "architectures": [
    "SCMP_ARCH_X86_64",
    "SCMP_ARCH_X86",
    "SCMP_ARCH_X32"
  ],
  "syscalls": [
    { "names": [ "read", "write", "exit", "exit_group", "open", "close", "stat", "fstat", "lstat", "poll", "getdents", "munmap", "mprotect", "brk", "arch_prctl", "set_tid_address", "set_robust_list" ], "action": "SCMP_ACT_ALLOW" },
    { "names": [ "execve", "execveat" ], "action": "SCMP_ACT_ERRNO" }
  ]
}
```

```bash
docker run --rm -it --security-opt seccomp=/home/cmnatic/container1/seccomp/profile.json $container
```

#### AppArmor

[AppArmor](https://apparmor.net/) *"AppArmor is an effective and easy-to-use Linux application security system. AppArmor proactively protects the operating system and applications from external or internal threats, even zero-day attacks, by enforcing good behavior and preventing both known and unknown application flaws from being exploited. AppArmor supplements the traditional Unix discretionary access control (DAC) model by providing mandatory access control (MAC). It has been included in the mainline Linux kernel since version 2.6.36 and its development has been supported by Canonical since 2009."*

Check the status of AppArmor
```bash
# status
sudo aa-status
# Parse AppArmor Rules 
sudo apparmor_parser -r -W profile.json
# Use AppArmor Rules for a container
docker run --rm -it --security-opt apparmor=profile.json
```

Use the AppArmor [Profile Language](https://gitlab.com/apparmor/apparmor/-/wikis/QuickProfileLanguage) *that is then compiled into a binary policy for loaded
into the kernel.* 
```json
/path/to/bin {
	# Profile content
	/path/to/child/profile { # Parent profiles can contain child profiles!
	# <- is a comment
	capability setuid, # Linux POSIX-syle capabilities can be use RTFM required
	# ...
	network # coarse-grained network rules
	/path/to/file rw, # pathname and the permission for file rules
	deny /bin/**, # Deny access to parts of the file  system
	}
}
#include # legacy include use below:
include file.rules # C like inclusion of rule files
```

File permissions of AppArmor 
```bash
- r - read
- w - write
- a - append (implied by w)
- x - execute
    - ux - Execute unconfined (preserve environment) -- WARNING: should only be used in very special cases
    - Ux - Execute unconfined (scrub the environment)
    - px - Execute under a specific profile (preserve the environment) -- WARNING: should only be used in special cases
    - Px - Execute under a specific profile (scrub the environment)
    - pix - as px but fallback to inheriting the current profile if the target profile is not found
    - Pix - as Px but fallback to inheriting the current profile if the target profile is not found
    - pux - as px but fallback to executing unconfined if the target profile is not found
    - Pux - as Px but fallback to executing unconfined if the target profile is not found
    - ix - Execute and inherit the current profile
    - cx - Execute and transition to a child profile (preserve the environment)
    - Cx - Execute and transition to a child profile (scrub the environment)
    - cix - as cx but fallback to inheriting the current profile if the target profile is not found
    - Cix - as Cx but fallback to inheriting the current profile if the target profile is not found
    - cux - as cx but fallback to executing unconfined if the target profile is not found
    - Cux - as Cx but fallback to executing unconfined if the target profile is not found
- m - memory map executable
- k - lock (requires r or w, AppArmor 2.1 and later)
- l - link
```

#### Comploance And Benchmarking

[Docker Scout tool](https://github.com/docker/scout-cli) is required to analyse images - [Docker Scout documentation](https://docs.docker.com/scout/) 

This is from [THM Container Hardening Room](https://tryhackme.com/room/containerhardening), always check the most recent regulations and benchmarking changes and innovations.

|   |   |   |
|---|---|---|
|**Compliance Framework**|**Description**|**URL**|
|NIST SP 800-190|This framework outlines the potential security concerns associated with containers and provides recommendations for addressing these concerns.|[https://csrc.nist.gov/publications/detail/sp/800-190/final](https://csrc.nist.gov/publications/detail/sp/800-190/final)|
|ISO 27001|This framework is an international standard for information security. The standard guides implementing, maintaining and improving an information security management system.|[https://www.iso.org/standard/27001](https://www.iso.org/standard/27001)|

|   |   |   |
|---|---|---|
|**Benchmarking Tool**|**Description**|**URL**|
|CIS Docker Benchmark|This tool can assess a container's compliance with the CIS Docker Benchmark framework.|[https://www.cisecurity.org/benchmark/docker](https://www.cisecurity.org/benchmark/docker)|
|OpenSCAP|This tool can assess a container's compliance with multiple frameworks, including CIS Docker Benchmark, NIST SP-800-190 and more.|[https://www.open-scap.org/](https://www.open-scap.org/)|
|Docker Scout|This tool is a cloud-based service provided by Docker itself that scans Docker images and libraries for vulnerabilities. This tool lists the vulnerabilities present and provides steps to resolve these.|[https://docs.docker.com/scout/](https://docs.docker.com/scout/)|
|Anchore|This tool can assess a container's compliance with multiple frameworks, including CIS Docker Benchmark, NIST SP-800-190 and more.|[https://github.com/anchore/anchore-engine](https://github.com/anchore/anchore-engine)|
|Grype|This tool is a modern and fast vulnerability scanner for Docker images|[https://github.com/anchore/grype](https://github.com/anchore/grype)|
## References

[THM Container Hardening Room](https://tryhackme.com/room/containerhardening)
[Docker Roles and Permissions Documentation](https://docs.docker.com/security/for-admins/roles-and-permissions/)
[openshift - Managing security context constraints](https://docs.openshift.com/container-platform/4.11/authentication/managing-security-context-constraints.html)
[seccomp](https://man7.org/linux/man-pages/man2/seccomp.2.html)
[Docker Scout tool](https://github.com/docker/scout-cli) 
[Docker Scout documentation](https://docs.docker.com/scout/) 
[Dive](https://github.com/wagoodman/dive) 
[Grype](https://github.com/anchore/grype)