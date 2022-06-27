# Introduction

For instructions on installation, images and use cases per distro/OS see:[Docker for Kali](Hacker-Distros/Kali/dockerForKali), for [[Docker-Hacking]]

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