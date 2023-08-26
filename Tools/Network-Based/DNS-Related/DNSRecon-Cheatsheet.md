[DNSrecon](https://github.com/darkoperator/dnsrecon) can perform zone transfer with `-t` flag. Can also bruteforce DNS hostnames with `-D`.

```bash
usage: dnsrecon.py [-h] [-d DOMAIN] [-n NS_SERVER] [-r RANGE] [-D DICTIONARY] [-f] [-a] [-s] [-b] [-y] [-k] [-w] [-z] [--threads THREADS] [--lifetime LIFETIME] [--tcp] [--db DB] [-x XML] [-c CSV] [-j JSON] [--iw] [--disable_check_recursion] [--disable_check_bindversion] [-V] [-v] [-t TYPE]
dnsrecon -d $domain.com -t axfr # Zone tranfser
dnsrecon -d $domain.com -D ~/list.txt -t brt # Brute force
```

[Bharath](https://blog.appsecco.com/a-penetration-testers-guide-to-sub-domain-enumeration-7d842d5570f6)
```bash
dnsrecon.py -n ns1.ns1.insecuredns.com -d insecuredns.com -D /usr/share/seclists/Discovery/DNS/subdomains-top1mil-5000.txt -t brt
```

```bash
# Standard scan
dnsrecon -d megacorpone.com -t std
# Brute force for subdomains
dnsrecon -d megacorpone.com  -D $subdomainWordlist -t brt
```

## References

[Bharath](https://blog.appsecco.com/a-penetration-testers-guide-to-sub-domain-enumeration-7d842d5570f6)