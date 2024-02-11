# Container Hardening

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

Daemon is interacted with HTTP/S - [[TLS-SSL]] remembering or review best practices for TLS certificate management
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

system call operates on the Secure Computing (seccomp) state of the calling process. Consider reviewing [openshift - Managing security context constraints](https://docs.openshift.com/container-platform/4.11/authentication/managing-security-context-constraints.html)

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

## References

[THM Container Hardening Room](https://tryhackme.com/room/containerhardening)
[Docker Roles and Permissions Documentation](https://docs.docker.com/security/for-admins/roles-and-permissions/)
[openshift - Managing security context constraints](https://docs.openshift.com/container-platform/4.11/authentication/managing-security-context-constraints.html)