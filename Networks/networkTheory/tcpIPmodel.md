# TCP/IP model

Compared to OSI, TCP/IP model's primary goal is to classify communication.
Roughly, Between applications, between machines, between networks and between internal network machines.
Assumes the protocols used are prodominantly agnostic to the physical instantiation of data.


Layer 4: 	Application Layer	Detirmines which rules of connection uses proccess-to-proccess: Which Protocol FTP, SMTP, HTTP (analogous to OSI: Application, Presentation and Session layers)
Layer 3:	Transport Layer		Performs host-to-host communications: Which Port (analogous to OSI: Transmission Layer, but with functions like session termination)
Layer 2:	Internet Layer		Establishes internetworking, define addressing and routing: Which IP addresses with existing protocols: IP, IPsec, ICMP (analogous to OSI: Network layer)
Layer 1:	Link Layer		Define networking method in scope of the local network link: protocols ARP (comparable to OSI: Data Link Layer and some of the functions of the Network Layer)
