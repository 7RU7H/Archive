# TCP Wrappers

[Wikipedia state that TCP Wrappers](https://en.wikipedia.org/wiki/TCP_Wrappers) *"is a host-based networking ACL system used to filter network access to TCP/IP Unix-like OSs thereby allowing the host or subnet information - IPs, names, ident query replies, to be used as tokens on which to filter for access control purposes.*"

## Regarding Bypassing it

[Regrading how to bypass TCP Wrappers](https://security.stackexchange.com/questions/23407/how-to-bypass-tcpwrapped-with-nmap-scan) the [author of the SecWiki article](https://secwiki.org/w/FAQ_tcpwrapped) - *"When `nmap` ([[Nmap-Cheatsheet]]) labels something `tcpwrapped`, it means that the behaviour of the port is consistent with one that is protected by tcpwrapper. Specifically, it means that a full TCP handshake was completed, but the remote host closed the connection without receiving any data. It is important to note that tcpwrapper protects _programs_, not ports. This means that a valid (not false-positive) `tcpwrapped` response indicates a real network service is available, but you are not on the list of hosts allowed to talk with it. When such a large number of ports are shown as `tcpwrapped`, it is unlikely that they represent real services, so the behaviour probably means something else. What you are probably seeing is a network security device like a firewall or IPS. Many of these are configured to respond to TCP portscans, even for IP addresses which are not assigned to them. This behaviour can slow down a port scan and cloud the results with false positives."


## References

[TCP Wrappers Wikpedia](https://en.wikipedia.org/wiki/TCP_Wrappers)
[How to  bypass TCP Wrappers question on stackexchange](https://security.stackexchange.com/questions/23407/how-to-bypass-tcpwrapped-with-nmap-scan) 
[TCP Wrapped FAQ SecWiki article](https://secwiki.org/w/FAQ_tcpwrapped)