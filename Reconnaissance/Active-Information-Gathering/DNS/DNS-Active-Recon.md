# DNS Active Recon

[DNS](https://en.wikipedia.org/wiki/Domain_Name_System) is a distributed database responsible for translating domain names into IP addresses. [[DNS-Defined]] for conceptual stuff and for passive DNS recon [[DNS-Recon-Passive]].

- Priority - DNS Priority - The lower the number, the higher the priority. [infosecinstitute -dns-hacking](https://resources.infosecinstitute.com/topic/dns-hacking/)

#### Host Discovery

The website [dnsdumpster](https://dnsdumpster.com/) *"is a FREE domain research tool that can discover hosts related to a domain. Finding visible hosts from the attackers perspective is an important part of the security assessment process."*
- Non-Bruteforce
- Pro-version for more queries

[nmmapper's python tool dnsdumpster](https://github.com/nmmapper/dnsdumpster) is *"a tool to perform DNS reconnaissance on target networks. Among the DNS information got from include subdomains, mx records, web application firewall detection and more fingerprinting and lookups"*. 

#### Certificate Search

[Bharath](https://blog.appsecco.com/a-penetration-testers-guide-to-sub-domain-enumeration-7d842d5570f6):*"Certificate Transparency(CT) is a project under which a Certificate Authority(CA) has to publish every SSL/TLS certificate they issue to a public log. An SSL/TLS certificate usually contains domain names, sub-domain names and email addresses."* In the article [Bharath](https://medium.com/@0xbharath?source=---two_column_layout_sidebar----------------------------------) recommends:
- [https://censys.io/](https://censys.io/)
- [https://developers.facebook.com/tools/ct/](https://developers.facebook.com/tools/ct/)
- [https://google.com/transparencyreport/https/ct/](https://www.google.com/transparencyreport/https/ct/)
- [crt.sh](https://crt.sh/) is a online certificate fingerprinter. Where you provide *".. an **Identity** (Domain Name, Organization Name, etc), a **Certificate Fingerprint** (SHA-1 or SHA-256) or a **crt.sh ID**"*
crt.sh has a [[PostgreSQL]] database for CT logged data: 
```bash
psql -h crt.sh -p 5432 -U guest certwatch
```

#### DNSSEC

[ldns-walk](https://linux.die.net/man/1/ldns-walk) *"is used to retrieve the contents of a DNSSEC signed zone. It does this through NSEC-walking (following the chain of NSEC records) and 'guessing' the next non-existent owner name for each NSEC...Note that it might get stuck on some wildcard records when used through a caching forwarder. This problem can be circumvented by querying the authoritative nameserver directly (with the @ argument). Of course the nameserver that is used must be DNSSEC-aware."*

```bash
# full walk -f; -s good for large zone as is continuous 
ldns-walk -f @$nameserver -s $ownername
```

[nsec3walker](https://dnscurve.org/nsec3walker.html)

[nsec3mapper](https://github.com/anonion0/nsec3map) *"a tool to enumerate the resource records of a DNS zone using its DNSSEC NSEC or NSEC3 chain.It can be used to discover hosts in a DNS zone quickly and with a minimum amount of queries if said zone is DNSSEC-enabled. `n3map` was written primarily to show that NSEC3 does not offer meaningful protection against zone enumeration. Although originally only intended as a PoC and written in Python, it is actually quite fast and able to enumerate even large zones (with a million or more entries) in a short time given adequate hardware. It also includes a simple [John the Ripper](https://github.com/openwall/john "John the Ripper (Jumbo)") plugin that can be used to crack the obtained NSEC3 hashes."*

#### Host lookup

`nslookup` is useful for query DNS servers 
```bash
nslookup
# Set variables! - 
> server $IP
# Try it's local addresses
> 127.0.0.1
> 127.0.0.2
# Try domains and subdomains
> domain.tld

# Resolve A record
nslookup $ns.$domain.$tld
# Resolve TXT to a specific host from the previous command output 
nslookup -type=TXT $ns.$domain.$tld $hostIP
```

`host` 
```bash
# Get A record
host $domain
# Detirmine subdomain existence
host $subdomain.$domain
# Get * record type
host -t mx $domain
host -t txt $domain
host -t ns $url 
# List of DNS servers
host -l $domain $ns1.$domain 
```

Parse just DNS hostnames
```bash
for server in $(host -t ns megacorpone.com | cut -d" " -f4); do host -l megacorpone.com $server; done
```

#### Forward Lookup Brute Forcing

TL;DR - Forward lookup: query hostname for IP - What is the IP of this hostname? Forward lookup is defined as requesting an IP address of a hostname to query both a valid and an invalid hostname, if host successfully resolves a name to an IP, it could indicate a functional server. Check Seclists, [[Wordlist-Library]] and [[Wordlist-Considerations]] for comprehensive subdomain brute-forcing to  automate the forward DNS lookup of common hostnames.
```bash
for ns in $(cat /usr/share/seclists/Discovery/DNS/$list.txt); do host $ns.$domain.$tld | tee -a $domain-subdomains-with-host.txt; done

cat $domain-subdomains-with-host.txt | grep -v 'not found\|error'


# Give the output from the above scan IP address with `host` from subnet range from $lowest to $highest  



low=0
high=255
for ip in $(seq $low $high); do host 10.10.10.$ip; done | grep -v "not found"
```
[Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/forwardDNSLookup.sh)

#### Reverse Lookup Brute Forcing

TL;DR - Reverse lookup: query IP for this hostname - What Hostname is using this IP?
```bash
for ip in $(seq  50 100); do host <known-ip-range>.$ip; done | grep -v "not found"
for ip in $(seq 0 255); do dig -x 192.168.156.$ip; done | grep "ANSWER: 1"
```
[Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/reverseLookupBruteForcer.sh)

Tools to consider
[[Fierce-Cheatsheet]]
[[DNSenum-Cheatsheet]] 
[[DNSRecon-Cheatsheet]] is an advanced, modern DNS enumeration script written in Python.

#### DNS Zone Transfer

TL;DR - DNS Zone Transfer - Database replication between related DNS servers in zone file is copied from a master DNS server to a slave server. If you can perform a DNS zone transfer you can get alot of Network Information that the DNS server is connected to.

[DNS Zone Transfer](https://en.wikipedia.org/wiki/DNS_zone_transfer) *"also sometimes known by the inducing DNS query type AXFR, is a type of DNS transaction. It is one of the many mechanisms available for administrators to replicate DNS databases across a set of DNS servers. A zone transfer uses the Transmission Control Protocol for transport, and takes the form of a client–server transaction."* The result of a successful zone transfer is the zone file containing information about the entire DNS zone.

- Zone transfers should only be allowed to authorized slave DNS servers

```bash
dnsrecon -t axfr -d $DOMAIN
dig axfr $domain @$ip
dig $domain.com ANY +noall +answer
```
See [[DIG-cheatsheet]]
See [[DNSRecon-Cheatsheet]]

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

#### Bruteforcing DNS

[[Amass]]
```bash
# Passive DNS recon --passive is deprecated
amass enum -d $domain.$tld
# Active recon 
amass enum -active -d $domain.$tld -addr <address range>
```

#### Stub Resolution

[Massdns](https://github.com/blechschmidt/massdns)

#### Subdomain Enumeration

[[FFUF-Cheatsheet]], [[Gobuster-Cheatsheet]] and [[WFUZZ]] - and many others

[[Search-Engine-Dorking]]
```bash
site:$domain.$tld
```

[[VirusTotal]] runs its own passive DNS replication service at [Search](https://www.virustotal.com/gui/home/search)

## References

[Bharath's "A penetration tester’s guide to subdomain enumeration" blog featured in Niteteam4](https://blog.appsecco.com/a-penetration-testers-guide-to-sub-domain-enumeration-7d842d5570f6)
[Wonkastocks](https://pastebin.com/qLitw9eT)
[Infinitelogins](https://infinitelogins.com/2020/12/09/enumerating-dns-port-53/)
[Forward/Reverse Lookup](https://www.mustbegeek.com/understanding-forward-and-reverse-lookup-zones-in-dns/)
[DNS Zone Transfer Wikipedia](https://en.wikipedia.org/wiki/DNS_zone_transfer)
[Linode Red Team DNS Zone Transfers](https://www.linode.com/docs/guides/red-team-reconnaissance-techniques/#dns-zone-transfers)
[THM DNS in Detail](https://tryhackme.com/room/dnsindetail)
[Massdns](https://github.com/blechschmidt/massdns)
[Zone transfer Script](https://github.com/7RU7H/AllTheHackingScripts/blob/main/bash/dnsZoneTransfer.sh)
[Wikipedia DNS](https//en.wikipedia.org/wiki/Domain_Name_System) [dnsdumpster](https//dnsdumpster.com/)
[nmmapper's python tool dnsdumpster](https//github.com/nmmapper/dnsdumpster)
[crt.sh](https//crt.sh/)
[ldns-walk](https//linux.die.net/man/1/ldns-walk)
[nsec3walker](https//dnscurve.org/nsec3walker.html)
[nsec3mapper](https//github.com/anonion0/nsec3map)
[infosecinstitute-dns-hacking](https://resources.infosecinstitute.com/topic/dns-hacking/)
