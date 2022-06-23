# Network services

## 20/21 - FTP
File transfer protocol, client-server model
1. Port 20 for data
2. Port 21 for commands 
3. can connect similar with telnet client with port number!
```
wget -r ftp://[username]:[password]@[ip]/
ftp ip

-n 	prevent autologon
-v 	verbose server output

USER username
PASS password
SYST	system		system info
PASV	passive		enter passive mode
TYPE A	type ascii	enter ASCII mode
STAT	status		give server status

ls -la		list directory, sometimes ls DOES NOT WORK
get file
put file	upload files!
```

## 22 SSH
generally port 22
```
-i	access with private key
-L	local_port:remote_address:remote_port # for local port fowarding
-R	port:loca_address:local_port # For remote port forwarding 
-D	local_PORT # Dynamic port fowarding, creates sockets proxy on localhost
-N	Do not execute a remote command. Useful in for just forwardin ports
-p      port
```

## 22 - SFTP - submodule of ssh
Secure File transfer protocol port 22 

## 23 - TELNET
Generall port 23, Telnet is cleartext and unsecure!

```bash
telnet $ip
# THEN
GET / HTTP/1.1 
# OR
GET /page.html HTTP/1.1
#Will get telnet get you cleartext info on servers with exposed telnet ports
```

## 25 - SMTP
Generally 25
Stands for Simple mail transfer protocol
For recon: [[SMTP-Recon-Cheatsheet]]
```bash
telnet $ip
nc -nv $IP

```

## 48 - WHOIS 
//generally 48

## 53 - DNS
//default 53

## 69 - TFTP
Stands for trivial file transfer protocol - UDP FTP
generally 69

## 80 - HTTP
Default 80

POP3
//generally 110
//post office protocol 3
//used to download email from mail delivery agent MDA -- from MUA -(smtp)-> MSA/MTA -> SMTP -> MTA/MDA -(POP3/IMAP)-> MUA
USER 
PASS
STAT
LIST	list all messUSER 
RETR	return a message

# 111 - NFS
[[NFS-Recon]]
//On both 111 2049

Shared directory, mount those shares!
```bash
sudo showmount -e $ip
sudo mount $ip:/file/path /local/file/path

sudo mount -o port=1234 -t nfs $ip:/dir /tmp/local
# nolock maybe required for older systems
sudo mount -o nolock port=1234 -t nfs $ip:/dir /tmp/local

umount $ip:/local/file/path	
```

## 13(5,7-9), 445 -  NBT - SMB
[[SMB-Recon-Cheatsheet]]
Server Message Block protocol uses a client-server model. Cliet uses `smbclient` see [smbclientCheatSheet](SMB-Recon-Cheatsheet.md)
SMB oringally ran on top of NetBIOS using port 139. NetBIOS is an older transport layer that allows Windows computer to communicate on the same network. Later versions of SMB(after Windows 2000) use port 445 on top of a TCP stack, TCP allows for internet communication.
NetBIOS over TCP/IP (NetBT)	Windows name resolution
135(TCP) msrpc
137(TCP/UDP)
138(UDP)
139(TCP) netbios-ssn
445(TCP) microsoft-ds

## IMAP
//generally 143

## 389 - LDAP
Default port 389
[[LDAP-Recon]]



## 443- HTTPS
//internet messaging access protocol
//default port 443

SMTPS
//default port 465

HTTP-ALT
//default 591

IPP
//internet printing protocol
//default port 631

FTPS 
//default port 990

IMAPS
//default port 993

POP3S
//default port 995

MySQL
//default  port 3306
mysql -h ip -u user -p password

## RDP
//default port 3389 (TCP)

DOCKER
//default port 5000

SNMPSSH	
//default 5161	
//SNMP over SSH Transport Model 						
SNMPSSH-TRAP 	
//dafault 5162 	
//SNMP Notification over SSH Transport Model 	

## Pando-pub
7680/tcp
Legacy application [Pando](https://en.wikipedia.org/wiki/Pando_(application)) BitTorrent client and uses the BitTorrent protocol to transfer files.

## Burp Proxy
default port 8000

## Tomcat HTTP roxy
[[Apache-Tomcat]]
default port 8009

## Apache JServ Protocol
default  8009


## HTTP Alternate
default 8080


## References
[iana](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml)