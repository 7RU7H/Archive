#### Authors Pedantic Docker System Administration

Drafts

Personal Caveats:
- I do not like Keyrings - to many CVEs
- No SUID or sudo - to many privilege escalations

Warning this is just my probably misguided ideas about Docker SysAdmin, use brain.
 
- Never ever, ever run Privileged Containers.
- Never store passwords as ENV variables on disk or in RAM
```bash
# Disable ANYTHING REMOTELY related to Docker service you need running
systemctl stop docker
systemctl stop docker-ce
systemctl stop docker-ce-cli
systemctl stop containerd.io
systemctl stop docker-buildx-plugin
systemctl stop docker-compose-plugin
systemctl disable docker
systemctl disable docker-ce
systemctl disable docker-ce-cli
systemctl disable containerd.io
systemctl disable docker-buildx-plugin
systemctl disable docker-compose-plugin

# Only have service you need running, when you need it and turn it off when you are done
systemctl enable $service
systemctl start $service
systemctl status $service

# Root turns on and off services and controls configs
# Docker-Adm manages containers - I do not think this user needs sudo
useradd -m -s /bin/bash docker-admin
usermod -aG docker docker-admin
usermod -aG adm docker-admin
# You user does not touch docker except through some 
```