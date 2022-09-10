# Firewalls
A firewall is software or hardware that monitors the network traffic and compares it against a set of rules before passing or blocking it. For evasion techniques see [[Evading-Firewalls]]

## Types of Firewall
-   Packet-Filtering Firewall: Packet-filtering inspects the protocol, source and destination IP addresses, and source and destination ports in the case of TCP and UDP datagrams. It is a stateless inspection firewall.
-   Circuit-Level Gateway: In addition to the features offered by the packet-filtering firewalls, circuit-level gateways can provide additional capabilities, such as checking TCP three-way-handshake against the firewall rules.
-   Stateful Inspection Firewall: Track of the established TCP sessions, therefore it can detect and block any TCP packet outside an established TCP session.
-   Proxy Firewall: A proxy firewall is also referred to as Application Firewall (AF) and Web Application Firewall (WAF). It is designed to masquerade as the original client and requests on its behalf. This process allows the proxy firewall to inspect the contents of the packet payload instead of being limited to the packet headers. Generally speaking, this is used for web applications and does not work for all protocols.
-   Next-Generation Firewall (NGFW): It can  monitor all network layers, from OSI Layer 2 to OSI Layer 7. It has application awareness and control. 
-   Cloud Firewall or Firewall as a Service (FWaaS): FWaaS replaces a hardware firewall in a cloud environment. Its features might be comparable to NGFW, depending on the service provider; however, it benefits from the scalability of cloud architecture. 

##  Next-Generation Firewalls

-   Integrate a firewall and a real-time Intrusion Prevention System (IPS). It can stop any detected threat in real-time.
-   Identify users and their traffic. It can enforce the security policy per-user or per-group basis.
-   Identify the applications and protocols regardless of the port number being used.
-   Identify the content being transmitted. It can enforce the security policy in case any violating content is detected.
-   Ability to decrypt SSL/TLS and SSH traffic. For instance, it restricts evasive techniques built around encryption to transfer malicious files.

## References

[THM Firewalls Room](https://tryhackme.com/room/redteamfirewalls)