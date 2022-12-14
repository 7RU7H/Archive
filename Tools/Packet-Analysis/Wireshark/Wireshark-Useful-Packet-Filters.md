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
ip.addr == 10.10.10.10
ip.src == 10.10.10.10
ip.dst == 10.10.10.10
ip.addr == 10.10.10.10/CIDR
!ip.addr == 10.10.10.10
```

Filter three-way-handsake
```c
tcp.flags.syn==1 or (tcp.seq==1 and tcp.ack==1 and tcp.len==0 and tcp.analysis.initial_rtt)
```

Filter by protocol
```c
dns
http
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


## References

[Display Filter Reference](https://www.wireshark.org/docs/dfref/)
[Wireshark.org Wiki](https://wiki.wireshark.org/Home)
[Wireshark Official](https://www.wireshark.org/)
[Berkley Packet Filter](https://biot.com/capstats/bpf.html)
[David Bombal Youtube](https://www.youtube.com/watch?v=GMNOT1aZmD8)
[THM Wireshark Room Wireshark Basics](https://tryhackme.com/room/wiresharkthebasics)  
[THM Packet Operations Room](https://tryhackme.com/room/wiresharkpacketoperations)
[The Other THM Wireshark Room - Wireshark 101](https://tryhackme.com/room/wireshark)