# SMTP Cheatsheet
Simple Mail Transport Protocol (SMTP)
Vulnerable Email Servers can contain valuable information. 
See [[Networks/Network-Protocols]] for port information.

## Telenet
```bash
telnet $IP 25
nc -nv $IP 25
VRFY $useremail # verify email address
EXPN # Ask server for membership
```
Code 250,251,252 means accepted and user account is valid; code 550 means invalid user.

## Nmap
```bash

```

## Metasploit
```bash
use auxiliary/scanner/smtp/smtp_enum
msf auxiliary(smtp_enum) > set rhosts $IP
msf auxiliary(smtp_enum) > set rport 25
msf auxiliary(smtp_enum) > set USER_FILE /usr/
msf auxiliary(smtp_enum) > exploit
```

## References
[hackingarticals](https://www.hackingarticles.in/4-ways-smtp-enumeration/)