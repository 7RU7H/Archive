# Bypassing WAFs

WAFs check headers to prevent out of band communication to endpoints try the following header with and 127.0.0.1 or localhost or contextually appropriate malicious subdomain or spoofed backend machine IP 
- `If-None-Match:` 
- `X-Forwarded-For:`
## Tools 

- [w3af](https://github.com/andresriancho/w3af) - Web Application Attack and Audit Framework
- [wafw00f](https://github.com/EnableSecurity/wafw00f) - Identify and fingerprint Web Application Firewall
	- [[Kali]] package available 
- [BypassWAF](https://github.com/vincentcox/bypass-firewalls-by-DNS-history) **–** Bypass firewalls by abusing DNS history. This tool will search for old DNS A records and check if the server replies for that domain. 
- [CloudFail](https://github.com/m0rtem/CloudFail) – is a tactical reconnaissance tool that tries to find the original IP address behind the Cloudflare WAF.

## References

[hacken.io](https://hacken.io/discover/how-to-bypass-waf-hackenproof-cheat-sheet/)