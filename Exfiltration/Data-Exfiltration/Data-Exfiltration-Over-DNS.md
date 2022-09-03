# Data Exfiltration Over DNS

## Introduction and Configuration
For more detail about DNS go to the [[DNS-Defined]] article, otherwise we also require control of a domain name with DNS records including NS, A or TXT. [[Setup-DNS]] or you do the [THM Data Exfiltration](https://tryhackme.com/room/dataxexfilt) where they have one setup to be configurable. The IP address you want to exfiltrate data to, in this article stated as variable `$exfil-to-IP`

To be successful:
1. Add an A record that points to the IP you want to exfiltrate data to:
	- `Type A, Subdomain Name: $subdomainnameNS, Value: $exfil-to-IP`
2. Add NS record that routes DNS queries to the A record above
	- `Type NS, Subdomain Name: $subdomainname, Value: $subdomainnameNS.$control_domain_name.com`

Like:
**DNS Record** | **Type** | **Value**
--- | --- | ---
`$subdomainnameNS`.domainname.com  | A   |  `$exfil-to-IP`
`$subdomainname`.domainname.com | NS | `$subdomainnameNS`.domainname.com

To resolve:
```bash
dig +short `$subdomainname.$domainname.com 
```

## Exfiltration Over DNS




## References

[THM Data Exfiltration](https://tryhackme.com/room/dataxexfilt)