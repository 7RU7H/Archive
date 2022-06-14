# DNS Enumeration

The domain registrar is responsible for maintaining the WHOIS records for the domain names it is leasing. `whois` will query the WHOIS server to provide all saved records.
```bash
whois $url
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

dig $url [type]		# Domain Information Groper
```

BE AWARE !! consider DNSdumpster tool for subdomains, and Shodan.io for exposed IoT anythings connected to networks

[THM room](https://tryhackme.com/room/redteamrecon)