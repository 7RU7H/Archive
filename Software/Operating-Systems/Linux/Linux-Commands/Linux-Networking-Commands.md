# Linux Networking Commands Current and Legacy
For non-network related command see:[[Core-Linux-Commands]]


## Places of interest

```bash
/etc/network/interfaces
/etc/hosts
/etc/<OS-Dependent/resolve.conf
```


## ARP
```bash
arp
# flags:	
	-e	# default linux formatting
	-n	# numerical address
	-s 	# manually add addresses to the table
	-d	# remove addresses from the table
	-a  # All is the best  
```

## Dig
```bash
# [dns-host] [type] 	domain information groper, for observeing DNS name servers
dig -x $ip # Domain lookup
dig @$ip domain -t  AXFR # DNS Zone tranfer
```

## Echo
For activating IP forwarding, adding hosts and adding DNS servers
```bash
echo "1" > /proc/sys/net/ipv4/ip_forward
echo "10.10.10.10 domain.com subdomain.domain.com" | sudo tee -a /etc/hosts
echo "nameserver x.x.x.x" > /etc/resolve.conf
```

## FTP
```bash
ftp 
	-n	# prevents autologon
	-v	# Showd all responses
```

## Host
```bash
host $ip # Domain lookup
host $flag $IP	# Host record
	-t	# ns, a, mx, ptr, cname, txt -type of record
host -t SRRV _<service>_ tcp.url.com # Doman SRV lookup
host -l <domain> <namesvr> # DNS transfer

hostname	# convert hostnames to IP addresses and vice-versa
```

## ifconfig
```bash
ifconfig	# provides information on host (req. net-tools)
# flags:

```

## IP 
```bash
ip
# flags:
	a|addr	for your address
	link 	network devices eth0, wlan0 etc

# for IP  add new route ip/netmask device interface
sudo ip route add ip/netmask dev eth1

# Print existing VPN keys
ip xfrm state list 
# Add 'hidden' interface
ip addr add <ip>/cidr> dev eth0

```
## IPtables
```bash
iptables
        -L
        -P chain policy		edit chain policy defaults			 
	-p tcp,udp,icmp         display protocols 
        -s                      defines source address in connection
        -d                      defines destination address in connection
        -i                      defines inbound interfaces
        -o                      defines outbound interfaces
        -A                      append rule to the chain 
        -C                      check rule is in chain
        -D                      delete rule from a chain
        -I                      insert rule into a chain 
        -R                      replace rule in a chain
        -m modulename           use module

        -j DROP/ACCEPT/REJECT   target assignment(combine with -R to replace the assign policy target
        --dport portnumber      specify a destination port(combine with -R to only route traffic from an ip through a port)
        --sport portnumber      specify a source port
        -v                      amount of packets and bytes
        -n                      only display ip addresses
        --line-numbers          useful for specifications

# conntrack module, a subset of --ctstate of the iptable-exetensions package
#  Note that on older Linux kernels, this would show as --state instead of --ctstate.
#  can be used to to create rules based on the type of connection made
-m conntrack
# to save iptables 
iptables-save

# run the builtin WIFI scanner
iwlist <int> scan

# List established connections
lsof -i


# Netstat for network and port status
netstat/ss	# ss default on most linux distros
# Sudo/doas will provider greater information!
# flags:	
netstat	-natup	
netstat -tulpn
netstat -a	show all listening ports and established connections
netstat -at 	show tcp protocol connections
netstat -au	show udp protocol connections
netstat -l	list all listening ports
netstat -lt	list all tcp listening ports
netstat -s	list usage statistics by protocol
netstat -tp	list connections with the service name and pid info
netstat -i	show interface statistics
netstat -ano	display all sockets, do not resolve names, display timers
netstat -n	Show numerical addresses not symbolic host, port or usernames 

nmcli 		command-line tool for controlling NetworkManager
nmcli -a	all
nmcli dev show	dns 

nslookup domain	# Identify the IP address of hosts and examine Internet domain name servers

ping				ping network, add man!
ping -c num ip		ping for the num=int of packets to the ip
ping -s num ip		ping for the num=int size of packet to the ip


route
# flags:	

traceroute 	trace the route to domain/ip
# flags:	
	-m	max number to hops

# scp to transfer secure copy between two computers
scp /file target@myhost.com:/directory

sleep		good for linux system on network for the hanging of connection
```

## SMB
See [[SMB-Recon-Cheatsheet]] for more tools and commands
```bash
smb//<ip>/share                 # Access Windows share
share user x.x.x.x <sharename>$ # Mount windows share
smbclient -U user \\\\<ip>\\<share> # Smb connect
```

## tcpdump
```bash
tcpdump 
# flags: 
	-r	specify file path read from
	-w 	write to a file
	<name>	protocol
	
# Kill a tcp connection
tcpkill host <ip> and port <port>

# SysV Init distros
# BEWARE
service <args> <service-name>

# Systemd linux distros
# BEWARE
# start ssh server, check status, restart
sudo systemctl start ssh
sudo systemctl status ssh
sudo systemctl restart ssh
sudo systemctl stop ssh
systemctl list-units --type=target --all


# file for the ssh daemn process :
/etc/ssh/sshd_config
# config file
/ect/ssh/ssh_config

ssh -i id_rsa 
ssh user@ip -p PORTNUM
#SOME machines require [fingerprint] instead of yes/no!

# .ssh is /home/user directory containing:
id_rsa #sometimes
known_hosts
# known_hosts is a value controlled ssh_config HashKnownHosts



# Disclaimer for Offsec lab stuff
# In labs and day to day sometimes the IP will change of an internal network. TO FIX but never use in the real world!
# 1. Remove the known_hosts file or entry to that server in the file or 2. add the -o stricthostkeychecking=no option to the ssh command. Remember that this file is a security mechanism to prevent an unauthorized host from eavesdropping on network traffic. In real-world practice, this mechanism should not be bypassed.
```

## WIFI Related

[[WiFi-Hacking]]

## Tricks
#### Change MAC Address
```bash
export MAC=xx:xx:xx:xx:xx:xx
ifconfig <int> hw ether <MAC>
macchanger -m <MAC> <int>
```
