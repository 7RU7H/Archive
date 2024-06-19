# DNS Defined

## Introduction

Domain Name System([DNS](https://en.wikipedia.org/wiki/Domain_Name_System)) is a distributed database responsible for translating domain names into IP addresses. 

A DNS Server provides:
- Maintains a local cache of recently accessed or used domain names and their IP addresses.
- Maintains the key-value pair database of IP addresses and any host or subdomain over which the DNS server has authority

## Links

[For Active Enumeration](DNS-Active-Recon.md)
[for Passive Enumeration](DNS-Recon-Passive.md)
[[Azure-Administration-Azure-DNS]]

## Theory

```
www.root.com # Top level domain root
```

Process to resolve this hostname:

1. User requests the `hostname.` through a [browser](https://www.mozilla.org/en-GB/firefox/new/) (or locally: [[Browsers]]), `curl`, `wget`, etc
1. The `Software used above` then passes the `hostname` to the operating system's DNS client 
1. DNS client then forwards the request to the external DNS server (DNS Recursor) it is configured to use.
1. The DNS Recursor contacts one of the servers in the DNS root zone. 
1. The Root Server responds with the address of the server responsible for the zone containing the Top Level Domain (TLD)
1. DNS Recursor then queries the Root Server for the address of Authoritative Nameserver for `$domain.$tld`'s IP
	 - The Authoritative Nameserver contains the DNS records in a local database known as the zone file.
	 - Typically hosts two zones for each domain:
		 - Forward Lookup Zone: used to find an IP address of specific hostname
		 - Reverse Lookup Zone: used to find a hostname to a specific IP 
1. The tool used to request the hostname then display the page in the terminal or browser

A DNS recursor is responsible for interacting with the DNS infrastructure and returning the results to its DNS client. When hostname is requested a DNS recursor is the first to be contacted, which then contacts one of the servers in the DNS root zone. 

The authoritative nameserver contains DNS records in a local database known as the zone file. Generally comprised of:
1. Forward lookup zone  
2. Reverse lookup zone 

These are used find specific hostname and IP addresses.

DNS caching is used to store local copies of DNS records at various stages of the lookup process to improve performance. Browser have a separate DNS cache from  local DNS client. The  DNS record's cache lifespan is set by Domain Owner with the Time To Live (TTL) field of a DNS record.It is used to improve performance and reliability of DNS.

| Record     | Description                                                                                                                                                                                                              |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| NS         | Nameserver records contain the name of the authoritative servers hosting the DNS records for a domain.                                                                                                                   |
| A          | Also known as a host record contains the IP address of a hostname                                                                                                                                                        |
| MX         | Mail Exchange records contain the names of the email servers.                                                                                                                                                            |
| PTR        | Pointer Records are used in reverse lookup zones and are used to find the records associated with an IP address.                                                                                                         |
| CNAME      | Canonical Name Records are used to create aliases for other host records. Forwards one domain or subdomain to another domain, does NOT provide an IP                                                                     |
| TXT        | Text records can contain any arbitrary data and can be used for various purposes, such as domain ownership verification.                                                                                                 |
| AAAA       | The record that contains the IPv6 address for a domain (as opposed to A records, which list the IPv4 address). [Learn more about the AAAA record.](https://www.cloudflare.com/learning/dns/dns-records/dns-aaaa-record/) |
| SOA record | Stores admin information about a domain.                                                                                                                                                                                 |
| SRV record | Specifies a port for specific services.                                                                                                                                                                                  |
| PTR record | Queries an IP to return a domain name in what is called a reverse lookup.                                                                                                                                                |

- Priority - DNS Priority - The lower the number, the higher the priority. [infosecinstitute -dns-hacking](https://resources.infosecinstitute.com/topic/dns-hacking/)

#### Less Common Records

From [Cloudflare's Learning dns-records](https://www.cloudflare.com/learning/dns/dns-records/)

- **AFSDB record** - This record is used for clients of the Andrew File System (AFS) developed by Carnegie Melon. The AFSDB record functions to find other AFS cells.
-   **APL record** - The ‘address prefix list’ is an experiment record that specifies lists of address ranges.
-   **CAA record** - This is the ‘certification authority authorization’ record, it allows domain owners state which certificate authorities can issue certificates for that domain. If no CAA record exists, then anyone can issue a certificate for the domain. These records are also inherited by subdomains.
-   **DNSKEY record** - The ‘[DNS Key Record](https://www.cloudflare.com/learning/dns/dns-records/dnskey-ds-records/)’ contains a [public key](https://www.cloudflare.com/learning/ssl/how-does-public-key-encryption-work/) used to verify [Domain Name System Security Extension (DNSSEC)](https://www.cloudflare.com/learning/dns/dns-security/) signatures.
-   **CDNSKEY record** - This is a child copy of the DNSKEY record, meant to be transferred to a parent.
-   **CERT record** - The ‘certificate record’ stores public key certificates.
-   **DCHID record** - The ‘DHCP Identifier’ stores info for the Dynamic Host Configuration Protocol (DHCP), a standardized network protocol used on IP networks.
-   **DNAME record** - The ‘delegation name’ record creates a domain alias, just like CNAME, but this alias will redirect all subdomains as well. For instance if the owner of ‘example.com’ bought the domain ‘website.net’ and gave it a DNAME record that points to ‘example.com’, then that pointer would also extend to ‘blog.website.net’ and any other subdomains.
-   **HIP record** - This record uses ‘Host identity protocol’, a way to separate the roles of an IP address; this record is used most often in mobile computing.
-   **IPSECKEY record** - The ‘IPSEC key’ record works with the [Internet Protocol Security (IPSEC)](https://www.cloudflare.com/learning/network-layer/what-is-ipsec/), an end-to-end security protocol framework and part of the Internet Protocol Suite [(TCP/IP)](https://www.cloudflare.com/learning/ddos/glossary/tcp-ip/).
-   **LOC record** - The ‘location’ record contains geographical information for a domain in the form of longitude and latitude coordinates.
-   **NAPTR record** - The ‘name authority pointer’ record can be combined with an [SRV record](https://www.cloudflare.com/learning/dns/dns-records/dns-srv-record/) to dynamically create URI’s to point to based on a regular expression.
-   **NSEC record** - The ‘next secure record’ is part of DNSSEC, and it’s used to prove that a requested DNS resource record does not exist.
-   **RRSIG record** - The ‘resource record signature’ is a record to store digital signatures used to authenticate records in accordance with DNSSEC.
-   **RP record** - This is the ‘responsible person’ record and it stores the email address of the person responsible for the domain.
-   **SSHFP record** - This record stores the ‘SSH public key fingerprints’; SSH stands for Secure Shell and it’s a cryptographic networking protocol for secure communication over an unsecure network.

## DNS Considerations

#### Use case variations

*Split-horizon DNS* (also sometimes called *split-brain DNS*) uses the same DNS domain name for both internet and internal resources.
#### DNS Limitations

- It is not a transport protocol!
- The maximum length of the Fully Qualified FQDN domain name (including .separators) is 255 characters.
- The subdomain name (label) length must not exceed 63 characters (not including .com, .net, etc)

## DNS Security
#### DNSSEC

DNSSEC protects internet users and applications from forged domain name system (DNS) data by using public key cryptography to digitally sign authoritative zone data when it enters the DNS and then validate 
it at its destination.

## Active Directory related DNS
## \_msdcs
`_msdcs` domain **contains subdomains corresponding to all domains in the forest** (labeled by the domain's GUID). In these subdomains are service records for the DCs in those domains.

## Subdomain/VHOSTs

[Virtual hosts](https://httpd.apache.org/docs/2.4/en/vhosts/examples.html) (vhosts) is the name used by Apache httpd, whereas Nginx use [Server Blocks](https://www.nginx.com/resources/wiki/start/topics/examples/server_blocks/).


## References

[msdcs domains](https://standalonelabs.wordpress.com/2011/05/08/what-is-the-_msdcs-subdomain/)
[Cloudflare's Learning dns-records](https://www.cloudflare.com/learning/dns/dns-records/)
[Azure What is DNS](https://learn.microsoft.com/en-us/training/modules/host-domain-azure-dns/2-what-is-azure-dns)
[Microsoft Learn](https://learn.microsoft.com/)