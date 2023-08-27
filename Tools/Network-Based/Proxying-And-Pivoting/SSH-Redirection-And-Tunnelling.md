# SSH Redirection And Tunnelling

## Introduction

For a broad usage of `ssh` visit: [[SSH-Cheatsheet]]
For a broad overview of proxying and pivoting [[Proxies]] and [[Port-Redirection-And-Tunnelling]]

Terminology:
- Nested Sessions
	- When additional sessions are initiated within a primary session 
- Port Forwarding
	- Forwarding - like email to forward it on to another, there sending a protocol to another machine via some intermediary 
- Tunnelling
	- Encapsulating protocols inside another
- Proxying
	- Like port forwarding except we are not limited by a port - we are still using a port to receive just that the protocols that we are receive are not limited to one port from one machine.

```bash
# Create new key to avoid mixing traffic
ssh-keygen
# Check how the kernel is managing ssh - not include here for non-systemd 
sudo systemctl status ssh
```
## SSH Tunnelling & Local Port Forwarding

As part of connecting to `BOX-01` create a Local port forward where from WAN create a `ssh` tunnel to through to a non-expose internal address. Listening port on WAN interface of `BOX-01` to tunnel traffic from the ssh server on `BOX-02`  to allow access to internal networks connected to the `?` interface
```goat
WAN             | DMZ                    | ?
[KALI]  -->     [  BOX-01  ]  -->        [  BOX-02   ] -->  [ ? ]
[    ]          [ssh client]  -->        [ssh sserver]      [   ]  
```

```bash
# From Attack box
# Local port forwarding
# ssh -N -L [bind_address:]$port:targethost:hostport [username@address]
# NetBoundaryHost = (we are exposing the port 8080 it to kali) 0.0.0.0
# 10.10.10.10 is the intermediary box between NetBoundaryHost and 10.10.10.11
# The port 80 running on 10.10.10.11 is a $targetHost and $target$port to forward to kali  
ssh -L 0.0.0.0:8080:10.10.10.11:80 user@10.10.10.10 -p 2222
ssh -f -N -L $port:$interface:$targethost:$targetport user@10.10.10.10 -i id_rsa

# If you want to access a remote server using a private key.
-i id_rsa
# For local port 
-L local_port:remote_address:remote_portforwarding.
# For remote port forwarding.
-R port:local_address:local_port
# Dynamic port forwarding. Creates a socks proxy on localhost. 
-D local_PORT
# Do not execute a remote command, useful for just forwarding ports
-N 
# To background just before command execution
-f
```

If you do not want to break your ssh connection [konami from SANs](https://www.sans.org/blog/using-the-ssh-konami-code-ssh-control-sequences/) discusses using the key sequences ssh client:
-  `~.` - terminate connection (and any multiplexed sessions)
-  `~B` - send a BREAK to the remote system
-  `~C` - open a command line
-  `~R` - request key
-  `~V/v` - decrease/increase verbosity (LogLevel)
-  `~^Z` - suspend ssh
-  `~#` - list forwarded connections
-  `~&` - background ssh (when waiting for connections to terminate)
-  `~?` - this message
-  `~~` - send the escape character by typing it twice
-   (Note that escapes are only recognised immediately after newline.)

https://www.ired.team/offensive-security/lateral-movement/ssh-tunnelling-port-forwarding
If you need ssh-keys
```bash
ssh-keygen
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 644 id_rsa.pub
```

If running through some shells like Meterpreter we need to have some host key acceptable, without using our Kali Password!
```bash
ssh -f -N -R $kali-port-for-ssh:$ssh-ip-connection:22 -R $kali-port-second-for-Service:$Network-IP:$Service-Port-To-Tunnel-To$ -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -i /tmp/keys/id_rsa kali@$kali-IP 
```
For the keys and assured non-interactivity of ssh to tunnel correctly:
```bash
mkdir /tmp/key -p; cd keys
ssh-keygen 
#Enter location: /tmp/key/id_rsa
	from="$foothold-ssh-ip",command="echo 'This account can only be used for port forwarding'",no-agent-forwarding,no-X11-forwarding,no-pty ssh-rsa ssh-rsa $ssh-rsa=$(cat id_rsa) $foothold-user-base-reverse-shell@poornetwork
```
This entry will allow the foothold key owner of the private key to log in to Kali, without RCE-ing ourselves and allows for port forwarding.

Back to the trusty ascii art:
```goat
______	
[[  ]] ---------> {Internet}
/===/				  ^
Attacker			  |
				  	  |										 
		   _______[FIREWALL] 
		  |
______	  |	  ______					  			 ______
[[  ]]<------>[[  ]]-----Not routed to firewall----->[[  ]] 							
/===/		  /===/						 			 [[  ]]	
Client		 Client						  			Server										 
```

Local port forward with `ssh` to bypass firewall that is allowing inbound and outbound connection from specific ports, then using some service to tunnel traffic to the `Server`
```goat				
	________{_____SSH Tunnel_____}___
	^		  {                 }	|
	|			{		      }		|
______			 {		    }		|
[[  ]] ---------> {Internet}		|
/===/				  ^				|
Attacker			  |				|
				  	  |				|
		   _______[FIREWALL]		|
		  | 						|
		  |		____________________|
		  |		|	
		  |		|	
		  |		|   _______________Service Interaction_________
		  |		V  |										   |
______	  |	   ______					  			  ______   |
[[  ]]<------->[[  ]]-----Not routed to firewall----->[[  ]]<---						
/===/		   /===/						 		  [[  ]]	
Client		  Client						  		  Server										 
```

Check the service configuration file to be compatible with whatever servers, clients and network environments Attacker is operating for example SMB with Kali:
```bash
cat -n /etc/samba/smb.conf | grep "min protocol"
# edit
# And restart <insert service> service or with systemctl
sudo /etc/init.d/smbd restart
```

Then we can just connect from our localhost configured to route traffic throught the SSH tunnel:
```bash
smbclient -L 127.0.0.1 -U Administrator
```

## SSH Remote/Reverse Port Forwarding

Remote or Reverse is a terminological yet-to-be-standardised dichotomy that will appear across the literature, blogs and discussions. It means the same thing, executing a command on a non-local box such that the local box receives the forwarded traffic from specific port.  Reversal of Local port forwarding as port is **opened** from the remote side of the connection and the traffic is forwarded to a port back to local box with remote flag with `ssh -R`. This is possible within a nested session of SSH, which means we have connected to a remote machine, but are initiating a new session within this session and are executing it on the remote machine. Therefore we are performing Remote/Reverse Port Forwarding as the command is being executed on the remote machine from within a nested session.

```bash
# Syntax: ssh -N -R [bind_address:]port:host:hostport [username@address]
ssh -N -R $KaliLoopback:$Port:$ForwardingToIP:$PortToForwardTo attacker@$attackerIP

ssh -N -R 127.0.0.1:2345:10.10.10.10:1234 kali@11.11.11.11
```

Ascii Art:
```goat
 	___________{Internet}_____REMOTE_PORT_FORWARDING_____________
   |				  ^											|
   |				  |											|
   |  		    	  |										  START
______				  |										 ______
[[  ]] ---------> [FIREWALL] <-----/NO ROUTE TO INTERNET-----[[  ]] 
/===/														 /===/
Attacker													 Client
```
Notice that the `START` point differs from the `START` for Local Port Forwarding

## SSH Local and Reverse/ Remote Dynamic Port Forwarding

Remote dynamic port forwarding has only been available since October 2017's OpenSSH 7.6. Only the OpenSSH `client` needs to be version 7.6 or greater  [https://www.openssh.com/txt/release-7.6](https://www.openssh.com/txt/release-7.6)

Setting a local listening port and have it tunnel incoming traffic to any remote destination through a proxy, see [[Proxies]] from more information on setting them up.

From Kali we need a SSH Server - beware the .conf and risks
```bash
# Edit the config
sudo vim /etc/ssh/sshd_config
# Start systemd ssh daemon 
sudo systemctl start ssh
# Show network service running
sudo ss -tulpn

sudo systemctl stop ssh
```

#### Local Dynamic Port Forwarding

```bash
# Syntax
# ssh -N -D <address to bind to>:<port to bind to> <username>@<SSH server address>
ssh -N -D 127.0.0.1:$port $user@$SSH_server_address
```

See [[Proxies]] for `proxychains` configuration.

```goat				
	________{_____SSH_Tunnel_______}_
	^		  {                  }	|
	|		   { 				}	|
	|			{				}	|
[SOCKS]		  	  {		      }		|
[PROXY]			{             }		|
______			 {		    }		|
[[  ]] ---------> {Internet}		|
/===/				  ^				|
Attacker			  |				|
				  	  |				|
		   _______[FIREWALL]		|
		  | 						|
  ________|_________________________|
 |		  |		|	|
 |		  |		|	|
 |		  |		|   ___________________________________________			
 |		  |		V  										   	   |
______	  |	   ______					  			  ______   |
[[  ]]<------->[[  ]]-----Not routed to firewall----->[[  ]]<---						
/===/		   /===/						 		  [[  ]]	
Client		  Client						  		  Server										 
```
With `proxychains` we can execute commands from the end point of the SSH tunnel.
```bash
sudo proxychains <whatever command>
```
#### Reverse/Remote Dynamic Port Forwarding

From Client back to Kali we simply: 
```bash
ssh -N -R 6969 kali@10.10.10.10
```


## ssh on Windows

[The OpenSSH client has been bundled with Windows by default since version 1803 (April 2018 Update)](https://devblogs.microsoft.com/commandline/windows10v1803/#openssh-based-client-and-server), [and has been available as a "Feature-on-Demand" since 1709 (Windows 10 Fall Creators Update).]((https://devblogs.microsoft.com/powershell/using-the-openssh-beta-in-windows-10-fall-creators-update-and-windows-server-1709/)

`%systemdrive%\Windows\System32\OpenSSH` contains:
- `scp.exe`
- `sftp.exe`
- `ssh.exe`
- 


## References

[Wikipedia Tunnelling (Protocol)](https://en.wikipedia.org/wiki/Tunneling_protocol)
[Port forwarding Wiki](https://en.wikipedia.org/wiki/Port_forwarding)
[SSH has an academy](https://www.ssh.com/academy/ssh/protocol)
[iredteam](https://www.ired.team/offensive-security/lateral-movement/ssh-tunnelling-port-forwarding)
[THM Wreath Room](https://tryhackme.com/room/wreath)
[Microsoft Devblogs penssh-based-client-and-server](https://devblogs.microsoft.com/commandline/windows10v1803/#openssh-based-client-and-server)
[Microsoft Devblogs sing-the-openssh-beta-in-windows-10-fall-creators-update-and-windows-server-1709](https://devblogs.microsoft.com/powershell/using-the-openssh-beta-in-windows-10-fall-creators-update-and-windows-server-1709/)