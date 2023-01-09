# Introduction

For instructions on installation, images and use cases per distro/OS see: [Docker for Kali](Kali-Setup-Docker.md), for [[Docker-Hacking]]. Originally created by Solomon Hykes in 2013, Docker an open-source containisation platform. While containerisation's original concepts started in 1979 with Unix V7, Docker has made containerisation a popular technology since its release in 2013.

## What is Docker and Containeristion?

[[Containerisation]] is explained by article linked, Docker is open-source containerisation platform that allows Applications to be published, shared and deployed accross any infrastructure that can run Docker.The Docker Engine that is layer of computational organisation above the hardware, the host OS and its kernel. It is not a hypervisor. Each Docker contain must have the same kernel type to operate. A container is commonly used to hold an environment or specific OS of an OS family to test system variation of running software. It is similar to VM hosting but Docker with there is **NO** virtualisation, hence requiring host OS that host Contain running similar OSes. Docker images are a read-only template of instruction for creating a Docker container. 

## Building a Docker containers

```bash
docker build -t yourname/imagename path/to/Dockerfile

docker run  -d --privileged -v /:/host:rw $image
FROM $dir/$image
```

[Docker setup of kali for hackers consider this article](https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/), that Hackers *"can use Docker to build and configure an environment containing just the tools we need, and then launch a container and work from that. Our environment will always be exactly the same as it’s launched from an image, and we can easily launch multiple containers at the same time as they don’t consume a lot of resources...allows us to have a self-contained testing environment for each job or test or random-tinker, where any processes, installs and so on are all local to that container and don’t pollute your “Testing VM” or host OS."*



## Securing Containers

[Some ways to secure a docker container](https://faun.pub/hack-your-docker-container-6d3e1e1b363) or for more information about container best practices and docker security, consider reviewing OWASP cheat-sheet: 

[https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html).

1. The Principle of Least Privilege
2. Restrict capability of container with security profiles
3. Securing the web server hosting self-signed SSL certificates for registries

## References

[https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html).
[Docker setup of kali  for hackers check this article](https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/)
[Some ways to secure a docker container](https://faun.pub/hack-your-docker-container-6d3e1e1b363)
[THM Intro to Containerisation](https://tryhackme.com/room/introtocontainerisation)