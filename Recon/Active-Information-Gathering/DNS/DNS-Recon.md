# DNS
[DNS](https://en.wikipedia.org/wiki/Domain_Name_System) is a distributed database responsible for translating domain names into IP addresses. [[DNS-Theory]]

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

## Tools

[[Fierce-Cheatsheet]]
[[DNSenum-Cheatsheet]]

## DNS zone transfer
[wikipedia](https://en.wikipedia.org/wiki/DNS_zone_transfer)
*DNS zone transfer, also sometimes known by the inducing DNS query type AXFR, is a type of DNS transaction. It is one of the many mechanisms available for administrators to replicate DNS databases across a set of DNS servers. A zone transfer uses the Transmission Control Protocol for transport, and takes the form of a client–server transaction.* The result of a successful zone transfer is the zone file containing information about the entire DNS zone.

TL;DR: Database replication between related DNS servers in which the zone file is copied from a master DNS server to a slave server.

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