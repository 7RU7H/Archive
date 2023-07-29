# Network Protocols Cheatsheet

## 20 & 21 - FTP

File transfer protocol, client-server model
- Control Connection - connection request - Port 21 for commands 
- Data Connection - post authenication, used for transferring data -  Port 20 for data
- Varienty of  clients: Telnet, Filezilla (Common IoC),  CuteFTP
```bash
wget -r ftp://[username]:[password]@[ip]/
ftp ip
# Active mode is used by client and server to negoiate authenication
-n 	prevent autologon
-v 	verbose server output

USER username
PASS password
SYST	# system		system info
PASV	# passive		enter passive mode - this is first command that is sent after auth
TYPE A	# type ascii	enter ASCII mode
ASCII   # Will perform the same as the above 
IMAGE   # Binary mode 
EBCDIC  # for EBCDIC character set
STAT	# status		give server status
LOCAL   # "Type L n" for machines that do not support 8-bit bytes transfer - n is byte size

# If (up/down)loading files that are binaries!
binary # prepare server for binary mode transfer
get x.exe

ls -la		list directory, sometimes ls DOES NOT WORK
get file
put file	upload files!
```


## 22 - SSH & SFTP - Submodule of ssh
Default port 22 - Secure File transfer protocol 
[[SSH-Cheatsheet]]



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

## 53 (TCP & UDP) - DNS/DNSSEC

[[DNS]], [[DNS-Active-Recon]], [[DNS-Recon-Passive]]

DNSSEC ensure possibility that a DNS response received is from the domain owner. Requires:
1. The DNS zone owner signs all DNS records using a private key.
2. The DNS zone publishes its public key

DNS EndPoint Mapper

Microsoft Azure expands on DNS see [[Azure-Administration-Azure-DNS]]

## 69 UDP - TFTP

Stands for trivial file transfer protocol - UDP FTP
PXE Boot uses this Boot image retrieval/loading useful in [[Active-Directory-Footholding]]
```bash
sudo apt install tftp
tftp $ip
? # Commands 
```


## 79 - Finger 

[Finger](https://en.wikipedia.org/wiki/Finger_(protocol)) user information protocol are simple for the exchange of human-oriented status and user information. Use [pentestmonkey finger-user-enum.pl](https://pentestmonkey.net/tools/user-enumeration/finger-user-enum)

## 80 - HTTP


[[Web-Hacking-Checklist]], [[Website-Recon]] and [[Web-App-Hacking-Methodology]].

## 88 - Kerberos
Found on the Domain Controller in Active Directory Network - see [[Active-Directory-Kerberos-Authentication-Defined]]

## 110 - POP3

Generally port 110, Post Office Protocol 3 is used to download email from mail delivery agent.
Acronyms: mail transfer agent (MTA), mail delivery agent (MDA), mail submission agent (MSA), mail user agent (MUA). POP3 is used to download email messages from the server to the client.
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

## 135 - RCP  & EPMAP

RPC encryption protocol of higher port number. See [[RPC-Recon]], use [[RPCClient-Cheatsheet]] and [[RPCClient-Usage]]

EPMAP allows launching procedures that are remotely hosted (bootstrap) through the distribution of an MS-RPC service’s IP address and protocol - [REF](https://documentation.stormshield.eu/SNS/v4/en/Content/User_Configuration_Manual_SNS_v4/Protocols/EPMAP_Protocol.htm)


## (137-9), 445 -  NBT - SMB

Server Message Block protocol uses a client-server model. Client uses `smbclient` see [[SMB-Recon-Cheatsheet]]. SMB originally ran on top of NetBIOS using port 139. NetBIOS is an older transport layer that allows Windows computer to communicate on the same network. Later versions of SMB(after Windows 2000) use port 445 on top of a TCP stack, TCP allows for internet communication. NetBIOS over TCP/IP (NetBT) is Windows name resolution.

Port | Purpose
--- | ---
135(TCP) |  MSRPC;  DCOM is performed over RPC
137(TCP/UDP) | ..
138(UDP) | .. 
139(TCP) | netbios-ssn 
445(TCP) | microsoft-ds

## 143 - IMAP

[Banner Grab](https://book.hacktricks.xyz/network-services-pentesting/pentesting-imap)
```bash
nc -nv <IP> 143
openssl s_client -connect <IP>:993 -quiet
```

## 389 - LDAP

Lightweight Directory Access Protocol - [[LDAP-Recon]]
LDAP Defaults:
plain text LDAP is port 389 
LDAP SSL is port 636 
LDAP connection to Global Catalog is port 3268
LDAP connection to Global Catalog over SSL is port 3269

## 443 - HTTPS

[[HTTP-Defined]]

## 445 - SMB

Widely using for file transfer in Windows AD and Azure Networking for File Shares and Azure Files 
See 13(5,7-9) for legacy SMB 139 is the equivilent service port to 445. 
- [[SMB-Recon-Cheatsheet]]
- [[Azure-Administration-Files]]

## 465 - SMTPS

Simple Mail Transfer Protocol Secure, not to be confused with SMTP with POP3, both are use in email communication. SMTP is an “Email Push Protocol” used to transfer email messages from the client to the server. [[Mail-Operations]]


## 464 Kpasswd5

Kerberos Change/Set password (official) - Indicative of DC 

## 500 - ISAKMP
[Internet Security Association and Key Management Protocol](https://en.wikipedia.org/wiki/Internet_Security_Association_and_Key_Management_Protocol) default UDP port 500
Recon with `ike-scan`, see [[IPsec]]

## 515 - LPD 
Line Printer Daemon

## 591- HTTP-ALT
//default 591

## 631 - IPP
Internet printing protocol default port 631

## 636 - LDAPS

Lightweight Directory Access Protocol over SSL - [[LDAP-Recon]]
LDAP Defaults:
plain text LDAP is port 389 
LDAP SSL is port 636 
LDAP connection to Global Catalog is port 3268
LDAP connection to Global Catalog over SSL is port 3269

## 873 - Rsync

[Rsync](https://wiki.archlinux.org/title/rsync) is an open source utility that provides fast incremental file transfer. Can transfer anonymously without credential - good for mirroring. 
```bash
rsync --list-only $ip::
rsync --list-only $ip::$share
rsync 3$ip::$share/$remotefile $copyfiletohost

```

## 990 - FTPS 

FTPS default port 990, which not to be confused with SFTP. FTPS is FTP with TLS.
- Control Connection - connection request
- Data Connection - post authenication, used for transferring data

## 993 - IMAPS

IMAPS default port 993, [Internet messaging access protocol](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol) used by email clients to retrieve messages from a mail server of TCP/IP

## 995 - POP3S
[[Mail-Operations]]

## 1883 - MQTT
[[MQTT]] 

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

## 2233 - Infocrypt

InfoCrypt Desktop is a Windows 95 or Windows NT software providing desktop to desktop security within a LAN or WAN. As it operates at the network layer, it is completely transparent to the user and will work with any application.


## 3128 - Squid
Squid is a caching and forwarding HTTP web proxy
[Hacktricks](https://book.hacktricks.xyz/network-services-pentesting/3128-pentesting-squid?q=3128)


## 3268 - Microsoft Global Catalog 

LDAP (Lightweight Directory Access Protocol (over SSL)) Defaults:  - [[LDAP-Recon]]
plain text LDAP is port 389 
LDAP SSL is port 636 

## 3269 (TCP/UDP) - Microsoft Global Catalog over SSL

- msft-gc-ssl, Microsoft Global Catalog over SSL (similar to port 3268, LDAP over SSL) (official)

LDAP (Lightweight Directory Access Protocol (over SSL)) Defaults:  - [[LDAP-Recon]]
plain text LDAP is port 389 
LDAP SSL is port 636  


## 3306 - MySQL

`mysql -h ip -u user -p`

## 3389 (TCP) - RDP

See [[RDP]] - Beware - On Windows 11, Network Level Authentication (NLA) is enabled by default for RDP connections.


## 4555 RSIP

See [[RSIP-Recon]] forwarding administration emails

## 5000 - Docker

See [[Docker]] and [[Docker-Hacking]] for more informationmation

## 5161 - SNMPSSH	 	
SNMP over SSH Transport Model 						

## 5162 SNMPSSH-TRAP 	
 	
SNMP Notification over SSH Transport Model 	

## 5353 - MultiCast DNS

## 5355 - LLMNR 
- [[Responder-Cheatsheet]] catches hashes from this port

## 5601 - Kibana

Kibana provides search and data visualization capabilities for data indexed in Elasticsearch. The service runs per default on port 5601

## 5900 - VNC 

[Virtual Network Computing](https://en.wikipedia.org/wiki/Virtual_Network_Computing) is a graphic desktop-sharing system that uses the [Remote Frame Buffer protocol (RFB)](https://en.wikipedia.org/wiki/RFB_protocol) to remotely control another [computer](https://en.wikipedia.org/wiki/Computer "Computer"). RDP software like Remmina can connect. [See redhat artical regarding screen sharing](https://www.redhat.com/sysadmin/vnc-screen-sharing-linux)


## 5985-6 - WinRM

Windows Remote Management Protocol ports
See [[Evil-winrm-Cheatsheet]]

## 6379 - Redis

Seee for Redis-cli a client for Redis database locally: [[Redis-cli-Cheatsheet]]

## 7680 - Pando-pub
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

## 9091-2 - ssl/xmltec-xmlmail | Citrix Netscaler


## 9389 - ADWS

Active Directory Web Services (ADWS), in Windows Server 2008 R2 and later, is a new Windows service that provides a Web service interface to Active Directory domains, Active Directory Lightweight Directory Services (AD LDS) instances, and Active Directory Database Mounting Tool instances that are running on the same server as ADWS.

## 10000 - Webmin

[Webmin](https://webmin.com/)

## 25672 - Erlang

Erlang is a programming language designed around distributed computing and will have a network port that allows other Erlang nodes to join the cluster. It uses a cookie. [Erlang-arce blogpost from Mubix](https://malicious.link/post/2018/erlang-arce/)

## 27017 - MongoDB


[[MongoDB]]

## References

[iana](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml)
[speedguide](https://www.speedguide.net/port.php?)
[Erlang-arce blogpost from Mubix](https://malicious.link/post/2018/erlang-arce/)