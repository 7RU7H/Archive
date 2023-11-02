# OPSEC 101

Sometimes we all need to return to Opsec 101: 

Operations Security (OPSEC) is a term coined by the United States military. In the field of cybersecurity, let’s start with the definition provided by [NIST](https://csrc.nist.gov/glossary/term/opsec): *“Systematic and proven process by which potential adversaries can be denied information about capabilities and intentions by identifying, controlling, and protecting generally unclassified evidence of the planning and execution of sensitive activities. The process involves five steps: identification of critical information, analysis of threats, analysis of vulnerabilities, assessment of risks, and application of appropriate countermeasures.”*

[The Grugq's OPSEC Because Jail is for wuftpd talk may also be helpful](https://www.youtube.com/watch?v=9XaYdCdwiWU)
[BHIS | OPSEC Fundamentals for Remote Red Teams - Michael Allen](https://youtu.be/AHwfV3NFlno?si=ifq3zSkE2bFvaGJA)

## Human-Level

It is hurts to get fucked, reason you may need OPSEC

1. [Shut the fuck up](https://www.youtube.com/watch?v=OLpeX4RRo28)
	 - If you do not say it, you can't have it extrapolated from what you say.
1. Proactively paranoid - Retroactive does not work
1. Setup before operationalising
	1. Cover ID
	2. Legend - History
2. Be tidy and organised
3. Never use code, Never be explicit
4. Use Crypto-nyms and have them setup prior to use
5. One law a time - do not break all the laws
	- "They" will find a way to get you, for example: Do not do drugs, just to route legally or communicatively, etc to you. 
1. No Cover ID Contamination 
	1. Be conscious of contamination
1. BIGGIE Small's adapted guide to OPSEC
	1. Do not reveal plans
	2. Do not reveal operational details - your TTPs
	3. Zero Trust Policy - Friends are just co-defendants and rats
	4. Do not confuse recreate and work
	5. Do not Operate from your own house
	6. Use [[Tor-Hidden-Services]]
3. Keep personal life separate 
4. Keep person environment contraband free
5. Do not talk to authorities
6. Do not let other have control over your actions

## OS-Level

[[Whonix]]
Use [[Virtual-Machines]] for segmenting work flow

Always vet

Change: 
- username
- hostname
- domain
- password - kali:kali

Change default `user-agent` for tools and use user-agents that replicate target
- use googlebot or windows as 
-  alias nmap,wpscan,curl, etc in .rc file to prevent accidental 

Networking
- no 0.0.0.0 Network service
- ssh port forwarding instead iptables
- use common web server for redirectors
- liberally use redirectors over multiple CSP - c2 traffic goes through these back to server
- Consider [[Tor-Hidden-Services]] - beware the indicators

[[IPsec]] - prevent accidental IP leaking from VPN dropping
```bash
openvpn --script-security 2 --down vpn-down.sh --config $VPNfile
```

VPN security script: `vpn-down.sh`
```bash
#!/bin/bash
echo "Disabling Network Interfaces..."
systemctl stop network-manager
killall -9 dhclient
for in $(ifconfig | grep -iEo '^[a-z0-9]+:' | grep -v '^lo:$' | cut -d ':' -f 1)
do
	ifconfig $i 0.0.0.0 down
done
echo "VPN gone down completed disabling Network Interfaces"
exit
```

[[DNS]] 
3rd party service vetting
- IP space
	- IP vetting
	- IP activity must not corss-contaminate 
		- one IP address per activity/user
- domain name registrar
    - private whois at time of registery
SSL
- certbot --register-unsafely-without-email
- no self-signed certs or default

## Group Specific OpSec Guides

[[Red-Team-OPSEC]]

## References

[The Grugq's OPSEC Because Jail is for wuftpd Talk](https://www.youtube.com/watch?v=9XaYdCdwiWU)
[THM Red Team OpSec]()
[BHIS | OPSEC Fundamentals for Remote Red Teams - Michael Allen](https://youtu.be/AHwfV3NFlno?si=ifq3zSkE2bFvaGJA)