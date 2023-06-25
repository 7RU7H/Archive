# Docker

## Introduction

For instructions on installation, images and use cases per distribution/OS see: [Docker for Kali](Kali-Setup-Docker.md), for [[Docker-Hacking]]. Originally created by Solomon Hykes in 2013, Docker an open-source containisation platform. While containerisation's original concepts started in 1979 with Unix V7, Docker has made containerisation a popular technology since its release in 2013.

#### What is Docker and Containeristion?

[[Containerisation]] is explained by article linked, Docker is open-source containerisation platform that allows Applications to be published, shared and deployed accross any infrastructure that can run Docker.The Docker Engine that is layer of computational organisation above the hardware, the host OS and its kernel. It is not a hypervisor. Each Docker contain must have the same kernel type to operate. A container is commonly used to hold an environment or specific OS of an OS family to test system variation of running software. It is similar to VM hosting but Docker with there is **NO** virtualisation, hence requiring host OS that host Contain running similar OSes. Docker images are a read-only template of instruction for creating a Docker container. 

## CLI

```bash

# Running containers
#
docker run $options $imagesName $command $args
# see docker run --help for all, but some
# -it interactive mode
docker run -it ubuntu:latest /bin/bash
# -d "detached" mode - run in the background
# -v Volume  
docker run -v /$host/$os/$directory:/$container/$directory debian:latest
# -p bind a port on the host to the port on the container
docker run -p 80:80 webserver
# --rm remove container once it complete instructions
# --name give a name to a container

# List running containers
docker ps
docker ps -a # incuded stopped

# Managing and inspecting containers 
#

# Managing Docker Images
#
# Pull the latest version
docker pull $package:$tag
# image command for image manage
docker image
build # Build an image from a Dockerfile
history # Show the history of an image
import # Import the contents from a tarball to create a filesystem image
inspect # Display detailed information on one or more images
load # Load an image from a tar archive or STDIN
ls # List images
prune # Remove unused images
pull # Download an image from a registry
push # Upload an image to a registry
rm # Remove one or more images
save # Save one or more images to a tar archive (streamed to STDOUT by default)
tag # Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE


# Docker daemon stats and information
#


docker build -t $yourname/$imagename path/to/Dockerfile



docker run  -d --privileged -v /:/host:rw $image
FROM $dir/$image

# Run -it sudo tty --rm to delete when done, bind port to host
sudo docker run -it --rm --name package -p $port:$port $package/$package
```


## Building Containers

[Docker setup of kali for hackers consider this article](https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/), that Hackers *"can use Docker to build and configure an environment containing just the tools we need, and then launch a container and work from that. Our environment will always be exactly the same as it’s launched from an image, and we can easily launch multiple containers at the same time as they don’t consume a lot of resources...allows us to have a self-contained testing environment for each job or test or random-tinker, where any processes, installs and so on are all local to that container and don’t pollute your “Testing VM” or host OS."*


Dockerfiles with Build is not that same as Compose with .yaml
Docker `build` is:
- for single containers 
- uses Dockerfiles 
Docker `compose` is for multiple containers 
- for **running** multiple containers on a single host 
- uses .yaml composition files
- [see](https://docs.docker.com/compose/gettingstarted/)

```

FROM
RUN
COPY
WORKDIR
CMD
EXPOSE

```



## Securing Containers

[Some ways to secure a docker container](https://faun.pub/hack-your-docker-container-6d3e1e1b363) or for more information about container best practices and docker security, consider reviewing OWASP cheat-sheet: 

[https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html).

1. The Principle of Least Privilege
2. Restrict capability of container with security profiles
3. Securing the web server hosting self-signed SSL certificates for registries

## References

[https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html).
[Docker setup of Kali for hackers check this article](https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/)
[Some ways to secure a docker container](https://faun.pub/hack-your-docker-container-6d3e1e1b363)
[THM Intro to Containerisation](https://tryhackme.com/room/introtocontainerisation)
[THM Intro to Docker](https://tryhackme.com/room/introtodockerk8pdqk)
[Docker compose](https://docs.docker.com/compose/gettingstarted/)