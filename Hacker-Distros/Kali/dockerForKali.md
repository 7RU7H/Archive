
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