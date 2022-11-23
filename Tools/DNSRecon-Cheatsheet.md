[DNSrecon](https://github.com/darkoperator/dnsrecon) can perform zone transfer with `-t` flag. Can also bruteforce DNS hostnames with `-D`.

```bash
usage: dnsrecon.py [-h] [-d DOMAIN] [-n NS_SERVER] [-r RANGE] [-D DICTIONARY] [-f] [-a] [-s] [-b] [-y] [-k] [-w] [-z] [--threads THREADS] [--lifetime LIFETIME] [--tcp] [--db DB] [-x XML] [-c CSV] [-j JSON] [--iw] [--disable_check_recursion] [--disable_check_bindversion] [-V] [-v] [-t TYPE]
dnsrecon -d $domain.com -t axfr # Zone tranfser
dnsrecon -d $domain.com -D ~/list.txt -t brt # Brute force
```