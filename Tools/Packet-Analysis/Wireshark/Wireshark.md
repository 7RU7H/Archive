# Wireshark
I actively recommend Wireshark as personally it help me really understand [[Network-Services]],[[Network-Protocols]] and [[TCP-IPmodel]]  and I highly recommend it.

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

See [Wireshek Wiki for more](https://wiki.wireshark.org/Home)


## For Just Useful Display Filters
Found here: [[Wireshark-Useful-Packet-Filters]]


## Use cases
Want a GUI with quick filters instead of [[Tcpdump-Cheatsheet]] and [[Useful_Bash]]?
-   Decrypting SSL and TLS Traffic: [David Bombal Youtube](https://www.youtube.com/watch?v=GMNOT1aZmD8)
-   Detecting and troubleshooting network problems, such as network load failure points and congestion.
-   Detecting security anomalies, such as rogue hosts, abnormal port usage, and suspicious traffic.
-   Investigating and learning protocol details, such as response codes and payload data.

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

Packet details - Great place to look into [[osiModel]] or [[Network-Protocols]] very helpful for learning, by looking around.
![Packetdetails](wireshark-packet-detail.png)

Packet bytes are displayed in hex on the left and ascii on the right
![Packetbytes]wireshark-packetbytes.png)

Start button to start capturing:
![StartButton](wireshark-start.png)

Red square to stop and green fin button to restart the capture.
![Stop](wireshark-stop.png)

## Great GUI tricks

#### Following Packets
The most import possible trick is `Right Click <Packet Line> -> Follow -> <Stream Type>`, which allow you to follow the traffic from one client and server connection of `TCP/UDP/SSL/HTTP stream` in a seperate GUI window, rather the line by line manually packet by packet.
#### Colouring 
Custom colouring can be can be set by `View -> Coloring Rules...`
#### Merge PCAP Files
To combine multiple .pcap file into one single file `File -> Merge`.
#### View File Details
`Statistics -> Capture File Properties`
#### Exporting Artifacts
####  Finding Packets
`Ctrl+G` or `Go -> Go to Packet...`
`Ctrl+F`
#### Marking Packets
`Ctrl+M` or `Edit/Right-Click Mark/Unmakr Packet(s)`
#### Packet Comments
`Ctrl+Alt+c` or `Edit/Right-Click -> Packet Comment...`
#### Export Packets,
Siphon off packet data to a file
`File -> Export Specified Packets`
#### Export Object(Files)
If want to transform packet data in to files, use export!
`File -> Export Object`
#### Time Display Format
`View -> Time Display Format -> Chose a format`
#### Expert Info
Beware of false positives/negatives
`Analyze Information -> Expert Information `

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
**The Frame (Layer 1):** Frame/packet details specific to the Physical layer of the OSI model.
**Source MAC (Layer 2):** Displays source and destination MAC Addresses; from the Data Link layer of the OSI model.
**Source IP (Layer 3):** Displays source and destination IPv4 Addresses; from the Network layer of the OSI model.
**Protocol (Layer 4):** Displays details of the protocol used (UDP/TCP) and source and destination ports; from the Transport layer of the OSI model.
**Protocol Errors:** Continuation of the 4th layer, shows specific segments from TCP that needed to be reassembled.
**Application Protocol (Layer 5):** This will show details specific to the protocol used, such as HTTP, FTP,  and SMB. From the Application layer of the OSI model.
**Application Data:** This extension of the 5th layer can show the application-specific data.




## References
[Miguel Sampaio da Veiga](https://medium.com/hacker-toolbelt/wireshark-filters-cheat-sheet-eacdc438969c)
[Wireshark.org Wiki](https://wiki.wireshark.org/Home)
[Wireshark Official](https://www.wireshark.org/)
[Winpcap](https://www.winpcap.org/)
[Berkley Packet Filter](https://biot.com/capstats/bpf.html)
[David Bombal Youtube](https://www.youtube.com/watch?v=GMNOT1aZmD8)
[THM Wireshark Room](https://tryhackme.com/room/wiresharkthebasics)  