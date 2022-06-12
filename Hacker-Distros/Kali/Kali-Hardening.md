# Kali Hardening

Initially planning by review how to contruct a [security policies](Secure-Architectures/Security-Policies)

Hardening starts before you install your system

## Boot level Hardening

## Software List
```bash
apt install ufw
apt install fail2ban # Protect against bruteforcing expose services
```

## Network Services
Depending on the desired level of security the firewalls implementation is critical, although tendious the approach to by default reject or drop everything to every port and then work backwards through each piece of software needed to open the port for use. 


## Nuke button