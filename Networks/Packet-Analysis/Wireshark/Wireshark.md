# Wireshark
[Wireshark wiki](https://en.wikipedia.org/wiki/Wireshark)

## Useful filters

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
```c
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
[Miguel Sampaio da Veiga](https://medium.com/hacker-toolbelt/wireshark-filters-cheat-sheet-eacdc438969c)

