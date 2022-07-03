# Kali Setup Docker 
## Install on Kali
```bash
apt install -y docker.io
systemctl enable docker --now
```

[For installing docker-ce on Kali](https://www.kali.org/docs/containers/installing-docker-on-kali/)

## Add user
```bashg
usermod -aG docker $USER
````

## Kali docker image 
```bash
docker pull kalilinux/kali-rolling
docker run --tty --interactive kalilinux/kali-rolling /bin/bash
```

[Docker setup of kali  for hackers check this article](https://www.pentestpartners.com/security-blog/docker-for-hackers-a-pen-testers-guide/)