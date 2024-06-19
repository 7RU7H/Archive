# Address Resolution Protocol (ARP)

ARP is designed to associate Network Layer addresses to Link layer address, allowing switches to transmit Ethernet frames to their destination device on the Local Area Network(LAN). ARP communications between multiple machines allow them specify rules of communication that can disclose IP addresses belonging to each MAC address.

`MACHINE:A` begins the protocol by broadcasting a frame containing:
1. The source, `MACHINE:A's MAC address
1. The destination, ff:ff:ff:ff as the destination - a special address meaning broadcast allow all machines to receive frames.
1. A string asking which machine has X IP address - communicate back X address back to `MACHINE:A`.

`MACHINE:B` store MAC address of `MACHINE:A`, then responds
1. `MACHINE:B`'s MAC address as source
1. `MACHINE:A`'s MAC address as destination
1. A string containing my MAC address = IP address(`MACHINE:B`'s current IP)

For ARP cache on Linux or Windows
```powershell
arp -a
```

And the current ARP data on Linux: 
```bash
cat /proc/net/arp
```