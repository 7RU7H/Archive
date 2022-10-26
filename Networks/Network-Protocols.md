# Network Protocols

## 20/21 - FTP
File transfer protocol, client-server model
1. Port 20 for data
2. Port 21 for commands 
3. Can connect similar with telnet client with port number!
```bash
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

# If downloading files that are binaries
binary # prepare server for binary mode transfer
get x.exe

ls -la		list directory, sometimes ls DOES NOT WORK
get file
put file	upload files!
```

## 22 - SSH & SFTP - Submodule of ssh
Default port 22 - Secure File transfer protocol 
[[SSH-Cheatsheet]]
```
-i	access with private key
-L	local_port:remote_address:remote_port # for local port fowarding
-R	port:loca_address:local_port # For remote port forwarding 
-D	local_PORT # Dynamic port fowarding, creates sockets proxy on localhost
-N	Do not execute a remote command. Useful in for just forwardin ports
-p      port
```


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
Stands for Simple mail transfer protocol
For recon: [[SMTP-Recon-Cheatsheet]], for [[Mail-Operations]]
```bash
telnet $ip
nc -nv $IP
```

## 48 - WHOIS 


## 53 - DNS
Default port 53
[[DNS-Defined]], [[DNS-Recon-Active]], [[DNS-Recon-Passive]]

## 69 - TFTP
Stands for trivial file transfer protocol - UDP FTP
PXE Boot uses this Boot image retrieval/loading useful in [[Active-Directory-Footholding]]

## 79 - Finger 
[Finger](https://en.wikipedia.org/wiki/Finger_(protocol)) user information protocol are simple for the exchange of human-oriented status and user information. Use [pentestmonkey finger-user-enum.pl](https://pentestmonkey.net/tools/user-enumeration/finger-user-enum)

## 80 - HTTP
Default  port 80

[[Web-Hacking-Checklist]], [[Website-Recon]] and [[Web-App-Hacking-Methodology]].

## 110 - POP3
Generally port 110, Post Office Protocol 3 is used to download email from mail delivery agent.
Acronyms: mail transfer agent (MTA), mail delivery agent (MDA), mail submission agent (MSA), mail user agent (MUA).
```bash
MDA -- from MUA -(smtp)-> MSA/MTA -> SMTP -> MTA/MDA -(POP3/IMAP)-> MUA
# Connect
nc $ip 110
telnet $ip 110
# Once connected
USER 
PASS
STAT
LIST	list all message of USER 
RETR	return a message


USER admin
PASS admin

USER root
PASS root

USER root
PASS toor

# Once logged
list

```

## 111 (also 2049) - NFS
[[NFS-Recon]]
Ports 111 and 2049
Shared directory, mount those shares!
```bash
sudo showmount -e $ip
sudo mount $ip:/file/path /local/file/path

sudo mount -o port=1234 -t nfs $ip:/dir /tmp/local
# nolock maybe required for older systems
sudo mount -o nolock port=1234 -t nfs $ip:/dir /tmp/local

umount $ip:/local/file/path	
```

## 113 - IDENT

Identification/Authorization service. When a client program on your end contacts a remote server for services such as POP, IMAP, SMTP, IRC, FTP, etc. that remote server sends back a query to the IDENT port 113 asking for identification from your system

## 13(5,7-9), 445 -  NBT - SMB
Server Message Block protocol uses a client-server model. Client uses `smbclient` see [[SMB-Recon-Cheatsheet]]. SMB originally ran on top of NetBIOS using port 139. NetBIOS is an older transport layer that allows Windows computer to communicate on the same network. Later versions of SMB(after Windows 2000) use port 445 on top of a TCP stack, TCP allows for internet communication. NetBIOS over TCP/IP (NetBT) is Windows name resolution.

Port | Purpose
--- | ---
135(TCP) |  MSRPC;  DCOM is performed over RPC
137(TCP/UDP) | ..
138(UDP) | .. 
139(TCP) | netbios-ssn 
445(TCP) | microsoft-ds

## 143 - IMAP
//generally 143

## 389 - LDAP
Lightweight Directory Access Protocol
Default port 389
[[LDAP-Recon]]

## 443 - HTTPS
//internet messaging access protocol
//default port 443

## 445 - SMB
See 13(5,7-9) for legacy SMB 139 is the equivilent service port to 445

## 465 - SMTPS
//default port 

## 500 - ISAKMP
[Internet Security Association and Key Management Protocol](https://en.wikipedia.org/wiki/Internet_Security_Association_and_Key_Management_Protocol) default UDP port 500
Recon with `ike-scan`

## 515 LPD 
Line Printer Daemon

## 591- HTTP-ALT
//default 591

## 631 - IPP
Internet printing protocol default port 631

## 990 - FTPS 
FTPS default port 990

## 993 - IMAPS
IMAPS default port 993

## 995 - POP3S
[[Mail-Operations]]

## 2049 (also 111) - NFS
[[NFS-Recon]]
Ports 111 and 2049
Shared directory, mount those shares!
```bash
sudo showmount -e $ip
sudo mount $ip:/file/path /local/file/path

sudo mount -o port=1234 -t nfs $ip:/dir /tmp/local
# nolock maybe required for older systems
sudo mount -o nolock port=1234 -t nfs $ip:/dir /tmp/local

umount $ip:/local/file/path	
```

## 3128 - Squid
Squid is a caching and forwarding HTTP web proxy
[Hacktricks](https://book.hacktricks.xyz/network-services-pentesting/3128-pentesting-squid?q=3128)

## 3269 - Microsoft Global Catalog over SSL
Runs both tcp and udp
msft-gc-ssl, Microsoft Global Catalog over SSL (similar to port 3268, LDAP over SSL) (official)

## 3306 - MySQL
`mysql -h ip -u user -p`

## 3389 (TCP) - RDP
```bash
remmina
xfreerdp /u:$username /p:$Password /v:$IP
rdesktop $ip
```

## 5000 - Docker
See [[Intro-To-Docker]] and [[Docker-Hacking]] for more informationmation

SNMPSSH	
//default 5161	
//SNMP over SSH Transport Model 						
SNMPSSH-TRAP 	
//dafault 5162 	
//SNMP Notification over SSH Transport Model 	

## 5985-6 - WinRM
Windows Remote Management Protocol ports
See [[Evil-winrm-Cheatsheet]]

## Pando-pub
7680/tcp
Legacy application [Pando](https://en.wikipedia.org/wiki/Pando_(application)) BitTorrent client and uses the BitTorrent protocol to transfer files.

## Burp Proxy
Default port 8000, see [[Burpsuite-Helpsheet]]

## 8009 - Various
[[Apache-Tomcat]]'s default port 8009
Apache JServ Protocol



## 8080 - HTTP Alternate
default 8080

## 9000 - [Lots](https://www.speedguide.net/port.php?port=9000)
`FPM/FastCGI` which uses port 9000 by default. [FastCGI PHP-FPM exploit](https://gist.github.com/phith0n/9615e2420f31048f7e30f3937356cf75)


## 10000 - Webmin
[Webmin](https://webmin.com/)

## References
[iana](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml)
[speedguide](https://www.speedguide.net/port.php?)