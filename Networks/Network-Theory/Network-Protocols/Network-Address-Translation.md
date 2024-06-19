# Network Address Translation (NAT)

Network Address Translation (NAT) is utilised to increase the amount of IPv4 and IPv6 address space. Creating a one-to-many map restricting assignment ranges for specific use. [[PAT]] is similarly for port address translation.

Network Address Translation - multiple IP address into one address 

Simplification of NAT - User browsers to a website
- Private IP of your device communicates with Router... 
- the Public Router (your router, it is public as it needs to communicate with other devices other than the private ones) the Private IP of your device is translated to a Public address to communicate back a forth between.. 
- Public IP (probably IPS) that does a similar translation to get data from that internet website back to the router then router translates back to your Private IP 


Private IP Range Classes

Class | Start |  Finish |  Subnet | Addresses
--- | --- | --- | --- | ---
A |  10.0.0.0 | 10.255.255.255 | /8 | 16 Million
B | 172.16.0.0 | 172.31.255.255 | /16 | 65,000
C | 192.168.0.0 | 192.168.255.255 | /24 | 254
## Considerations

- Since the default gateway will overwrite all source IP addresses by its public address, any traffic passed through the gateway looks like it is coming from the gateway itself.
- NAT can make it difficult to attribute traffic for network and system administrators outside of a private network.



Subnet mask uses the same IP format and is assigned to each network starting with 255: 255.0.0.0, etc. Checking is easy as you XOR 11111111.00000000.00000000.00000000 with some address in binary,or each address to each other. It is possible to have subnet masks with bytes other than 255, or a full byte of one-bits.  To accurately calculate the CIDR value for a subnet mask with values other than 255, it is necessary to convert the octets into binary, and then to count the number of 1's that appear in the full binary string.

**Classless Inter-Domain Routing(CIDR)** 
```
/8 255.0.0.0
/16 255.255.0.0
/24 255.255.255.0
```
#### IPv4 packet:

0 | 3 |	7 | 15 | 31 bit | Sizes
--- | --- | --- | --- | --- | ---
Version | IHL | TOS | Total Length | 20 bytes
Identificatation | Flags|Fragment-offset | ...
TTL | Protocol | Header-checksum | ...
Source Address |   |   |   ...
Destination Address |   |   |  ...
Options |   |  |  | 0-40 Bytes
Data |   |   |   |   | Up to 65536 bytes

#### IPv6 packet:

0 | 3 | 7 | 12 | 15 | 31 bit | Sizes
--- | --- | --- | --- | --- | ---
Version | Traffic-class | Flow-label |   |   | ...
Payload-length | Next-Header | Hop-limit  |   | ...
Source Address |  |  |  | ...
Destination Address |  |  |  | ...

## References

[YouTube - Part 1 Networking for Pentesters: Beginner -SheNetworks - Serena  DiPenti - BHIS](https://www.youtube.com/watch?v=FFzBgb00ffk)
[YouTube - Part 2 Networking for Pentesters: Beginner -SheNetworks - Serena  DiPenti - BHIS](https://www.youtube.com/watch?v=ikIGTW0uraA)
[YouTube - Part 3 Networking for Pentesters: Beginner -SheNetworks - Serena  DiPenti - BHIS](https://www.youtube.com/watch?v=HS0bicAd-5A)
