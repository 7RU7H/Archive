[loads](https://infinitelogins.com/2020/12/09/enumerating-dns-port-53/)


## DNS zone transfer
[wikipedia](https://en.wikipedia.org/wiki/DNS_zone_transfer)
*DNS zone transfer, also sometimes known by the inducing DNS query type AXFR, is a type of DNS transaction. It is one of the many mechanisms available for administrators to replicate DNS databases across a set of DNS servers. A zone transfer uses the Transmission Control Protocol for transport, and takes the form of a client–server transaction.*

```bash
dnsrecon -t axfr -d $DOMAIN
```