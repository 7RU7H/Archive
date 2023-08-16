# Kali Setup Docker 

## Install on Kali

```bash
sudo apt install docker.io
systemctl enable docker --now
```

[For installing docker-ce on Kali](https://www.kali.org/docs/containers/installing-docker-on-kali/)

## Add user

Considering adding a user.
```bashg
usermod -aG docker $USER
````

## Kali docker image 

This Image has no tools    
```bash
docker pull kalilinux/kali-rolling
docker run --tty --interactive kalilinux/kali-rolling /bin/bash
```

[Docker setup of kali  for hackers check this article](https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/). A more more basic template that the article aforementioned:
```docker
# From the Kali linux base image
FROM kalilinux/kali-linux-docker
# Update and apt install programs
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get install -y \
# <insert App> \

# Segment based on heirarchy - apt -> then others

# RUN git clone
# RUN pip ...

# Update ENV
ENV PATH=$PATH:/
# Set entrypoint and working directory
WORKDIR /root/
# Indicate what ports to expose 
EXPOSE 80/tcp 
```

Consider different images, but also if you know an OS well, which you do not want to pollute.
```bash
# -t name option name:tag
docker build -t image/imagename -f path/to/Dockerfile 
```

## References

[Install Docker on Kali Official](https://www.kali.org/docs/containers/installing-docker-on-kali/)