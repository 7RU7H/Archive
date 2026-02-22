# Wireshark


I actively recommend Wireshark as personally it help me really understand [[Network-Protocols]],[[Network-Protocols-Hub]] and [[TCP-IP-Model]]  and I highly recommend it.

## Introduction

For capture packets Wireshark uses the libraries [Libpcap](https://www.tcpdump.org/manpages/pcap.3pcap.html) on Linux from the maintainers of Tcpdump (see [[Tcpdump-Cheatsheet]] for more Tcpdump information), [Winpcap](https://www.winpcap.org/) on Windows, but is unmaintained as of 2018, see [Npcap](https://nmap.org/npcap/) as replacement for WinPcap and WinPcap Pro. With this we can reduce network traffic with `capture filters` to define what we want to capture -> `capture engine` told like to make a more public and open source,o capture the specified network traffic -> and `display filters` to make visible only the ouput the relevant with `filters` as commands. From [Wireshark Official](https://www.wireshark.org/) 
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

See [Wireshark Wiki for more](https://wiki.wireshark.org/Home)

THM Golden Rule: *"The golden rule mentioned in the previous room is valid in this section; you can right-click and filter the event of interest!"*


## For Just Useful Display Filters

Found here: [[Wireshark-Useful-Packet-Filters]]


## Use cases
Want a GUI with quick filters instead of [[Tcpdump-Cheatsheet]] and [[Bash]]?
-   Decrypting SSL and TLS Traffic: [David Bombal Youtube](https://www.youtube.com/watch?v=GMNOT1aZmD8)
-   Detecting and troubleshooting network problems, such as network load failure points and congestion.
-   Detecting security anomalies, such as rogue hosts, abnormal port usage, and suspicious traffic.
-   Investigating and learning protocol details, such as response codes and payload data.
-   Create Firewall rules on the for various vendors from a couple of clicks 

```bash
# Dumps the TLS keys to the `ssl-key.log`
chromium --ssl-key-log-file=~/ssl-key.log` Dumps the TLS keys to the `ssl-key.log`
```
## Capture filters
Filter by interface discard any from unselected interfaces like Display Filters uses the [Berkley Packet Filter](https://biot.com/capstats/bpf.html) syntax. 

## GUI Breakdown
Regular Toolbar:
![Toolbar](wireshark-toolbar.png)

The display filter query with filter selection:
![DisplayFilter](wireshark-displayfilter.png)

Enter a capture filter and interface to capture on selection:
![Capture](wireshark-capture.png)

Tool status, profile and numeric packet information:
![Statusbar](wireshark-statusbar.png)

Here is where your packets are listed, more inmportant following the stream and 
[Packetlist](wireshark-packetlist.png)

Packet details - Great place to look into [[OSI-Model]] or [[Network-Protocols-Hub]] very helpful for learning, by looking around.
![Packetdetails](wireshark-packet-detail.png)

Packet bytes are displayed in hex on the left and ascii on the right
![Packetbytes](wireshark-packetbytes.png)

Start button to start capturing:
![StartButton](wireshark-start.png)

Red square to stop and green fin button to restart the capture.
![Stop](wireshark-stop.png)

## Great GUI tricks and Packet Navigation

TL;DR - Follow packets and learn filter logic

#### Import TLS certificates
`File -> Preferences -> Protocols -> TLS `

#### Prepared Filters
A Glossary exist under `Analyze -> Display Filter Expression`; it has a search bar for quality of life.

#### Colouring 
Custom colouring can be can be set by `View -> Coloring Rules...`

#### Merge PCAP Files
To combine multiple .pcap file into one single file `File -> Merge`.

#### View File Details
`Statistics -> Capture File Properties`

#### Finding Packets
- Search packets `Go (Dropdown) -> "Go to packet..."` or `Ctrl + G`
- Finding packets `Edit (Dropdown) -> Find Packets` or `Ctrl + F`

#### Marking Packets
Mark packets `Edit (Dropdown) -> Mark/Unmark packets` or `Ctrl + M`, Next marked packet `Ctrl + Shift + N` and Previous marked packet  `Ctrl + Shift + B`.

#### Packet Comments
Add comments to packets `Edit (Dropdown) -> Packet Comment...` or `Ctrl + Alt + C`

#### Export Packets,
Siphon off packet data to a file
`File -> Export Specified Packets`

#### Export Object (Files) - Arctifacts
If want to transform packet data in to files, use export! Export objects `File -> Export Objects -> <protocol stream>`  can extract files transfer through the wire.

#### Time Display Format
Change displayed time format `View (Dropdown) -> Time Display Format -> <formating option>`

#### Expert Info
Beware of false positives/negatives `Analyze Information -> Expert Information `

#### Geolocation mapping for Source and Destination Addresses
Wireshark supports MaxMind databases, and the latest versions of the Wireshark come configured MaxMind DB resolver.
`Edit -> Preferences -> Name Resolution -> MaxMind database directories"` 

#### Packet Filtering
See [[Wireshark-Useful-Packet-Filters]]
- Apply as filter - applies filter after choice: `Right-Click <highlighted packets> Or Analyze (Dropdown) -> Apply as filter`
- Conversation filter `Right-Click <highlighted packets> Or Analyze (Dropdown) -> Conversational filter` 
- Colourise Conversation `View (Dropdown) -> Colourise Conversaation -> (Reset - if required)`
- Prepare filter - applies filter immediately: `Right-Click -> Prepare as Filter -> <logical selection>`
- Apply as Column `Right-click -> Analyse -> Apply as Column` - helpful when analysing specific field
- The most import possible trick is `Right Click <Packet Line> -> Follow -> <Stream Type>`, which allow you to follow the traffic from one client and server connection of `TCP/UDP/SSL/HTTP stream` in a seperate GUI window, rather the line by line manually packet by packet.``

#### Default Coloring

Severity | Colour | Info
--- | --- | ---
Chat | Blue | Information on usual workflow.  
Note | Cyan | Notable events like application error codes.
Warn | Yellow | Warnings like unusual error codes or problem statements.  
Error | Red | Problems like malformed packets.

Group | Info | Group | Info 
--- | --- | --- | ---
Checksum | Checksum errors. | Deprecated | Deprecated protocol usage.
Comment | Packet comment detection. | Malformed | Malformed packet detection.


## Packet Filtering 

Wireshark Cheatsheet for [[Wireshark-Useful-Packet-Filters]].


## Packet Dissection
[RFTM](https://github.com/boundary/wireshark/blob/master/doc/README.dissector)
- **The Frame (Layer 1):** Frame/packet details specific to the Physical layer of the OSI model.
- **Source MAC (Layer 2):** Displays source and destination MAC Addresses; from the Data Link layer of the OSI model.
- **Source IP (Layer 3):** Displays source and destination IPv4 Addresses; from the Network layer of the OSI model.
- **Protocol (Layer 4):** Displays details of the protocol used (UDP/TCP) and source and destination ports; from the Transport layer of the OSI model.
- **Protocol Errors:** Continuation of the 4th layer, shows specific segments from TCP that needed to be reassembled.
- **Application Protocol (Layer 5):** This will show details specific to the protocol used, such as HTTP, FTP,  and SMB. From the Application layer of the OSI model.
- **Application Data:** This extension of the 5th layer can show the application-specific data.

## Statistics

From the `Statistcs` drop down:
- Resolved Addresses - identifies IP addresses and DNS names within the capture file
- Protocol Hierarchy - tree view based on packet counters and percentages 
- Conversations - display traffic from two specific endpoints formatted: ethernet, 
  Ipv4, IPv6, TCP and UDP - the number is display next to protocol name in tab
- Endpoints - simiilar to converations provides unique information for ethernet, 
  Ipv4, IPv6, TCP and UDP - resolving MAC address for known manufacturer's transport names, network IP addresses, VLAN IDs, etc
	- Geolocation
	- Organisation
	- AS numbers
- IPv4 and 6 Statistics - provide information per protocol
- DNS - tree view of packet counter and percentages of DNS protocol usage
- HTTP - tree view of packet counter and percentages of HTTP

## Tools

#### Filter out the Tools with Plain Text Credentials

`Tools -> Credentials`

#### Firewall ACL Rules

`Select a Packet -> Tools -> Firewall ACL Rules -> Dropdown of Rule type`

-   Netfilter (iptables)
-   Cisco IOS (standard/extended)
-   IP Filter (ipfilter)
-   IPFirewall (ipfw)
-   Packet filter (pf)
-   Windows Firewall (netsh new/old format)

#### Decrypt WIFI

Similarly to [[WiFi-Hacking]] tool like `air-x-ng` series you can crack some WIFI as [Gh05t-1337](https://github.com/Gh05t-1337/CTF-Writeups/tree/main/TryHackMe/AoC23%20Sidequest/1%20The%20Return%20of%20the%20Yeti) points out (spoilers for AoC 2023) with WireShark:
-  `Edit > Preferences > Protocols > IEEE 802.11, and Edit Decryption keys`

## References

[Miguel Sampaio da Veiga](https://medium.com/hacker-toolbelt/wireshark-filters-cheat-sheet-eacdc438969c)
[Wireshark.org Wiki](https://wiki.wireshark.org/Home)
[Wireshark Official](https://www.wireshark.org/)
[Winpcap](https://www.winpcap.org/)
[Berkley Packet Filter](https://biot.com/capstats/bpf.html)
[David Bombal Youtube](https://www.youtube.com/watch?v=GMNOT1aZmD8)
[THM Wireshark Room Wireshark Basics](https://tryhackme.com/room/wiresharkthebasics)  
[THM Packet Operations Room](https://tryhackme.com/room/wiresharkpacketoperations)
[The Other THM Wireshark Room - Wireshark 101](https://tryhackme.com/room/wireshark)
[THM Networking Secure Protocols Room](https://tryhackme.com/room/networkingsecureprotocols)