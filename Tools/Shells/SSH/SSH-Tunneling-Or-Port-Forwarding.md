# SSH Tunneling Or Port Forwarding


## SSH Tunneling & Local Port Forwarding

```bash
# From Attack box
# Local port forwarding
# ssh -N -L [bind_address:]$port:host:hostport [username@address]
ssh -L 127.0.0.1:8080:127.0.0.1:80 user@10.10.10.10 -p 2222
ssh -f -N -L $port:127.0.0.1:port user@ip -i id_rsa

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

## SSH Remote Port Forwarding

Reversal of Local port forwarding as port is **opened** from the remote side of the connection and the traffic is forwarded to a port back to local box with remote flag with `ssh -R`.

```bash
# Syntax: ssh -N -R [bind_address:]port:host:hostport [username@address]
ssh -N -R $Attacker_IP:$Listening_port:$remotes_127-0-0-1:$port_forwarded_through attacker@$Attacker_IP
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

## SSH Dynamic Port Forwarding

Setting a local listiening port and have it tunnel incoming traffic to any remote destination through a proxy, see [[Proxies]] from more information on setting them up.

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


## References

[Tunneling(Protocol) Wiki](https://en.wikipedia.org/wiki/Tunneling_protocol)
[Port forwarding Wiki](https://en.wikipedia.org/wiki/Port_forwarding)
[SSH has an academy](https://www.ssh.com/academy/ssh/protocol)
[iredteam](https://www.ired.team/offensive-security/lateral-movement/ssh-tunnelling-port-forwarding)