# `tcpdump`

**Warning `get MAC address from arp request` of this article were created with `ChatGPT` and human consultation of `THM`

`tcpdump` is *" a powerful command-line packet analyzer; and libpcap, a portable C/C++ library for network traffic capture*.  Written in C and C++ along with its library `libpcap` for Unix-like systems it was later ported to Windows with a corresponding library `winpcap`.

To capture capture traffic:
```bash
tcpdump -i $interface port $int
```

To read a capture file `.pcap`:
```bash
tcpdump -r $file
```
Reading `pcap` files is not easy on the eyes like [[Wireshark]], [[Tshark]] or [[Brim]]. Using [[Grep-All-The-Things]] with  `awk` and  `sort` modules from [[Linux-Module-Commands]] can filter out the information to more more relevant data. With `uniq -c` we can count unique IP address  `awk '{ print $<X-column> }'`. `head -n <amount of lines>` or `tail -n <amount of lines>`. Just replace the `$3` for source addresses as the fifth field is destination addresses.
```bash
sudo tcpdump -n -r password_cracking_filtered.pcap | awk -F" " '{print $5}' | sort | uniq -c | head
```

Filtering packets
```bash

tcpdump -n port 80
tcpdump -n src host $IP
tcpdump -c 5 -n # output numbering and the set number of packets
tcpdump -n dst host $IP
tcpdump -nX # Print packet data 

tcpdump -i $interface # Listen on a specific interface
tcpdump -i any

tcpdump $protocol -r traffic.pcap # read pcap file by protocol 

tcpdump -A -n 'tcp[13] = 24' # Only packets bit set to ACK and PSH 

# Filtering
man pcap-filter

tcpdump host example.com
tcpdump port 80
tcpdump $protcol # icmp, http
tcpdump src host $ip
tcpdump dst host $ip
# With logic
tcpdump https or http
tcpdump icmp and udp
tcpdump udp not tcp
# Filtering by packet lengeth
tcpdump greater $length
tcpdump less $length
# Binary operations
& # (And) takes two bits and returns 0 unless both inputs are 1.
| # (Or) takes two bits and returns 1 unless both inputs are 0.
! # (Not) takes one bit and inverts it; an input of 1 gives 0, and an input of 0 gives 1.

# Header bytes
proto # protocols
expr # offset
size # number of bytes 

# TCP Flags
tcpdump "tcp[tcpflags] == tcp-syn"
... tcp-syn # SYN (Synchronize)
... tcp-ack # ACK (Acknowledge)
... tcp-fin # FIN (Finish)
... tcp-rst #RST (Reset)
... tcp-push # Push

# Displaying Packets
tcpdump -q # Quick output; print brief packet information
tcpdump -e # Print the link-level header
tcpdump -A # Show packet data in ASCII
tcpdump -xx # Show packet data in hexadecimal format, referred to as hex
tcpdump -X #` Show packet headers and data in hex and ASCII

# Get MAC address of all arp requests in a traffic.pcap file
tcpdump -r traffic.pcap -nn -e -c 1 'arp and arp[6:2] = 1'
```

## References

[tcpdump](https://www.tcpdump.org/)
[THM tcpdump Room](https://tryhackme.com/room/tcpdump)