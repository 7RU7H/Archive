# DNS Defined

## Introduction

Domain Name System([DNS](https://en.wikipedia.org/wiki/Domain_Name_System)) is a distributed database responsible for translating domain names into IP addresses. 

## Links
[For Active Enumeration](DNS-Recon-Active.md) and [for Passive Enumeration](DNS-Recon-Passive.md)

## Theory

```
www.root.com # Top level domain root
```

Process to resolve this hostname:

1. User requests the `hostname` through a [browser](https://www.mozilla.org/en-GB/firefox/new/), `curl`, `wget`
1. The `Software used above` then passes the `hostname` to the operating system's DNS client 
1. DNS client then forwards the request to the external DNS server it is configured to use.
1. The DNS Recursor contacts one of the servers in the DNS root zone. 
1. The root server responds with the address of the server responsible for the zone containing the Top Level Domain (TLD)
1. DNS recursor then queries for the address of authoritative nameserver

A DNS recursor is responsible for interacting with the DNS infrastructure and returning the results to its DNS client. When hostname is requested a DNS recursor is the first to be contacted, which then contacts one of the servers in the DNS root zone. 

The authoritative nameserver contains DNS records in a local database known as the zone file. Generally comprised of:
1. Forward lookup zone  
2. Reverse lookup zone 

These are used find specific hostname and IP addresses.

DNS caching is used to store local copies of DNS records at various stages of the lookup process to improve performance. Browser have a separate DNS cache from  local DNS client. The  DNS record's cache lifespan is set by Domain Owner with the Time To Live (TTL) field of a DNS record.It is used to improve performance and reliablitity of DNS.

Record | Description
--- | ---
NS |  Nameserver records contain the name of the authoritative servers hosting the DNS records for a domain.
A | Also known as a host record contains the IP address of a hostname 
MX | Mail Exchange records contain the names of the email servers.
PTR |  Pointer Records are used in reverse lookup zones and are used to find the records associated with an IP address.
CNAME | Canonical Name Records are used to create aliases for other host records.
TXT | Text records can contain any arbitrary data and can be used for various purposes, such as domain ownership verification.

## DNS Limitations
- It is not a transport protocol!
-   The maximum length of the Fully Qualified FQDN domain name (including .separators) is 255 characters.
-   The subdomain name (label) length must not exceed 63 characters (not including .com, .net, etc)

## DNSSEC

DNSSEC protects internet users and applications from forged domain name system (DNS) data by using public key cryptography to digitally sign authoritative zone data when it enters the DNS and then validate it at its destination.