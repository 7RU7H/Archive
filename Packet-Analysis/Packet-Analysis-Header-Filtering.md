# Packet Analysis Header Filtering 

To gain greater insight into inspecting requests and responses in a .pcap file or any packet capture, filtering out non-essential or irrelevant to objectives in analysis is key technique. Whether analysing a set or single packet(s) it is useful to make the data more human readable and packet data displayed to be limited of the amount of data.  

Different protocols use different packet 

## TCP Packets
Display only the data packets we filter **for** psckets with PSH and ACK flags set. Using `tcpdump` see [[Tcpdump-Cheatsheet]] for more `tcpdump` related usage and examples.

```bash
tcpdump -A -n 'tcp[13] = 24' $file.pcap # Only packets bit set to ACK and PSH 
```

