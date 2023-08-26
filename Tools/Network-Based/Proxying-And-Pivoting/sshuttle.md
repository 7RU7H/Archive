# sshuttle

## Introduction

[sshuttle](https://github.com/sshuttle/sshuttle) is a *"Transparent proxy server that works as a poor man's VPN. Forwards over ssh. Doesn't require admin. Works with Linux and MacOS. Supports DNS tunneling."*

[[Kali]]
```bash
sudo apt install sshuttle
```

Apparently according to the author ... *sshuttle is the only program that solves the following common case:
- *Your client machine (or router) is Linux, FreeBSD, or MacOS.*
- *You have access to a remote network via ssh.*
- *You don't necessarily have admin access on the remote network.*
- *The remote network has no VPN, or only stupid/complex VPN protocols (IPsec, PPTP, etc). Or maybe you are the admin and you just got frustrated with the awful state of VPN tools.*
- *You don't want to create an ssh port forward for every single host/port on the remote network.*
- *You hate openssh's port forwarding because it's randomly slow and/or stupid.*
- *You can't use openssh's PermitTunnel feature because it's disabled by default on openssh servers; plus it does TCP-over-TCP, which has [terrible performance](https://sshuttle.readthedocs.io/en/stable/how-it-works.html).*

## Cheatsheet

Beware for key-based authentication requires:
```bash
--ssh-cmd "ssh -i KEYFILE"
```

...usages
```bash
sshuttle -r username@$ipAddress $subnet/cidr
# Autodetirmine the subnet with -N probably not a good idea if it needs $subnet/cidr
sshuttle -r username@$ipAddress -N
# Key-based authentication example
sshuttle -r username@$10.10.10.10 --ssh-cmd "ssh -i KEYFILE" 10.10.10.0/24
```

For `send disconnect: Broken pipe client: fatal: server died with error code 255` error - compromised machine is not forwarding newly forwarded subnet. Exclude any server we are connecting too to avoid this error 
```
sshuttle -r username@$ipAddress $subnet/cidr -x $excludeAddr
```
## References

[Github sshuttle](https://github.com/sshuttle/sshuttle) 
[sshuttle Documentation](https://github.com/sshuttle/sshuttle) )