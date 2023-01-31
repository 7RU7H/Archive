# Useful Wireshark Packet Filters

## Filter Types

**Filter** | **Type Description**
--- | ---
**Capture Filters** | Used to save only a specific part of the traffic, set before capturing traffic and not changeable during the capture. 
**Display Filters** | Used to investigate packets by reducing the number of visible packets, and it is changeable during the capture.

Packet Filter ToolBar

- Packet filters are defined in lowercase
- Packet filters can automcomplete 
- Detail is repressented by a dot
- Three-colour representation:
	- Green = Valid
	- Red = Invalid
	- Yellow = Warning - works, but unreliable

Capture Syntax:

Scope: host, net, port and portrange.
Direction: src, dst, src or dst, src and dst,
Protocol: ether, wlan, ip, ip6, arp, rarp, tcp and udp.

Official [Display Filter Reference](https://www.wireshark.org/docs/dfref/)

Comparison Operators
**English** | **C-Like** | **Description**
--- | --- | ---
eq | == | Equal
ne | != | Not equal
gt | > | Greater than
lt | < | Less Than
ge | >= |Greater than or equal to
le | <= | Less than or equal to

Logical Expressions
**English** | **C-Like** | **Description**
--- | --- | ---
and | && | Logical AND
or | \|| | Logical OR
not | ! | logical NOT

#### Meta-workflows

Find locations of destination file path of a download file from a GET request.
```c
Follow HTTP stream -> Find: "C:\"
```

#### Filtering

Filter using "FILTER VERB keyword"
```c
$filter contains "IIS"
$filter matches "\.(php|html)" // keywords ".php" or ".html"
$filter in {80 443 8080} //in fields that have values 80, 443, 8080
$filter upper(http.server) contains "APACHE" // upper case conversion 
$filter lower(http.server) contains "apache" // lower case conversion 
$filter string(frame.number) matches "[12345]$" // Convert all framenumber fields to string value and list frames thtat end with 12345 
tcp contains google
frame contains “(attachment|tar|exe|zip|pdf)” // File type

```

Save filters with `Bookmarks`, enter a filter, left click the blue flag icon and `Save this filter`; to use click the plus symbol on the far right handside of the window, next to the Arrow at the end of the `Apply a display filter input bar ... <Ctrl-/>.

Profiles `Edit -> ConfiguraFollow HTTP stream -> Find: "C:\"tion Profiles... [Ctrl+Shift+A]`

Filter by a timeframe:
```c
(frame.time >= "Sep 24, 2021 16:45:11") && (frame.time <= "Sep 24, 2021 16:45:30")
```

Filter by IP, src, dst, subnet, exclude ip.x
```c
ip // Show all IP Packets
// The ip.addr filters the traffic without consiFollow HTTP stream -> Find: "C:\"dering the packet direction. 
ip.addr == 10.10.10.10 // show all packet coFollow HTTP stream -> Find: "C:\"ntaining this address
ip.addr == 10.10.10.10/24 // show all packet containing this subnet
// The ip.src/ip.dst filters the packet depending on the packet direction.
ip.src == 10.10.10.10 // Show packets originating from this IP
ip.dst == 10.10.10.10 // Show packets destined for this IP
ip.addr == 10.10.10.10/CIDR
!ip.addr == 10.10.10.10
```

Filter three-way-handsake
```c
tcp.flags.syn==1 or (tcp.seq==1 and tcp.ack==1 and tcp.len==0 and tcp.analysis.initial_rtt)
```

Filter by protocol
```c
tcp.port == 80 // TCP with port 80
udp.srcport == 53 // udp packets originating from 53 
tcp.dstport == 4444 // Tcp packets destined for 4444
dns
dns.flags.response == 0 // Show all DNS requests 
dns.flag.response == 1 // Show all DNS responses
dns.qry.type == 1 // DNS "A" records
http
http.request.method == "GET" // filter by request method
http.response.code == 200 // packets with HTTP response code 200
ftp
arp
ssh
telnet
icmp
!(arp or icmp or dns) // filter broadcast traffic
```


Filter by user agent
```c
http.user_agent contains Firefox
!http.user_agent contains || !http.user_agent contains Chrome
```

SSL Traffic filter:
```c*
tcp.port==443
// Client Hello:
ssl.handshake.type == 1
// Server Hello:
ssl.handshake.type == 2
// NewSessionTicket:
ssl.handshake.type == 4
// Certificate:
ssl.handshake.type == 11
// CertificateRequest
ssl.handshake.type == 13
// ServerHelloDone:
ssl.handshake.type == 14
```

Malspam basic filter:
```c
(http.request or tls.handshake.type eq 1) and !(ssdp)

smtp based traffic with the "MAIL FROM" command filter 
smtp.req.parameter contains "FROM"
```

Detecting SYN Floods
```c
tcp.flags.syn == 1 and tcp.flags.ack == 0
```

#### Spot NMAP or TCP/UDP packet manipulation

[[Nmap-Cheatsheet]] is industry-standard port scan that won't be used by in any [[Red-Team-Tooling]] arsenal. This is due to it have a packet header stating that it is a Nmap packet and even if a script kiddie used nmap and tuned to be stealthier here are filter to spot it:
```c
tcp
udp
// SYN flags only
tcp.flags == 2 
tcp.flags.syn == 1
// ACK flags only
tcp.flags == 16 
tcp.flags.ack == 1
// SYN, ACK flags set
tcp.flags == 18
(tcp.flags.syn == 1) and (tcp.flags.ack == 1)
// RST flags only
tcp.flags ==SYNTAX 4 
tcp.flags.reset == 1
// RST, ACK flags set
tcp.flags == 20
(tcp.flags.reset == 1) and (tcp.flags.ack == 1)
// FIN flags only
tcp.flags == 1 
tcp.flags.fin == 1
// Spot anomylous patterns in big capture files 
// Given a window.size Win=8192 means 8192 bytes of data server can recieve without requiring an acknowledgement
// TCP connect scans:
tcp.flags.syn == 1 and tcp.flags.ack == 0 and tcp.window_size > 1024
//
tcp.flags.syn ==1 and tcp.flags.ack == 0 and tcp.window_size <= 1024
// For UDP patterns
// There are no prompts to ports, ICMP error for close ports
icmp.type == 3 and icmp.code == 3
```

[Understanding Windows.Size](http://www.freekb.net/Article?id=939)

#### Detecting ARP Poisoning/Spoofing

[[ARP-Protocol]] is the technology responsible for allowing devices to identify themselves on a network. ARP Poisoning/Spoofing or MITM attack involves network jamming/maniuplation by sending malicious ARP packets to a default gateway to manipulated the IP to MAC address table to sniff the traffic of a target host. Initial detection starts with identifing duplicate MAC address usage where one IP address pretends to be the gateway address

```c
arp // Global search
arp.opcode == 1 // ARP requests
arp.opcode == 2 // ARP responses
arp.dst.hw_mac == 00:00:00:00:00 // destination mac address
arp.duplicate-address-detected or arp.duplicate-address-frame // Hunt ARP poisoning detection
((arp) && (arp.opcode == 1)) && (arp.src.hw_mac == $target_mac_address) // Hunt ARP flooding detection
```

#### DHCP

```c
dhcp // same bootp
bootp // same as dhcp
dhcp.option.dhcp == 3 // Request - hostname information
dhcp.option.dhcp == 5 // ACK - accepted requests
dhcp.option.dhcp == 6 // NAK - denied requests
dhcp.option.dhcp == 12 // DHCP request hostname
dhcp.option.dhcp == 50 // Requested IP address
dhcp.option.dhcp == 51 // Requested IP lease time
dhcp.option.dhcp == 61 // DHCP request Client MAC address


dhcp.option.hostname contains "keyword" // DHCP Requestion
dhcp.option.domain_name contain "keyword"
```

#### NetBIOS (NBNS)

```c
nbns // Global search
nbns.name contains "keyword" // Check info field!
```

#### Kerberos

A overview of some the attacks against kerberos are found in [[Attacking-Kerberos]]
```c
// Some hostnames contain $ in AD
kerberos // global search
kerberos.CNameString contains "keyword"
kerberos.CNameString and !(kerberos.CNameString contains "$") 
kerberos.pvno == 5 //version number
kerberos.realm contains ".org" // Domain tll for generate ticket
kerberos.SNameString == "krbtg" // Service and domain name for generate ticket 
kerberos.addresses // Client IP address and NetBIOSker
``` 

#### DNS

Detect DNS Tunnelling occus post exploitation phase of attack chain the indications of [[Data-Exfiltration-Over-DNS]]:
- subdomain names that are actually the data being exfiltrated

#### ICMP

Internet Control Message Protocol (ICMP) is designed for diagnosing and reporting network communication issues. It uses raw sockets not ports. Detecting ICMP Tunnelling (Using ICMP to tunnel another protocol data) occus post exploitation phase of attack chain. Indicatations of  [[Data-Exfiltration-Over-ICMP]]:
- Large packet size 
- Large volume of ICMP traffic
```c
icmp
data.len > 64 and icmp
```

Migitate
- Block custom ICMP packet creation and usage over a specific size at host level
- Block large, outbound ICMP traffic network level with Firewall rules.  


#### FTP 

This protocol is potentially an attack vector for MITM, Credenital stealing and unauthorized access, [[Phishing]], Malware planting, and Data Exfiltration - [[Data-Exfiltration-Defined]]. Considerations as to detecting malicious FTP traffic:
- Commands that alter file system
- Bruteforcing


For [[FTP-Response-Codes]]
```c
ftp 
// x1x series: information request responses 
// x2x series: connection messages
// x3x series authenication messages
// x4x Unspecified as of RFC 959
// x5x File system
// 200 is command success
ftp.response.code == 200
ftp.request.command == "$CMD"
ftp.request.arg == "password"

// Detect Bruteforce
ftp.response.code == 530
(ftp.response.code == 530) and (ftp.response.arg contains "username")
(ftp.request.command == "PASS") and (ftp.request.arg contains "password")
```

#### HTTP

Consider reviewing [[HTTP-Defined]] as [[Phishing]] pages, web attacks - [[Web-Hacking-Checklist]], [[Data-Exfiltration-Over-HTTP-and-HTTPS]] and C2 traffic is something http(s) - [[C2-Matrix]]. Generally with web attack detection it is about understanding where  and what data is being trafficed to the potential vulnerable web server by understanding the attack.

[[HTTP-Response-codes]] - https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
```c
http.request.method == "GET"
http.request.method == "POST" 
http.response.code == $INT // Know you codes - errors are used in recon!
http.user_agent contains ""
http.request.uri contains "admin"
http.request.full_uri contains "admin" //more complete info than the above
http.server 
http.host 
http.connection == "Keep-Alive"
data-text-lines contains "keyword"

// detection based on tool signatures
// Beware of bypassing by altering slight naming   
(http.user_agent contains "sqlmap") or (http.user_agent contains "Nmap") or (http.user_agent contains "Wfuzz") or (http.user_agent contains "Nikto")
// Mozlila or Gooogle
``````

Log4J Analysis
```c
http.request.method == "POST"
(ip contains "jndi") or ( ip contains "Exploit")
(frame contains "jndi") or ( frame contains "Exploit")
(http.user_agent contains "$") or (http.user_agent contains "==")
```

## References

[Display Filter Reference](https://www.wireshark.org/docs/dfref/)
[Wireshark.org Wiki](https://wiki.wireshark.org/Home)
[Wireshark Official](https://www.wireshark.org/)
[Berkley Packet Filter](https://biot.com/capstats/bpf.html)
[David Bombal Youtube](https://www.youtube.com/watch?v=GMNOT1aZmD8)
[THM Wireshark Room Wireshark Basics](https://tryhackme.com/room/wiresharkthebasics)  
[THM Packet Operations Room](https://tryhackme.com/room/wiresharkpacketoperations)
[The Other THM Wireshark Room - Wireshark 101](https://tryhackme.com/room/wireshark)
[Understanding Windows.Size](http://www.freekb.net/Article?id=939)
