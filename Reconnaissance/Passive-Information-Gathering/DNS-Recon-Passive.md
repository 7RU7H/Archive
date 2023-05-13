# DNS Passive Recon

For [[DNS-Defined]], [[DNS-Active-Recon]]

The domain registrar is responsible for maintaining the WHOIS records for the domain names it is leasing. `whois` will query the WHOIS server to provide all saved records.
```bash
# WHOIS server $ip 
whois $domain -h $serverIP
# Registrar Names
# Name servers

# Perform reverse lookups
# If NS records are found and have more NS IP(s) 
whois $ip -h $serverIP 
# Who is hosting that IP address
	```
`whois` will return:
-   Registrar WHOIS server
-   Registrar URL
-   Record creation date
-   Record update date
-   Registrant contact info and address (unless withheld for privacy)
-   Admin contact info and address (unless withheld for privacy)
-   Tech contact info and address (unless withheld for privacy)
-   Name Servers

```bash
nslookup [-type=] $url A=ipv4,AAAA=ipv6,cname=CanonicalName,MX=MailServers,SOA=stateofAuthority,txt=txtrecords 

dig $domain [type]		# Domain Information Groper
```
See [[DIG-cheatsheet]]

BE AWARE !! consider DNSdumpster tool for subdomains, and Shodan.io for exposed IoT anythings connected to networks

## ViewDNS

[ViewDNS.info](https://viewdns.info/) is third party to yourself and target that offer reverse lookup.

## Netcraft
 
https://searchdns.netcraft.com a *"Netcraft extension to ensure you don't get tricked by criminals. It's backed by our [malicious site feeds](https://www.netcraft.com/cybercrime/malicious-site-feeds/) that protect billions of people around the world from phishing, malware and other cybercrime activities."*"

## Threat Intelligence Platform

[Threat Intelligence Platform](https://threatintelligenceplatform.com/) is visualisation tool for `dig` and `whois` that requires you to provide a domain name or an IP address then launching tests from malware checks to WHOIS and DNS queries.

## Censys Search
[Censys Search](https://search.censys.io) for extensive IP information


## References

[THM Red Team Recon Room](https://tryhackme.com/room/redteamrecon)
[ViewDNS.info](https://viewdns.info/)
[THM DNS in Detail](https://tryhackme.com/room/dnsindetail)
https://searchdns.netcraft.com
[Netcraft malicious site feeds](https://www.netcraft.com/cybercrime/malicious-site-feeds/) 