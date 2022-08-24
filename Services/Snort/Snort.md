# Snort
SNORT is an open-source, rule-based Network Intrusion Detection and Prevention System (NIDS/NIPS). It was developed and still maintained by Martin Roesch, open-source contributors, and the Cisco Talos team. [Snort](https://www.snort.org/) *"is the foremost Open Source Intrusion Prevention System (IPS) in the world. Snort IPS uses a series of rules that help define malicious network activity and uses those rules to find packets that match against them and generate alerts for users."*

For more information regarding IDS and IPS systems view the articles [[Intrusion-Prevention-Systems]] and [[Intrusion-Detection-Systems]]

*"Snort can be deployed inline to stop these packets, as well. Snort has three primary uses: As a packet sniffer like tcpdump, as a packet logger — which is useful for network traffic debugging, or it can be used as a full-blown network intrusion prevention system. Snort can be downloaded and configured for personal and business use alike."*

## Capabilities
-   Live traffic analysis
-   Attack and probe detection
-   Packet logging
-   Protocol analysis
-   Real-time alerting
-   Modules & plugins
-   Pre-processors
-   Cross-platform support! (Linux & Windows)

**Models**
- Sniffer Mode -  read IP packet and prompt them in console application
- Packet Logger mode - log all IP packet (in/out)bound the network
- NIDS mode
- NIPS mode

## Utility

Version and .conf testing
```bash
snort -V # Version
snort -h # HELP!
# Test -T the -c .conf
sudo snort -c /etc/snort/snort.conf -T # -q # for quiet mode
```

## Sniffing Mode 
```bash
-v # Verbose
snort -d  # Display packet data
snort -de # Also Display link-layer headers
snort -v -i eth0 # Interface to sniff -plus Verbose
snort -X # Display full packet details in HEX
```

## Logging Mode

Default log directory is ` /var/log/snort`; beware linux file ownership.
`sudo chown $user file`, `sudo chown $username -R directory`

```bash 
snort -l # Log and alert output directory - default is /var/log/snort
snort -K ASCII # Log packets in ASCII format
snort -r # Read dumped logs in Snort
snort -n # Specify Number of packets to read
# Examples
snort -dev -l . # Log to current directory
snort -dev -K ASCII -l . # Log to current directory in ASCII
snort -r $logname.log # Read with snort
tcpdump -r $logname.log -ntc 10 # Read with tcpdump
# Wireshark can also read these logs, filter with example options for BPF:
snort -r $logname.log -X 
snort -r $logname.log icmp # BPF filter
snort -r $logname.log tcp # BPF filter
snort -r $logname.log 'udp and port 53' # BPF filters
snort -r $logname.log -n 10 # Process only the first 10 lines
snort -r $logname.log -n 10 -vxde # As above with all sniffing parameters
```



## References

[Snort](https://www.snort.org/)
[THM Snort Room](https://tryhackme.com/room/snort)
[Snort wiki](https://en.wikipedia.org/wiki/Snort_(software))