# Address Resolution Protocol (ARP)

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