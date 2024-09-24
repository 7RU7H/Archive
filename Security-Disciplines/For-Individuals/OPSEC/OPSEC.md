# OPSEC 101

Sometimes we all need to return to OPSEC 101: 

Operations Security (OPSEC) is a term coined by the United States military. In the field of cybersecurity, let’s start with the definition provided by [NIST](https://csrc.nist.gov/glossary/term/opsec): *“Systematic and proven process by which potential adversaries can be denied information about capabilities and intentions by identifying, controlling, and protecting generally unclassified evidence of the planning and execution of sensitive activities. The process involves five steps: identification of critical information, analysis of threats, analysis of vulnerabilities, assessment of risks, and application of appropriate countermeasures.”*

[The Grugq's OPSEC Because Jail is for wuftpd talk may also be helpful](https://www.youtube.com/watch?v=9XaYdCdwiWU)
[BHIS | OPSEC Fundamentals for Remote Red Teams - Michael Allen](https://youtu.be/AHwfV3NFlno?si=ifq3zSkE2bFvaGJA)


- Cover
- Concealment
- Compartmentalisation
	- Segmenting machine, accounts, covers, IOCs 


Must watch
[Part 1-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=9iwh5J71pZg)
[Part 2-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=r4SvCFxTMMk)
[Part 3-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=JlVI705wHq8)
Week later revision, before rewatching the above
[DEF CON 29 Recon Village - Ritu Gil - So You Want to OPSEC, Eh](https://www.youtube.com/watch?v=daXNSvb_S3w)
#### AD ID Level

[Part 2-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=r4SvCFxTMMk) recommends the reading of [Ad IDs Behaving Badly](https://blog.appcensus.io/2019/02/14/ad-ids-behaving-badly/) by  [Serge Egelman](https://blog.appcensus.io/author/serge/)

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

## Your Contacts

The following are all connect to you in terms of data and access points
- Family
- Friends
- Co-Workers
- Neighbours

## Account Level

- Account separation
- Compromised accounts - haveibeenpwned

## Application Level

- Browser
	- Do not use a search engine, just know the URL that are safes 
		- Try `firefox --new-tab github.com`
		- Disable browser defaulting to a search engine
		- Copy and paste the URL from a list and no manual typing
	- Disabling JS in browser
	- Use an extension you *trust* to change the User-Agent for the broswer

- Barcodes - some are more revealing than others 
	- 
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
-  alias `nmap`,`wpscan`,`curl`, etc in .rc file to prevent accidental 

Networking
- no 0.0.0.0 Network service
- ssh port forwarding instead `iptables`
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
    - private whois at time of registry
SSL
- certbot --register-unsafely-without-email
- no self-signed certs or default

#### BHIS Talk on Modern OPSEC for non-criminals (abuse survivors,etc)

The below is a condensed list of actions, services and considerations noted and inspired by [Part 1-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=9iwh5J71pZg), [Part 2-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=r4SvCFxTMMk) and [Part 3-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=JlVI705wHq8). BHIS discussion about How to Live like a Criminal - Privacy Tips for the Non-Criminal is a catchy title but is also how to avoid abusers and be more private our modern techniques as of 2023.   

A concept discussed predominately is the idea of a *pattern of life*. A pattern of life is every behaviour that is a data point or can with analytics and heuristic be evaluated as an assumption either by an algorithm or human analyst. These patterns of a victims life are then enumerated by the threat actor through big data, heuristics and graph based approaches to data analysis the connect you to secondary or tertiary or Nth total connections. Sadly predatory individuals or groups will *watering hole attack* known connections - the example given being that a survivor of domestic abuse will seek shelter with family and friends, but the attacker will enumerate to find these as they know that is where most victim will inherently go for safety. When you *bug out* (abandon your current life, its patterns (using devices, accounts, locations, etc) - you bug out hard. If you disconnect from the connection you do not contaminate or contact until potentially months and years later - do not touch or interact with computers, phones, IOT devices. These devices exist to collect an marshal data. 

This is not for Red teams visit [[Red-Team-OPSEC]]. 

- Grey Man Theory
- Self Assessment
	- Find data connected to an email or name - premium and vetted service
	- 
- Gear
	- Use gift cards
	- Do not **activate** or **use** burner devices in locations that connect to you or secondary or tertiary parties with connections back to you.
	- Buy in cash
		- Farmer Market ATMs - no cameras
	- Do not buy used
	- Prepaid services 
		- Activate with gift cards
		- In the car park - not all at once
	- Wait 10 to 365 days use gear purchased locations with security cameras
		- Security camera footage is retained for Nth length of time
	- Use Infra red filter for face ID or Anti Camera fabrics
	- Tails OS 
- Communications 
	- Duress Message
	- Tor is not that good
	- VPNs - [[IPsec]] is encrypted
	- PGP - use encryption
	- Signal
- IRL  
	- Being followed, go to a markets or festival to lose tails
	- Use Infra red filter for face ID or Anti Camera fabrics
	- EFF - prevent MITM-ing your phone

## Moscow Rules

[Part 1-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=9iwh5J71pZg)
1. Assume Nothing
2. Never go against your gut
3. Everyone is potentially under opposition control
4. Do not look back; you are never completely alone
5. Go with the flow, blend in
6. Vary your pattern and stay within your cover
7. Lull them into a sense of complacency
8. Do not harass the opposition
9. Pick the time and place for action
10. Keep your options open

## 0x0a Hack Commandments - Annotated

[The 0x0a hack Commandments Lyrics](https://genius.com/Dual-core-0x0a-hack-commandments-lyrics)

1. Never let no one know how much code you hold - (do not reveal your capabilities)
2. Never let them know your next move  - (be stealthy and do not telegraph)
3. Never Trust Nobody - (Do not trust others)
4. Shut the !@%& Up - (Shut up)
5. Never do hacks where you rest - (Do not hack at your house)
6. Any logged cleartext, forget it, Encrypt all your data - (Do not touch logs and always use all the encryption ubiquitously)
7. Keep identities and profiles completely separate - (simple)
8. Never keep no weight on you - (Do not store X (cryptocurrency,money,etc) in a place that is easy to access, on your person or )
9. Use your right to your attorney, keep away from police - Use a lawyer, do not talk to police
10.  Shut the actual !@%& Up - See commandment 4
## References

[The Grugq's OPSEC Because Jail is for wuftpd Talk](https://www.youtube.com/watch?v=9XaYdCdwiWU)
[THM Red Team OpSec]()
[BHIS | OPSEC Fundamentals for Remote Red Teams - Michael Allen](https://youtu.be/AHwfV3NFlno?si=ifq3zSkE2bFvaGJA)
[The 0x0a hack Commandments Lyrics](https://genius.com/Dual-core-0x0a-hack-commandments-lyrics)
[Part 1-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=9iwh5J71pZg)
[Part 2-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=r4SvCFxTMMk)
[Part 3-How to Live like a Criminal - Privacy Tips for the Non-Criminal | Ean Meyer & John Strand](https://www.youtube.com/watch?v=JlVI705wHq8)
[DEF CON 29 Recon Village - Ritu Gil - So You Want to OPSEC, Eh](https://www.youtube.com/watch?v=daXNSvb_S3w)


