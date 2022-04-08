# Network Protocols

## Link Layer: Ethernet

Networks consisting of only physical devies are vulnerable to collisions - two or more device transmits packets on a network segment at the same time.
Link layer purspose is to reduce collisions no the physical network.
Ethernet allows to form logical boudaries around physically connected devices via the concept of network switches or bridges.
Switches reduce collision by divideing it into smaller networks of networks.
Devices can reach another devices networking interface by invoking its MAC address

MAC addresses are constructed by concatenating six bytes (8-bit hexidecial numbers), for example:
11:22:33:44:55:66
^^ ^^ ^^
Organizationally Unique Identifier (OUI) the bottom three octets, ensures uniqueness

Device do not inherently know each other MAC addresses, thus ARP:

## Address Resolution Protocol (ARP)

ARP is designed to associate Network Layer addresses to Link layer address, allowing switches to
transmit ethernet frames to their destination device on the Local Area Network(LAN). 

ARP communications between multiple machines allow them specify rules of communication that can disclose
IP addresses belonging to each MAC address.

MACHINE:A begins the protocol by broadcasting a frame containing:
1. The source, A's MAC address
1. The destination, ff:ff:ff:ff as the destination - a special address maeaning broadcast allow all machines to recieve frames.
1. A string asking which machine has X IP addresss - communicate back X address back to A.

MACHINE:B store MAC address of A, then responds
1. B's MAC address as source
1. A's MAC address as destination
1. A string containing my MAC address = IP address(b's current IP)

## Internet Protocol IP 

IP addresses
```
4 * octet concatenate_to 32bit int; foreach assign 1-255 # (2^8 = 256) 

```
2^32 OR
2^8^4 = 0-255.0-255.0-255.0-255 possible addresses ~4.3billion possible values
This can be written as 32 bit binary address.
Each network is assigned a subnet mask.
This helps to define what IP address are allowed to exist within that same network or not.
To figure out which other machines can be inside network:
1. Compare the zero-bits - The zero-bits of the subnet masks do not constrain potential IP addresses.
1. Compare the one-bits - The one-bits tell us that every corresponding bit of any two IP addresses inside the network must match.

4.3 billion possible values, NAT solves this small number

#### Network address translation (NAT)

Subnet mask uses the same IP format and is assigned to each network starting with 255: 255.0.0.0, etc
Checking is easy as you XOR 11111111.00000000.00000000.00000000 with some address in binary,or each address to each other.
It is possible to have subnet masks with bytes other than 255, or a full byte of one-bits. 
To accurately calculate the CIDR value for a subnet mask with values other than 255, it is necessary to convert the octets into binary, and then to count the number of 1's that appear in the full binary string.
**Classless Inter-Domain Routing(CIDR)** 
/8 255.0.0.0
/16 255.255.0.0
/24 255.255.255.0


IPv4 packet:
```
0	3	7		15			31 bit	Sizes
Version	IHL	TOS		Total Length		20 bytes
Identificatation 		Flags|Fragment-offset	...
TTL		Protocol	Header-checksum		...
Source Address						...
Destination Address					...
Options							0-40 Bytes
Data							Up to 65536 bytes

```
IPv6 packet:
```
0 	3	7	12	15			31 bit	Sizes
Version	Traffic-class	Flow-label			...
Payload-length			Next-Header    Hop-limit...
Source Address						...
Destination Address					...
```

##  Transport Layer: TCP/UDP

#### Transmission control protocol (TCP)

Initiated with a TCP handshake
TCP segment require the sender to specify a port number

To initate a TCP session:
Three-way-handshake
A -> SYN -> B
B -> SYN-ACK -> A
A -> ACK -> B

#### Unified Datagram Protocol

UDP is faster and but less reliable than TCP
Defines a ports like TCP

## Application Protocols

Protocol 	Port	
HTTP 		80
HTTPS 		443
FTP 		21
TFTP 		69
SMTP 		25

## Internet Control Messaging Protocol(ICMP)

ICMP traffic operates as the Transport layer(TCP/IP):
Supportive role - alerts sender with error messages with error codes
Pinging a machine using ICMP to test network connectivity and detirmine latency


## Dynamic Host Configuration Protocol(DHCP) 

Role to prevent issues regarding new machine join the network and address configuration.
DHCP server assignes IP address to each host that join the network. These IP addresses
are only valid to set amounts of time. Provides machines joining other information like the
network's subnet mask, default gateway address and it domain name server addresses.
It uses UDP, leases addresses
