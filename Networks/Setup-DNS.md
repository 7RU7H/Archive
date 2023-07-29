# Setup DNS

This article will require some prior knowledge regarding, although many of the articles listed have this information embedded in them it may be worth briefer schematic information like in [[DNS]] and trouble shooting yourself with [[DNS-Active-Recon]] and [[DNS-Recon-Passive]]

## Debian IPv4 DNS server

This section makes extensive use of this article from [Linuxhint](https://linuxhint.com/configure-dns-server-on-debian/) to make concise checklist of manual instructions without desciption about DNS or aspects of it. For more extensive Debian Adminstration see the [Debian Adminstrator's Handbook](https://www.debian.org/doc/manuals/debian-handbook/sect.domain-name-servers.en.html)

```bash
sudo apt-get update -y && apt-get upgrade -y 
sudo apt install bind9 bind9utils bind9-doc
named -v # check install
# BIND starts automatically when you install it!
sudo systemctl status bind9 #
sudo service bind9 start  
sudo service bind9 stop  
sudo service bind9 restart
# Check port listening on
sudo netstat -lnptu | grep named
# To configure edit the 
cat /etc/bind/named.conf.options
# Then Restart
sudo service bind9 restart
```

By default, BIND is configured to serve the localhost only. To change this:
```bash
# Replace the line
listen-on {127.0.0.1;};  
# The next two lines
listen-on {any;};  
listen-on-v6 { any; }
```

- **Forward Lookup Zones**
These are for resolving domain names to IP addresses of services.

Append the code below with relevant chanes to bash variables with: `echo $codebelow | sudo tee -a etc/bind/named.conf.local` for master DNS record
```bash
zone "$master_domain_name.com" {  
  type master;  
  file "/etc/bind/db.$master_domain_name.com";  
  //allow-transfer {xxx.xxx.xxx.xxx;}; // Secondary DNS server of the hoster  
};
```
You can set the type “**slave**” if you are hosting an authoritative-only forward or reverse zone and do not want to allow dynamic updates. Then create a `db.x.com` for each DNS zone:
```bash
sudo touch /etc/bind/db.$master_domain_name.com
```


The `x.$master_domain_name.local.` extra dot at the end are required
```bash
;    
; BIND data file for local loopback interface  
;    
$TTL    604800    
@       IN      SOA     ns1.$master_domain_name.local. root.$master_domain_name.local. ( 
	                          2         ; Serial    
                         604800         ; Refresh  
                          86400         ; Retry  
                        2419200         ; Expire  
                         604800 )       ; Negative Cache TTL  
;  
; Commentout below three lines  
;@      IN      NS      localhost.  
;@      IN      A       127.0.0.1  
;@      IN      AAAA    ::1  
;Name Server Information  
@       IN      NS      ns1.$master_domain_name.local.  
;IP address of Name Server  
ns1     IN      A       $public_IP_address.10  
;Mail Exchanger    
$master_domain_name.local.   IN     MX   10   mail.$master_domain_name.local.   
;A – Record HostName To IP Address   
www     IN       A      $public_IP_address.100    
mail    IN       A      $public_IP_address.150   
;CNAME record    
ftp     IN      CNAME   <a href="http://www.$master_domain_name.local">www.$master_domain_name.local</a>.
```

You can alter and add services and their individual latter octet to your liking. 

- **Reverse Lookup Zones**
Required to map an IP address into a domain name, used for email. `echo $codebelow | sudo tee -a etc/bind/named.conf.local` 
```bash
touch /etc/bind/.in-addr.arpa 

zone "$email_srv__rev_network_ID.in-addr.arpa" {  # network ID is the first three octets, in reverse! 10.11.12.13 -> 12.11.10.in.addr.arpa
    type master;  
    notify no;  
    file "/etc/bind/db.10";  
};
```
Then create the db.10 file: `sudo touch /etc/bind/10.db` and add this
```bash
;    
; BIND reverse data file for local loopback interface   
;  
$TTL  604800    
@    IN   SOA   $master_domain_name.local. root.$master_domain_name.local. (    
	               2     ; Serial    
	          604800     ; Refresh    
	           86400     ; Retry    
             2419200     ; Expire    
              604800 )   ; Negative Cache TTL    
;    
;@   IN   NS   localhost.    
;1.0.0 IN   PTR   localhost.    
;Name Server Information    
@    IN   NS   ns1.$master_domain_name.local.  
;Reverse lookup for Name Server    
10   IN   PTR  ns1.$master_domain_name.local.    
;PTR Record IP address to HostName    
100   IN   PTR  www.$master_domain_name.local.    
150   IN   PTR  mail.$master_domain_name.local.    
# End of file
```

**THEN CHECK CONFIGURATION FILES**
```bash
sudo named-checkconf
```


## References
https://help.medium.com/hc/en-us/articles/115003053487-Setting-up-a-custom-domain-for-your-profile-or-publication

https://medium.com/nuculabs/setting-up-a-simple-dns-server-859de750f6fe'

[Linuxhint](https://linuxhint.com/configure-dns-server-on-debian/)