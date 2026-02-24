# `tcpdump`

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
tcpdump $protcol
tcpdump -n port 80
tcpdump -n src host $IP
tcpdump -c 5 -n # output numbering and the set number of packets
tcpdump -n dst host $IP
tcpdump -nX # Print packet data 

tcpdump -i $interface # Listen on a specific interface
tcpdump -i any

tcpdump $protocol -r traffic.pcap # read pcap file by protocol 

tcpdump -A -n 'tcp[13] = 24' # Only packets bit set to ACK and PSH 
```

## References

[tcpdump](https://www.tcpdump.org/)
[THM tcpdump Room](https://tryhackme.com/room/tcpdump)