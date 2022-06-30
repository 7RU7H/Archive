# Wireshark

From [Wireshark Official](https://www.wireshark.org/) 
**Wireshark** *is the world’s foremost and widely-used network protocol analyzer. It lets you see what’s happening on your network at a microscopic level and is the de facto (and often de jure) standard across many commercial and non-profit enterprises, government agencies, and educational institutions. Wireshark development thrives thanks to the volunteer contributions of networking experts around the globe and is the continuation of a project started by Gerald Combs in 1998.*

**Wireshark** *has a rich feature set which includes the following:

-   *Deep inspection of hundreds of protocols, with more being added all the time*
-   *Live capture and offline analysis*
-   *Standard three-pane packet browser*
-   *Multi-platform: Runs on Windows, Linux, macOS, Solaris, FreeBSD, NetBSD, and many others*
-   *Captured network data can be browsed via a GUI, or via the TTY-mode TShark utility*
-   *The most powerful display filters in the industry*
-   *Rich VoIP analysis*
-   *Read/write many different capture file formats: tcpdump (libpcap), Pcap NG, Catapult DCT2000, Cisco Secure IDS iplog, Microsoft Network Monitor, Network General Sniffer® (compressed and uncompressed), Sniffer® Pro, and NetXray®, Network Instruments Observeuld like to make a more public and open source,r, NetScreen snoop, Novell LANalyzer, RADCOM WAN/LAN Analyzer, Shomiti/Finisar Surveyor, Tektronix K12xx, Visual Networks Visual UpTime, WildPackets EtherPeek/TokenPeek/AiroPeek, and many others*
-   *Capture files compressed with gzip can be decompressed on the fly*
-   *Live data can be read from Ethernet, IEEE 802.11, PPP/HDLC, ATM, Bluetooth, USB, Token Ring, Frame Relay, FDDI, and others (depending on your platform)*
-   *Decryption support for many protocols, including IPsec, ISAKMP, Kerberos, SNMPv3, SSL/TLS, WEP, and WPA/WPA2*
-   *Coloring rules can be applied to the packet list for quick, intuitive analysis*
-   *Output can be exported to XML, PostScript®, CSV, or plain text*

See [Wireshek Wiki for more](https://wiki.wireshark.org/Home)

## Introduction
For capture packets Wireshark uses the libraries [Libpcap](https://www.tcpdump.org/manpages/pcap.3pcap.html) on Linux from the maintainers of Tcpdump (see [[Tcpdump-Cheatsheet]] for more Tcpdump information), [Winpcap](https://www.winpcap.org/) on Windows, but is unmaintained as of 2018, see [Npcap](https://nmap.org/npcap/) as replacement for WinPcap and WinPcap Pro. With this we can reduce network traffic with `capture filters` to define what we want to capture -> `capture engine` tuld like to make a more public and open source,o capture the specified network traffic -> and `display filters` to make visible only the ouput the relevant with `filters` as commands.

## Capture filters
Filter by interface discard any from unselected interfaces like Display Filters uses the [Berkley Packet Filter](https://biot.com/capstats/bpf.html) syntax. 

## Great GUI tricks

The most import possible trick is `Right Click <Packet Line> -> Follow -> <Stream Type>`, which allow you to follow the traffic from one client and server connection of `TCP/UDP/SSL/HTTP stream` in a seperate GUI window, rather the line by line manually packet by packet.


## Useful Display Filters
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
[Miguel Sampaio da Veiga](https://medium.com/hacker-toolbelt/wireshark-filters-cheat-sheet-eacdc438969c)
[Wireshark.org Wiki](https://wiki.wireshark.org/Home)
[Wireshark Official](https://www.wireshark.org/)
[Winpcap](https://www.winpcap.org/)
[Berkley Packet Filter](https://biot.com/capstats/bpf.html)