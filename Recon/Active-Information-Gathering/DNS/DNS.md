# DNS
[DNS](https://en.wikipedia.org/wiki/Domain_Name_System) is a distributed database responsible for translating domain names into IP addresses. [[Networks/Network-Theory/DNS]]()

## Host lookup

```bash
host $url 		# ip for a domain
host -t ns $url # find nameservers for a domain
host -t mx $url # find mailservers for a domain
host -l $domain $ns1-domain # List of DNS servers
```
Parse just DNS hostnames
```bash
for server in $(host -t ns megacorpone.com | cut -d" " -f4); do host -l megacorpone.com $server; done
```

## Forward Lookup
[Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/forwardDNSLookup.sh)

## Reverse Lookup Brute Forcing
[Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/reverseLookupBruteForcer.sh)

## Fierce
Fierce A DNS reconnaissance tool for locating non-contiguous IP space.
```bash
fierce -dns $domain
fierce -dns $domain ---dns-servers $nameserver

options:
  -h, --help            show this help message and exit
  --domain DOMAIN       domain name to test
  --connect             attempt HTTP connection to non-RFC 1918 hosts
  --wide                scan entire class c of discovered records
  --traverse TRAVERSE   scan IPs near discovered records, this won't enter adjacent class c's
  --search SEARCH [SEARCH ...]
                        filter on these domains when expanding lookup
  --range RANGE         scan an internal IP range, use cidr notation
  --delay DELAY         time to wait between lookups
  --subdomains SUBDOMAINS [SUBDOMAINS ...]
                        use these subdomains
  --subdomain-file SUBDOMAIN_FILE
                        use subdomains specified in this file (one per line)
  --dns-servers DNS_SERVERS [DNS_SERVERS ...]
                        use these dns servers for reverse lookups
  --dns-file DNS_FILE   use dns servers specified in this file for reverse lookups (one per line)
  --tcp                 use TCP instead of UDP

```

## DNSenum

```bash
GENERAL OPTIONS:
  --dnsserver   <server>
                        Use this DNS server for A, NS and MX queries.
  --enum                Shortcut option equivalent to --threads 5 -s 15 -w.
  -h, --help            Print this help message.
  --noreverse           Skip the reverse lookup operations.
  --nocolor             Disable ANSIColor output.
  --private             Show and save private ips at the end of the file domain_ips.txt.
  --subfile <file>      Write all valid subdomains to this file.
  -t, --timeout <value> The tcp and udp timeout values in seconds (default: 10s).
  --threads <value>     The number of threads that will perform different queries.
  -v, --verbose         Be verbose: show all the progress and all the error messages.
GOOGLE SCRAPING OPTIONS:
  -p, --pages <value>   The number of google search pages to process when scraping names,
                        the default is 5 pages, the -s switch must be specified.
  -s, --scrap <value>   The maximum number of subdomains that will be scraped from Google (default 15).
BRUTE FORCE OPTIONS:
  -f, --file <file>     Read subdomains from this file to perform brute force. (Takes priority over default dns.txt)
  -u, --update  <a|g|r|z>
                        Update the file specified with the -f switch with valid subdomains.
        a (all)         Update using all results.
        g               Update using only google scraping results.
        r               Update using only reverse lookup results.
        z               Update using only zonetransfer results.
  -r, --recursion       Recursion on subdomains, brute force all discovered subdomains that have an NS record.
WHOIS NETRANGE OPTIONS:
  -d, --delay <value>   The maximum value of seconds to wait between whois queries, the value is defined randomly, default: 3s.
  -w, --whois           Perform the whois queries on c class network ranges.
                         **Warning**: this can generate very large netranges and it will take lot of time to perform reverse lookups.
REVERSE LOOKUP OPTIONS:
  -e, --exclude <regexp>
                        Exclude PTR records that match the regexp expression from reverse lookup results, useful on invalid hostnames.
OUTPUT OPTIONS:
  -o --output <file>    Output in XML format. Can be imported in MagicTree (www.gremwell.com)

```

## DNS zone transfer
[wikipedia](https://en.wikipedia.org/wiki/DNS_zone_transfer)
*DNS zone transfer, also sometimes known by the inducing DNS query type AXFR, is a type of DNS transaction. It is one of the many mechanisms available for administrators to replicate DNS databases across a set of DNS servers. A zone transfer uses the Transmission Control Protocol for transport, and takes the form of a client–server transaction.* The result of a successful zone transfer is the zone file containing information about the entire DNS zone.

```bash
dnsrecon -t axfr -d $DOMAIN
dig axfr $domain @$ip
```

[DNSrecon](https://github.com/darkoperator/dnsrecon) can perform zone transfer with `-t` flag. Can also bruteforce DNS hostnames with `-D`
```bash
usage: dnsrecon.py [-h] [-d DOMAIN] [-n NS_SERVER] [-r RANGE] [-D DICTIONARY] [-f] [-a] [-s] [-b] [-y] [-k] [-w] [-z] [--threads THREADS] [--lifetime LIFETIME] [--tcp] [--db DB] [-x XML] [-c CSV] [-j JSON] [--iw]
                   [--disable_check_recursion] [--disable_check_bindversion] [-V] [-v] [-t TYPE]

```

[Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/dnsZoneTransfer.sh)

## Bruteforcing DNS
```
amass
```



## Reference 
[wonkastocks]https://pastebin.com/qLitw9eT
[infinitelogins](https://infinitelogins.com/2020/12/09/enumerating-dns-port-53/)