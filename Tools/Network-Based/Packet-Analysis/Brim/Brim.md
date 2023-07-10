# Brim

Brim is an open-source desktop application that processes .pcap files and logs files, with a primary focus on providing search and analytics using the [[Zeek]] log processing format. It supports [[Zeek]] signatures and [[Suricata]] rules for detection. Brim uses Zed, which is a command-line tool to manage and query Zed data lakes.

[Full command list can be found here](https://zed.brimdata.io/docs/commands/zed/) and useful ones or one-liner can be found here:

```c++
# Get hostname by DHCP
_path "dhcp" | cut client_addr, client_fqdn 
# Get MAC address

_path "dhcp" | cut client_addr, client_fqdn, mac

# Get http sites
_path "http" | cut id.orig_h, id.resp_h, host, referrer | uniq

#Or for timestamp, ips and uri
method=="GET" | cut ts, uid, id, method, host, uri, status_code

# http request with method, host, uri, response_body_len
_path=="http" | cut id.orig_h, id.resp_h, id.resp_p, method,host, uri,response_body_len | uniq -c

# http request with method, host, uri, user_agent
_path=="http" | cut id.orig_h, id.resp_h, id.resp_p, method,host, uri, user_agent | uniq -c


# Unique DNS queries
_path=="dns" | sort query
_path=="dns" | count() by query | sort -r # Beware of how it counts


# Suricata Alerts
event_type=="alert" 

# By source and destination
event_type=="alert" | alerts := union(alert.category) by src_ip, dest_ip

```


## References

[https://kifarunix.com/analyze-network-traffic-using-brim-security/](https://kifarunix.com/analyze-network-traffic-using-brim-security/)
[THM Brim Room](https://tryhackme.com/room/brim)