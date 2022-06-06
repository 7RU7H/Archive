# Windows Networking Commands

```powershell
arp 
	-a		display all network interface


ipconfig # *"str" insert string like "Ethernet adapter Ethernet" 
	
	/all		displays the full configuration information.
	/release "str"	DHCP Release message to the DHCP server. NO str will release all
	/renew "str"	request a new IP address from the DHCP server. NO str will renew all
	/displaydns	display DNS settings
	/flushdns	flush DNS cache

nbtstat # displays:
	# information related to NETBIOS name table and cache
	# NetBT protocol information for local and remote machine
  	-a   (adapter status) Lists the remote machine's name table given its name
	-A   (Adapter status) Lists the remote machine's name table given its IP address.
  	-c   (cache)          Lists NBT's cache of remote [machine] names and their IP addresses
  	-n   (names)          Lists local NetBIOS names.
 	 -r   (resolved)       Lists names resolved by broadcast and via WINS
 	 -R   (Reload)         Purges and reloads the remote cache name table
 	 -S   (Sessions)       Lists sessions table with the destination IP addresses
 	 -s   (sessions)       Lists sessions table converting destination IP
                        addresses to computer NETBIOS names.
  -RR  (ReleaseRefresh) Sends Name Release packets to WINS and then, starts Refresh

# BEWARE netsh advfirewall firewall 
netsh 
	firewall	# DEPRECATED
		?              - Displays a list of commands.
		add            - Adds firewall configuration.
		delete         - Deletes firewall configuration.
		dump           - Displays a configuration script.
		help           - Displays a list of commands.
		set            - Sets firewall configuration.
		show           - Shows firewall configuration.
	advfirewall
		?              - Displays a list of commands.
		consec         - Changes to the `netsh advfirewall consec' context.
		dump           - Displays a configuration script.
		export         - Exports the current policy to a file.
		firewall       - Changes to the `netsh advfirewall firewall' context.
		help           - Displays a list of commands.
		import         - Imports a policy file into the current policy store.
		mainmode       - Changes to the `netsh advfirewall mainmode' context.
		monitor        - Changes to the `netsh advfirewall monitor' context.
		reset          - Resets the policy to the default out-of-box policy.
		set            - Sets the per-profile or global settings.
		show           - Displays profile or global properties.

netsh advfirewall firewall add rule name="Deny Ping" dir=in action=block protocol=icmpv4 remoteip=any
netsh advfirewall firewall add rule name="Allow SSH" dir=in action=allow protocol=tcp localport=22


net share		# configure and manage shared resources
	sharename=drive:path


net use			# to connect to remote shared resources

netstat 
	-a		display listen ports
	-p		display by protocol
	-n		show address numerically
	-o		Process PID 

nslookup # either fin  teh IP of a domain name or the domain name of an IP(revsere lookup)

pathping
# Similar to tracert, once hop is confirmed a hop it will send multiple messages and provide statistics
# More reliable than tracert to provide latency  information
	-g host-list     Loose source route along host-list.
    	-h maximum_hops  Maximum number of hops to search for target.
	-i address       Use the specified source address.
    	-n               Do not resolve addresses to hostnames.
    	-p period        Wait period milliseconds between pings.
	-q num_queries   Number of queries per hop.
   	-w timeout       Wait timeout milliseconds for each reply.
    	-4               Force using IPv4.
    	-6               Force using IPv6.

ping $IP		ping	
	-a		resolve address
	-n 		change default packet count

route 	
	print 		display active routes

# tasklist /svc
sc start	# start a service
sc stop		# stop a service


set # ALso good for network enumeration as environment variables
	PATH=C:\YourFavouritePrivEscDir # for Hijack Execution Flow
	# change PATH to friendly directory and drop malicious .exe, call the legitimate exe but it run the closest searched PATH variable
setx	# Similar but requires new command prompt, then run set


systeminfo # ALSO good for network enumeration
#remote systeminfo checking
	/s computerName /u username\domainName /p password

tracert 
# uses ICMP Time to live(TTL) field values - as packet path from router to router TTL decremented to 0
# Then a message back is sent to the source device
# Default max hops: 30
	-d                 Do not resolve addresses to hostnames.
	-h maximum_hops    Maximum number of hops to search for target.
    	-j host-list       Loose source route along host-list (IPv4-only).
    	-w timeout         Wait timeout milliseconds for each reply.
    	-R                 Trace round-trip path (IPv6-only).
    	-S srcaddr         Source address to use (IPv6-only).
    	-4                 Force using IPv4.
    	-6                 Force using IPv6.
```
