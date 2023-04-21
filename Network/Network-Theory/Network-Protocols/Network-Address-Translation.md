# Network address translation (NAT)

Subnet mask uses the same IP format and is assigned to each network starting with 255: 255.0.0.0, etc
Checking is easy as you XOR 11111111.00000000.00000000.00000000 with some address in binary,or each address to each other. It is possible to have subnet masks with bytes other than 255, or a full byte of one-bits.  To accurately calculate the CIDR value for a subnet mask with values other than 255, it is necessary to convert the octets into binary, and then to count the number of 1's that appear in the full binary string.

**Classless Inter-Domain Routing(CIDR)** 
/8 255.0.0.0
/16 255.255.0.0
/24 255.255.255.0


## IPv4 packet:

0 | 3 |	7 | 15 | 31 bit | Sizes
--- | --- | --- | --- | --- | ---
Version | IHL | TOS | Total Length | 20 bytes
Identificatation | Flags|Fragment-offset | ...
TTL | Protocol | Header-checksum | ...
Source Address |   |   |   ...
Destination Address |   |   |  ...
Options |   |  |  | 0-40 Bytes
Data |   |   |   |   | Up to 65536 bytes



## IPv6 packet:

0 | 3 | 7 | 12 | 15 | 31 bit | Sizes
--- | --- | --- | --- | --- | ---
Version | Traffic-class | Flow-label |   |   | ...
Payload-length | Next-Header | Hop-limit  |   | ...
Source Address |  |  |  | ...
Destination Address |  |  |  | ...
