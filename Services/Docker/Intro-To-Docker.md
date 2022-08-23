# Introduction

For instructions on installation, images and use cases per distro/OS see:[Docker for Kali](Kali-Setup-Docker.md), for [[Docker-Hacking]]

## What is Docker and Containeristion?

The Docker Engine that is layer of computational organisation above the hardware, the host OS and its kernel. It is not a hypervisor. Each Docker contain must have the same kernel type to operate. A container is commonly used to hold an environment or specific OS of an OS family to test system variation of running software. It is similar to VM hosting but Docker with there is **NO** virtualisation, hence requiring host OS that host Contain running similar OSes. Docker images are a read-only template of instruction for creating a Docker container. 

[Some ways to secure a docker container](https://faun.pub/hack-your-docker-container-6d3e1e1b363)


## Building a Docker container

```bash
docker run  -d --privileged -v /:/host:rw $image

FROM $dir/$image
```

[Docker setup of kali  for hackers check this article](https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/)

## Securing Containers
1. The Principle of Least Privilege
2. Restrict capability of container with security profiles
3. Securing the web server hosting self-signed SSL certificates for registries