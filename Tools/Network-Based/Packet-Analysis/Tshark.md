# Tshark
If [tcpdump]([[Tcpdump-Cheatsheet]]) is too much and [[Wireshark]] does not do enough - use Tshark

```bash
apt list tshark
apt install tshark
tshark -h
```

## Reading pcap files
```bash
tshark -r file.cap # display packet liek tcpdump
tshark -r file.cap | wc -l # use bash to work with file.cap
# query the capture file; -Y switch to add these display filters 
# display filter are not BPF syntax!
tshark -r file.cap "$display_filter.qry.type == 1"
# -T datatype: pdml|ps|psml|json|jsonraw|ek|tabs|text|fields|?
# -e extract
tshark -r file.cap -Y "dns.qry.type == 1" -T fields -e dns.qry.name

```


## References

[Tshark](https://tryhackme.com/room/tshark)
