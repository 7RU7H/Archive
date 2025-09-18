# Network Protocols 

This is a Cheatsheet of Network Protocols to then lookup details by following links

## TCP - 20 & 21 - FTP

File transfer protocol, client-server model - visit [[FTP]]

## TCP - 22 - SSH & SFTP - Sub-module of ssh
Default port 22 - Secure File transfer protocol - [[SSH-Cheatsheet]]

## TCP - 23 - TELNET

General port 23, Telnet is cleartext and insecure!
```bash
telnet $ip
# THEN
GET / HTTP/1.1 
# OR
GET /page.html HTTP/1.1
#Will get telnet get you cleartext info on servers with exposed telnet ports
```

## TCP - 25 - SMTP

Stands for Simple mail transfer protocol
For recon: [[SMTP-Recon-Cheatsheet]], for [[Mail-Operations]]
```bash
telnet $ip
nc -nv $IP
```

## TCP - 48 - WHOIS 

## TCP/UDP  - 53 - DNS/DNSSEC

[[DNS]], [[DNS-Active-Recon]], [[DNS-Recon-Passive]]

DNSSEC ensure possibility that a DNS response received is from the domain owner. Requires:
1. The DNS zone owner signs all DNS records using a private key.
2. The DNS zone publishes its public key

DNS EndPoint Mapper

Microsoft Azure expands on DNS see [[Azure-Administration-Azure-DNS]]

## UDP - 67-8 DHCP

[Wikipedia Dynamic Host Configuration Protocol](https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol): 
- [[DHCP]] Client 67
- [[DHCP]] Client 68 
## UDP - 69  - TFTP

Stands for [trivial file transfer protocol](https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol) - UDP FTP
PXE Boot uses this Boot image retrieval/loading useful in [[Active-Directory-Footholding]]
```bash
sudo apt install tftp
tftp $ip
? # Commands 
```


## TCP - 79 - Finger 

[Finger](https://en.wikipedia.org/wiki/Finger_(protocol)) user information protocol are simple for the exchange of human-oriented status and user information. Use [pentestmonkey finger-user-enum.pl](https://pentestmonkey.net/tools/user-enumeration/finger-user-enum)

## TCP - 80 - HTTP

[[Web-Hacking-Checklist]], [[Website-Recon]] and [[Web-App-Hacking-Methodology]].

## TCP - 88 - Kerberos
Found on the Domain Controller in Active Directory Network - see [[Active-Directory-Kerberos-Authentication-Defined]]

## TCP - 110 - POP3

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

## TCP - 111 (also 2049) - NFS
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

## TCP - 113 - IDENT

Identification/Authorization service. When a client program on your end contacts a remote server for services such as POP, IMAP, SMTP, IRC, FTP, etc. that remote server sends back a query to the IDENT port 113 asking for identification from your system

## TCP - 135 - RCP  & EPMAP

RPC encryption protocol of higher port number. See [[RPC-Recon]], use [[RPCClient-Cheatsheet]] and [[RPCClient-Usage]]

EPMAP allows launching procedures that are remotely hosted (bootstrap) through the distribution of an MS-RPC service’s IP address and protocol - [REF](https://documentation.stormshield.eu/SNS/v4/en/Content/User_Configuration_Manual_SNS_v4/Protocols/EPMAP_Protocol.htm)


## TCP - (137-9), 445 -  NBT - SMB

Server Message Block protocol uses a client-server model. Client uses `smbclient` see [[SMB-Recon-Cheatsheet]]. SMB originally ran on top of NetBIOS using port 139. NetBIOS is an older transport layer that allows Windows computer to communicate on the same network. Later versions of SMB(after Windows 2000) use port 445 on top of a TCP stack, TCP allows for internet communication. NetBIOS over TCP/IP (NetBT) is Windows name resolution.

Port | Purpose
--- | ---
135(TCP) |  MSRPC;  DCOM is performed over RPC
137(TCP/UDP) | ..
138(UDP) | .. 
139(TCP) | netbios-ssn 
445(TCP) | microsoft-ds

## TCP - 143 - IMAP

[Banner Grab](https://book.hacktricks.xyz/network-services-pentesting/pentesting-imap)
```bash
nc -nv <IP> 143
openssl s_client -connect <IP>:993 -quiet
```

## TCP - 389 - LDAP

Lightweight Directory Access Protocol - [[LDAP-Recon]]
LDAP Defaults:
plain text LDAP is port 389 
LDAP SSL is port 636 
LDAP connection to Global Catalog is port 3268
LDAP connection to Global Catalog over SSL is port 3269

## TCP - 443 - HTTPS

[[HTTP]]

## TCP - 445 - SMB

Widely using for file transfer in Windows AD and Azure Networking for File Shares and Azure Files 
See 13(5,7-9) for legacy SMB 139 is the equivilent service port to 445. 
- [[SMB-Recon-Cheatsheet]]
- [[Azure-Administration-Files-And-File-Sync]]

## TCP - 465 - SMTPS

Simple Mail Transfer Protocol Secure, not to be confused with SMTP with POP3, both are use in email communication. SMTP is an “Email Push Protocol” used to transfer email messages from the client to the server. [[Mail-Operations]]


## TCP - 464 Kpasswd5

Kerberos Change/Set password (official) - Indicative of DC 

## TCP - 500 - ISAKMP
[Internet Security Association and Key Management Protocol](https://en.wikipedia.org/wiki/Internet_Security_Association_and_Key_Management_Protocol) default UDP port 500
Recon with `ike-scan`, see [[IPsec]]

## TCP - 515 - LPD 
Line Printer Daemon

## TCP - 591- HTTP-ALT

Default port 591

## TCP - 631 - [[IPP]]

Internet Printing Protocol default port 631

## TCP - 636 - LDAPS

Lightweight Directory Access Protocol over SSL - [[LDAP-Recon]]
LDAP Defaults:
plain text LDAP is port 389 
LDAP SSL is port 636 
LDAP connection to Global Catalog is port 3268
LDAP connection to Global Catalog over SSL is port 3269

## TCP - 873 - Rsync

[Rsync](https://wiki.archlinux.org/title/rsync) is an open source utility that provides fast incremental file transfer. Can transfer anonymously without credential - good for mirroring. 
```bash
rsync --list-only $ip::
rsync --list-only $ip::$share
rsync 3$ip::$share/$remotefile $copyfiletohost

```

## TCP - 990 - FTPS 

FTPS default port 990, which not to be confused with SFTP. FTPS is FTP with TLS.
- Control Connection - connection request
- Data Connection - post authenication, used for transferring data

## TCP - 993 - IMAPS

IMAPS default port 993, [Internet messaging access protocol](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol) used by email clients to retrieve messages from a mail server of TCP/IP

## TCP - 995 - POP3S
[[Mail-Operations]]

## 1521,1522-1529 - Oracle TNS Listener

[SnowWight Hackdocs](https://github.com/TheSnowWight/hackdocs/blob/master/pentesting/1521-1522-1529-pentesting-oracle-listener/README.md) updated
```bash
tnscmd10g status-p 1521 -h <IP> #The SID are inside: SERVICE=(SERVICE_NAME=<SID_NAME>)
```

See [[Oracle-TNS]] for hacking


## TCP - 1723 - 
## TCP - 1883 - MQTT
[[MQTT]] 

## TCP - 2049 (also 111) - NFS
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

## TCP - 2233 - Infocrypt

InfoCrypt Desktop is a Windows 95 or Windows NT software providing desktop to desktop security within a LAN or WAN. As it operates at the network layer, it is completely transparent to the user and will work with any application.


## TCP - 3128 - Squid
Squid is a caching and forwarding HTTP web proxy
[Hacktricks](https://book.hacktricks.xyz/network-services-pentesting/3128-pentesting-squid?q=3128)


## TCP - 3268 - Microsoft Global Catalog 

LDAP (Lightweight Directory Access Protocol (over SSL)) Defaults:  - [[LDAP-Recon]]
plain text LDAP is port 389 
LDAP SSL is port 636 

## TCP/UDP - 3269  - Microsoft Global Catalog over SSL

- msft-gc-ssl, Microsoft Global Catalogue over SSL (similar to port 3268, LDAP over SSL) (official)

LDAP (Lightweight Directory Access Protocol (over SSL)) Defaults:  - [[LDAP-Recon]]
plain text LDAP is port 389 
LDAP SSL is port 636  


## TCP - 3306 - MySQL

[[MySQL-Cheatsheet]], [[MySQL-Hacking]] and [[MySQL-SQL-Injection-Cheatsheet]]
`mysql -h ip -u user -p`

## TCP - 3389 - RDP

See [[RDP]] - Beware - On Windows 11, Network Level Authentication (NLA) is enabled by default for RDP connections.


## TCP - 4555 RSIP

See [[RSIP-Recon]] forwarding administration emails

## TCP - 5000 - Docker

See [[Docker]] and [[Docker-Hacking]] for more informationmation

## TCP - 5161 - SNMPSSH	 	
SNMP over SSH Transport Model 						

## TCP - 5162 SNMPSSH-TRAP 	
 	
SNMP Notification over SSH Transport Model 	

## TCP - 5353 - MultiCast DNS

## TCP - 5355 - LLMNR 
- [[Responder-Cheatsheet]] catches hashes from this port

## TCP - 5432 - PostgreSQL

[[PostgreSQL]]


## TCP/UDP - 5060-1 - SIP

[[SIP]] TCP or UDP for unencrypted signalling or 5061 for TLS

## TCP - 5601 - Kibana

Kibana provides search and data visualization capabilities for data indexed in Elasticsearch. The service runs per default on port 5601

## TCP - 5900 - VNC 

[Virtual Network Computing](https://en.wikipedia.org/wiki/Virtual_Network_Computing) is a graphic desktop-sharing system that uses the [Remote Frame Buffer protocol (RFB)](https://en.wikipedia.org/wiki/RFB_protocol) to remotely control another [computer](https://en.wikipedia.org/wiki/Computer "Computer"). RDP software like Remmina can connect. [See redhat artical regarding screen sharing](https://www.redhat.com/sysadmin/vnc-screen-sharing-linux)
## TCP - 5985-6 - [[WinRM]]

Windows Remote Management Protocol ports 5985-6
See [[evil-winrm-Cheatsheet]], [[Crackmapexec-Cheatsheet]]
- Port 5985 for [[HTTP]] transport 
- Port 5986 for [[HTTPS]] Transport.
## TCP - 6379 - Redis

Seee for Redis-cli a client for Redis database locally: [[Redis]]

## TCP - 7680 - Pando-pub
Legacy application [Pando](https://en.wikipedia.org/wiki/Pando_(application)) BitTorrent client and uses the BitTorrent protocol to transfer files.

## TCP - Burp Proxy
Default port 8000, see [[BurpSuite]]

## TCP - 8009 - Various
[[Apache-Tomcat]]'s default port 8009
Apache JServ Protocol


## TCP - 8080 - HTTP Alternate
default 8080

## TCP - 9000 - [Lots](https://www.speedguide.net/port.php?port=9000)
`FPM/FastCGI` which uses port 9000 by default. [FastCGI PHP-FPM exploit](https://gist.github.com/phith0n/9615e2420f31048f7e30f3937356cf75)

## TCP - 9091-2 - ssl/xmltec-xmlmail | Citrix Netscaler


## TCP - 9389 - ADWS

Active Directory Web Services (ADWS), in Windows Server 2008 R2 and later, is a new Windows service that provides a Web service interface to Active Directory domains, Active Directory Lightweight Directory Services (AD LDS) instances, and Active Directory Database Mounting Tool instances that are running on the same server as ADWS.

## TCP - 10000 - Webmin

[Webmin](https://webmin.com/)

## TCP - 25672 - Erlang

Erlang is a programming language designed around distributed computing and will have a network port that allows other Erlang nodes to join the cluster. It uses a cookie. [Erlang-arce blogpost from Mubix](https://malicious.link/post/2018/erlang-arce/)

## TCP - 27017 - MongoDB


[[MongoDB]]

## References

[iana](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml)
[speedguide](https://www.speedguide.net/port.php?)
[Erlang-arce blogpost from Mubix](https://malicious.link/post/2018/erlang-arce/)
[Wikipedia trivial file transfer protocol](https://en.wikipedia.org/wiki/Trivial_File_Transfer_Protocol)