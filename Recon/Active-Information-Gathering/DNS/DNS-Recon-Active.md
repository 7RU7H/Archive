# DNS Active Recon
[DNS](https://en.wikipedia.org/wiki/Domain_Name_System) is a distributed database responsible for translating domain names into IP addresses. [[DNS-Defined]] for conceptual stuff and for passive DNS recon [[DNS-Recon-Passive]]

## Host lookup
```bash
nslookup
> server $IP
# try it's local addresses
> 127.0.0.1
> 127.0.0.2
```

```bash
host www.domain.com # return ip for a domain
host -t ns $url # find nameservers for a domain
host -t mx $url # find mailservers for a domain
host -l $domain $ns1-domain # List of DNS servers
```
Parse just DNS hostnames
```bash
for server in $(host -t ns megacorpone.com | cut -d" " -f4); do host -l megacorpone.com $server; done
```

## Forward Lookup Brute Forcing

TL;DR - Forward lookup: query hostname for IP - What is the IP of this hostname?
Foward lookup is defined as requesting an IP address of a hostname to query both a valid and an invalid hostname, if host successfully resolves a name to an IP, it could indicate a functional server. Check Seclists, [[Wordlist-Library]] and [[Wordlists-Considerations]] for comprehensive subdomain brute-forcing to  automate the forward DNS lookup of common hostnames.
```bash
for ip in $(cat list.txt); do host $ip.<insert-domain-name>.com; done
```
[Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/forwardDNSLookup.sh)

## Reverse Lookup Brute Forcing
TL;DR - Reverse lookup: query IP for this hostname - What Hostname is using this IP?
```bash
for ip in $(seq  50 100); do host <known-ip-range>.$ip; done | grep -v "not found"
for ip in $(seq 0 255); do dig -x 192.168.156.$ip; done | grep "ANSWER: 1"

```
[Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/reverseLookupBruteForcer.sh)

## Tools

[[Fierce-Cheatsheet]]
[[DNSenum-Cheatsheet]] 
DNSRecon is an advanced, modern DNS enumeration script written in Python.

## DNS Zone Transfer

TL;DR - DNS Zone Transfer - Database replication between related DNS servers in zone file is copied from a master DNS server to a slave server. If you can perform a DNS zone tranfer you can get alot of Network Information that the DNS server is connected to.

[DNS Zone Transfer](https://en.wikipedia.org/wiki/DNS_zone_transfer) *"also sometimes known by the inducing DNS query type AXFR, is a type of DNS transaction. It is one of the many mechanisms available for administrators to replicate DNS databases across a set of DNS servers. A zone transfer uses the Transmission Control Protocol for transport, and takes the form of a client–server transaction."* The result of a successful zone transfer is the zone file containing information about the entire DNS zone.

- Zone transfers should only be allowed to authorized slave DNS servers

```bash
dnsrecon -t axfr -d $DOMAIN
dig axfr $domain @$ip
dig $domain.com ANY +noall +answer
```
See [[DIG-cheatsheet]]

[DNSrecon](https://github.com/darkoperator/dnsrecon) can perform zone transfer with `-t` flag. Can also bruteforce DNS hostnames with `-D`
```bash
usage: dnsrecon.py [-h] [-d DOMAIN] [-n NS_SERVER] [-r RANGE] [-D DICTIONARY] [-f] [-a] [-s] [-b] [-y] [-k] [-w] [-z] [--threads THREADS] [--lifetime LIFETIME] [--tcp] [--db DB] [-x XML] [-c CSV] [-j JSON] [--iw] [--disable_check_recursion] [--disable_check_bindversion] [-V] [-v] [-t TYPE]
dnsrecon -d $domain.com -t axfr # Zone tranfser
dnsrecon -d $domain.com -D ~/list.txt -t brt # Brute force
```

```bash
#!/bin/bash

# Simple Zone Transfer Bash Script
# $1 is the first argument given after the bash script
# Check if argument was given, if not, print usage

if [ -z "$1" ]; then
  echo "[*] Simple Zone transfer script"
  echo "[*] Usage   : $0 <domain name> "
  exit 0
fi

# if argument was given, identify the DNS servers for the domain

for server in $(host -t ns $1 | cut -d " " -f4); do
  # For each of these servers, attempt a zone transfer
  host -l $1 $server |grep "has address"
done
```
[Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/dnsZoneTransfer.sh)

## Bruteforcing DNS
```
amass
```



## Reference 
[Wonkastocks]https://pastebin.com/qLitw9eT
[infinitelogins](https://infinitelogins.com/2020/12/09/enumerating-dns-port-53/)
[Forward/Reverse Lookup](https://www.mustbegeek.com/understanding-forward-and-reverse-lookup-zones-in-dns/)
[DNS Zone Transfer Wikipedia](https://en.wikipedia.org/wiki/DNS_zone_transfer)
[Linode Red Team DNS Zone Transfers](https://www.linode.com/docs/guides/red-team-reconnaissance-techniques/#dns-zone-transfers)
[THM DNS in Detail](https://tryhackme.com/room/dnsindetail)