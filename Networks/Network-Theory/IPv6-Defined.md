
# IPv6 Defined

## Commands
For more [[Linux-Networking-Commands]],[[Windows-Networking-Commands]]
```bash
# Enumerate a IPv6 address
ping6
ip -6 neigh # IPv6 version of a arp table


# Connect with ssh
ssh -6
```

## Ippsec's IPv6 Primer

128 bits long, IPv6 has 3.402823669×10³⁸ possible addresses, whereas IPv4 has 4,294,967,296 addresses. Linux calculates these with MAC address.

FF.FF.FF.FF
255.255.255.255

FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF
1	  	2		3		4		5		6		7		8
dead:beef:2::1003
fe80::c2d9:184f:9f41:3c8d

`::` can only done once an address as shorthand for `'0' * x till next non Zero `, hex you can drop left most bit its the same as
fe80:0000:0000:0000:c2d9:184f:9f41:3c8d

/X-bits - X left most bits are going to be 1s
fe80::/10 - Unique Link-Local Address - 
Some incorrectly assume this is a IPv4 Loopback address. 
```							
fe80::/10 = 1111 1111 11 00 0s...
					   ^  ^
Two ones are reserved for the network; the zeros could be reserved for host
4 + 8 = B
febf - f is chosen because it is the highest, then - :ffff:...
```

IPv6 does not use `ARP` it uses `ICMP` to identify addresses.

fc00::/7 - Unique Local-Unicast 
```
fc00:0000::
fdff:ffff...
```

2000::/3 - Global Unicast (routable)
```
3fff:...			0000 First subnet
1110				1fff Next  subnet
```

ff02::1 - Multicast All Nodes 
ff02::2 - Multicast Router Nodes

What would dead:beef:2::1003?
- Answer invalid it is not defined, reserved for future use.

## References
[Ippsec SNeaky IPv6 Talk](https://www.youtube.com/watch?v=1UGxjqTnuyo)