# TCP/IP Model

`TCP/IP` (`Transmission Control Protocol`/`Internet Protocol`) is a generic term for many network protocols.
![](net_models4_updated.png)

Compared to [[OSI-Model]], TCP/IP model's primary goal is to classify communication.
Roughly, between applications, between machines, between networks and between internal network machines. It assumes the protocols used are predominantly agnostic to the physical instantiation of data.

Layer Number | Layer Name | Description
--- | --- | ---
Layer 4: | Application Layer | Detirmines which rules of connection uses proccess-to-proccess: Which Protocol FTP, SMTP, HTTP (analogous to OSI: Application, Presentation and Session layers)
Layer 3: | Transport Layer | Performs host-to-host communications: Which Port (analogous to OSI: Transmission Layer, but with functions like session termination)
Layer 2: | Internet Layer | Establishes internetworking, define addressing and routing: Which IP addresses with existing protocols: IP, IPsec, ICMP (analogous to OSI: Network layer)
Layer 1: | Link Layer | Define networking method in scope of the local network link: protocols ARP (comparable to OSI: Data Link Layer and some of the functions of the Network Layer)

|**Task**|**Protocol**|**Description**|
|---|---|---|
|`Logical Addressing`|`IP`|Due to many hosts in different networks, there is a need to structure the network topology and logical addressing. Within TCP/IP, IP takes over the logical addressing of networks and nodes. Data packets only reach the network where they are supposed to be. The methods to do so are `network classes`, `subnetting`, and `CIDR`.|
|`Routing`|`IP`|For each data packet, the next node is determined in each node on the way from the sender to the receiver. This way, a data packet is routed to its receiver, even if its location is unknown to the sender.|
|`Error & Control Flow`|`TCP`|The sender and receiver are frequently in touch with each other via a virtual connection. Therefore control messages are sent continuously to check if the connection is still established.|
|`Application Support`|`TCP`|TCP and UDP ports form a software abstraction to distinguish specific applications and their communication links.|
|`Name Resolution`|`DNS`|DNS provides name resolution through Fully Qualified Domain Names (FQDN) in IP addresses, enabling us to reach the desired host with the specified name on the internet.|

## References

[HTB Academy Introduction to Networking](https://academy.hackthebox.com/app/module/34/section/301)