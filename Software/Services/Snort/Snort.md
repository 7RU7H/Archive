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

## Zeek and Snort Comparison

- Focus 
	- [[Zeek]]: NSM and IDS through network analysis with detection for alerts that triggered by events 
	- [[Snort]] : IDS/IPS signature-based detection 
- Common Use  
	- [[Zeek]]: Network Monitoring, traffic investigation and detecting chained event
	- [[Snort]] : Itrusion detection and prevention to stop the known threats and attacks

## Rule Format

```c
[ACTION] [Protocol] [Source IP] [Source Port] -> [Destination IP] [Destination Port] [Rule metadata]([Message];[signature ID]; [Rule Revision];)  
```

[THM IDS Fundamentals](https://tryhackme.com/room/idsfundamentals):
- **Action:** This specifies which action to take when the rule triggers. In this case, we have the action to "alert" when the traffic matches this rule.
- **Protocol:** This refers to the protocol that matches this rule. In this case, we use the protocol "ICMP" when pinging a host.
- **Source IP:** This determines the IP originating from the traffic. Since we want to detect traffic from any source IP, we set this as "any".
- **Source port:** This determines the port from which the traffic originates. Since we want to detect traffic from any source port, we set this as "any".
- **Destination IP:** This specifies the destination IP to which the matching traffic comes; it generates the alert. In this case, we used "$HOME_NET". This is a variable, and we defined its value as our whole network’s range in Snort’s configuration file.
- **Destination port:** This specifies the port the traffic would reach. Since we want to detect traffic coming to any port, we set it to "any."
- **Rule mhttps://tryhackme.com/room/idsfundamentalsetadata:** Every rule has some metadata. That is defined at the end of the rule in parentheses. The following are its components:
    - **Message (msg):** This describes the message displayed when the subject rule triggers. The message should indicate the type of activity detected. In this case, we used "Ping Detected".
    - **Signature ID (sid):** Every rule has a unique identifier that differentiates it from others. This identifier is called the signature ID (sid). In this case, we set the sid to "10001".
    - **Rule revision (rev):** This sets the rule's revision number. Every time the rule is modified, its revision number is incremented, which helps in tracking changes to any rule.

## Utility

Version and .conf testing
```bash
snort -V # Version
snort -h # HELP!

# Custom Rules file path and editing
sudo vim /etc/snort/rules/local.rules

# Test -T the -c .conf
sudo snort -c /etc/snort/snort.conf -T # -q # for quiet mode
# Test with terminal 
sudo snort -q -l /var/log/snort -i lo -A console -c /etc/snort/snort.conf
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

## IDS/IPS Mode (Network Intrusion Detection System mode)

NIDS mode parameters
```bash
snort -c /etc/snort/snort.conf # Define config file
snort -c /etc/snort/snort.conf  -T # Test config file
snort -c /etc/snort/snort.conf -N # Disable Logging - in IDS/IPS mode
snort -c /etc/snort/snort.conf -D # Background mode
snort -A # Alert modes (default is full):
# full - All possible information 
# fast - alert message, timestamp, src and dst ip plus port number 
# console - fast style, but to console screen 
# cmg - CMG style; header in text and hex format
# none(disable alerts)
# 
# IPS mode and dropping packets
# edit snort.conf or:
snort -c /etc/snort/snort.conf -q -Q daq afpacket -i $iface0:$iface1
# -Q daq = activate DAQ (Data Acquisition modules) use afpacket module
# snort requires atleast two interfaces
```

## PCAP Investigtion 

```bash
sudo snort -q -l /var/log/snort -r $example.pcap -A console -c /etc/snort/snort.con



# Investigate with default reading options
snort -r $file.pcap # Read a pcap
snort --pcap-list="$file0.pcap $file1.pcap $file2.pcap $file3.pcap " # space sperated pcap list
snort --pcap-show # Show pcap name on console during processing
# Investigate with snort.conf
# Snort will identify traffic and prompt alerts according to ruleset
# Make multiple .conf
sudo snort -c /etc/snort/snort.conf -q -r $file0.pcap -A console -n 10
```



## References

[Snort](https://www.snort.org/)
[THM Snort Room](https://tryhackme.com/room/snort)
[Snort wiki](https://en.wikipedia.org/wiki/Snort_(software))
[THM IDS Fundamentals](https://tryhackme.com/room/idsfundamentals)