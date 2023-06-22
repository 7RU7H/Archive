# Tcpdump
Tcpdump is *" a powerful command-line packet analyzer; and libpcap, a portable C/C++ library for network traffic capture*

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
-n port 80
-n src host $IP
-n dst host $IP
-nX # Print packet data 

-A -n 'tcp[13] = 24' # Only packets bit set to ACK and PSH 
```

## References
[tcpdump](https://www.tcpdump.org/)