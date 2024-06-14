# Docker

## Introduction

For instructions on installation, images and use cases per distribution/OS see: [Docker for Kali](Kali-Setup-Docker.md), for [[Docker-Hacking]]. Originally created by Solomon Hykes in 2013, Docker an open-source containisation platform. While containerisation's original concepts started in 1979 with Unix V7, Docker has made containerisation a popular technology since its release in 2013.

#### What is Docker and Containeristion?

[[Containerisation]] is explained by article linked, Docker is open-source containerisation platform that allows Applications to be published, shared and deployed across any infrastructure that can run Docker. The Docker Engine that is layer of computational organisation above the hardware, the host OS and its kernel. It is not a hypervisor. Each Docker contain must have the same kernel type to operate. A container is commonly used to hold an environment or specific OS of an OS family to test system variation of running software. It is similar to VM hosting but Docker with there is **NO** virtualisation, hence requiring host OS that host Contain running similar OSes. Docker images are a read-only template of instruction for creating a Docker container. 
#### CLI
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
docker image build # Build an image from a Dockerfile
docker image history # Show the history of an image
docker image import # Import the contents from a tarball to create a filesystem image
docker image inspect # Display detailed information on one or more images
docker image load # Load an image from a tar archive or STDIN
docker image ls # List images
docker image prune # Remove unused images
docker image pull # Download an image from a registry
docker image push # Upload an image to a registry
docker image rm # Remove one or more images
docker image save # Save one or more images to a tar archive (streamed to STDOUT by default)
docker image tag # Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE


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
Docker `compose`is for multiple containers to interact with each other while needing to run in isolation from one another.
- for **running** multiple containers on a single host 
- uses .yaml composition files
- [see](https://docs.docker.com/compose/gettingstarted/)

[Dockerfiles](https://docs.docker.com/engine/reference/builder/) have the syntax: `INSTRUCTION arguments`, it has no extension it is just Dockerfile

```dockerfile
# Parse directives
# Parser directives are optional, non-case-sensitive can noly be used once 
# Do add layers or are shown up as build step, they affect how the subsequent lines are handled
# directive=value

# Comment
# Leading whitespace before comments and instructions are ignored
# INSTRUCTION arguments

# From initializes a new build stage and sets the base image
FROM IMAGE:latest
# Run a executable or shell command
RUN <command> 
RUN <executable> 
# Security level either: insecure or sandbox
RUN --security=
# Network either: default, none or host
RUN --network=
# Copy
# ADD != COPY; COPY is basic copy
# either copies a file(s), directories
COPY
COPY [--chown=<user>:<group>] [--chmod=<perms>] <src>... <dest>
COPY [--chown=<user>:<group>] [--chmod=<perms>] ["<src>",... "<dest>"]
# WORKDIR set the current working directory
WORKDIR
# CMD is either a executable, parametres for an ENTRYPOINT or shell command and parametres
CMD
# Export network ports one line per protocol
EXPOSE
EXPOSE 443/tcp
EXPOSE 443/udp
# LABEL adds metadata to an image
LABEL 
# ENV Sets environment variables 
ENV
# ADD 
# ADD != COPY; ADD: tar extractions, remote url support
# either copies a file(s), directories or remote file URLs from src to dst
# Two forms:
ADD [--chown=<user>:<group>] [--chmod=<perms>] [--checksum=<checksum>] <src>... <dest>
ADD [--chown=<user>:<group>] [--chmod=<perms>] ["<src>",... "<dest>"]
# ENTRYPOINT allows you to configure a container that will run as an executable
ENTRYPOINT
# VOLUME creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers
VOLUME
# USER sets the user name (or UID) and optionally the user group (or GID) to use as the default user and group for the remainder of the current stage of the build
USER
# Create variables within a Dockerfile
ARG IMAGE=favouriteOS
# ONBUILD adds to the image a trigger instruction to be executed at a later time,
ONBUILD
# STOPSIGNAL sets the system call signal that will be sent to the container to exit
STOPSIGNAL
# HEALTHCHECK 
# Either disable any healthcheck or check from with inside a container
HEALTHCHECK NONE
HEALTHCHECK [OPTIONS] CMD command
SHELL
# MAINTAINER -- deprecated
```

Set a name and destination of the docker container.
```bash
docker build -t NAME <destination>
```

Reducing container size:
- Only install essential packages
- Removing cached files
- Using minimal base OS with `FROM`
- Minimise the number of layers to the Docker file; `RUN <all installations on one line>`

#### Docker Compose

Docker `compose` is for multiple containers to interact with each other while needing to run in isolation from one another.
- for **running** multiple containers on a single host 
- uses [YAML](https://yaml.org) (.yaml or .yml) composition files
- [see](https://docs.docker.com/compose/gettingstarted/)

*"The Compose file is a [YAML](https://yaml.org) file defining services, networks, and volumes for a Docker application. The latest and recommended version of the Compose file format is defined by the [Compose Specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md)."* - [From](https://docs.docker.com/compose/compose-file/)

Docker compose command
```bash
# (re)create/build and start fleet of containers specifed in a compositionFile.yaml
docker-compose up 
# Start prebuilt containers specifed in a compositionFile.yaml
docker-compose start
# Stop and delete containers specifed in a compositionFile.yaml
docker-compose down
# Just stop coantiners containers specifed in a compositionFile.yaml
docker-compose stop 
# Just build containers specifed in a compositionFile.yaml
docker-compose build
```

This an adapted docker-compose.yml from the [THM Intro to Docker room](https://tryhackme.com/room/introtodockerk8pdqk) and the [Compose spec](https://github.com/compose-spec/compose-spec/blob/master/spec.md)
```yaml
# version of the compose file that must be at the top of file
version: '0.1'
services:  # container's configuration name
  frontend:
    build: ./webapp
    networks:
      - front-tier
      - back-tier
    ports:
      - '443:443'
    configs:
      - httpd-config
    secrets:
      - server-certificate

  backend:
    image: 'mysql:latest'
    networks:
      - back-tier
    environment: # set environment variables (not secure!)
      - MYSQL_DATABASE=ecommerce
      - MYSQL_USERNAME=root
      - MYSQL_ROOT_PASSWORD=dontputpasswordsintheenvironmentvars
    volumes:
      - db-data:/etc/data
  appgateway: 
    image: 'owasp/application-gateway:latest'
    networks:
      - front-tier
      - back-tier
      
networks: # Containers must be part of a network this section defines the networks
  front-tier: {}
  back-tier: {}

configs:
  httpd-config:
    external: true

secrets:
  server-certificate:
    external: true

volumes:
  db-data:
    driver: flocker
    driver_opts:
      size: "10GiB"
```

#### Docker Socket

Docker sockets allow for Interprocess Communication (IPC).

*"By default, Docker runs through a non-networked UNIX socket. It can also optionally communicate using SSH or a TLS (HTTPS) socket."* - [Protect the Docker daemon socket](https://docs.docker.com/engine/security/protect-access/)



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
[Dockerfile reference](https://docs.docker.com/engine/reference/builder/#onbuild)
[Compose Specification](https://github.com/compose-spec/compose-spec/blob/master/spec.md)
[Composition File](https://docs.docker.com/compose/compose-file/)