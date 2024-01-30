# Kali Hardening

Initial planning by reviewing how to contruct a relavent [Security Policy](Security-Policies.md)

Hardening starts before you install your system

## Boot level Hardening

## Software List

```bash
apt install ufw
apt install fail2ban # Protect against bruteforcing expose services
apt install fwbuilder # ufw  
```

## Network Services

Depending on the desired level of security the firewalls implementation is critical, although tendious the approach to by default reject or drop everything to every port and then work backwards through each piece of software needed to open the port for use. See [[Securing-Network-Services]]


## Nuke button