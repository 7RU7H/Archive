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


## Filters

Filter using "x contains keyword"
```c
tcp contains google
frame contains “(attachment|tar|exe|zip|pdf)” // File type
```

Filter by a timeframe:
```c
(frame.time >= "Sep 24, 2021 16:45:11") && (frame.time <= "Sep 24, 2021 16:45:30")
```

Filter by IP, src, dst, subnet, exclude ip.x
```c
ip // Show all IP Packets
// The ip.addr filters the traffic without considering the packet direction. 
ip.addr == 10.10.10.10 // show all packet containing this address
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

Http related
```c
http.request.method==GET
http.request.method==POST
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

#### Advanced Filtering

```c
$filter contains "IIS"
$filter matches "\.(php|html)" // keywords ".php" or ".html"
$filter in {80 443 8080} //in fields that have values 80, 443, 8080
$filter upper(http.server) contains "APACHE" // upper case conversion 
$filter lower(http.server) contains "apache" // lower case conversion 
$filter string(frame.number) matches "[12345]$" // Convert all framenumber fields to string value and list frames thtat end with 12345 
```

Save filters with `Bookmarks`, enter a filter, left click the blue flag icon and `Save this filter`; to use click the plus symbol on the far right handside of the window, next to the Arrow at the end of the `Apply a display filter input bar ... <Ctrl-/>.

Profiles `Edit -> Configuration Profiles... [Ctrl+Shift+A]`


## References

[Display Filter Reference](https://www.wireshark.org/docs/dfref/)
[Wireshark.org Wiki](https://wiki.wireshark.org/Home)
[Wireshark Official](https://www.wireshark.org/)
[Berkley Packet Filter](https://biot.com/capstats/bpf.html)
[David Bombal Youtube](https://www.youtube.com/watch?v=GMNOT1aZmD8)
[THM Wireshark Room Wireshark Basics](https://tryhackme.com/room/wiresharkthebasics)  
[THM Packet Operations Room](https://tryhackme.com/room/wiresharkpacketoperations)
[The Other THM Wireshark Room - Wireshark 101](https://tryhackme.com/room/wireshark)