# Evading Firewalls

This article contains methods to evade Firewalls check [[Firewalls]] for typological information.

## Evasion Via Controlling the Source MAC/IP/Port

1.  Evasion via controlling the source MAC/IP/Port
2.  Evasion via fragmentation, MTU, and data length
3.  Evasion through modifying header fields

## Evasion via Forcing Fragmentation, MTU, and Data Length

Controlling the packet size as it allows you to:

-   Fragment packets, optionally with given MTU. If the firewall, or the IDS/IPS, does not reassemble the packet, it will most likely let it pass. Consequently, the target system will reassemble and process it.
-   Send packets with specific data lengths.

## Evasion via Modifying Header Fields

-   Set IP time-to-live
-   Send packets with specified IP options
-   Send packets with a wrong TCP/UDP checksum

## Evasion Using Port Hopping

Port hopping is a technique is either:
- Where an application hops from one port to another till it can establish and maintain a connection.
Or
- Where the application establishes the connection on one port and then starts transmitting some data; after a while, it establishes a new connection on (hopping to) a different port and resumes sending more data.

##  Evasion Using Port Tunneling

[[Port-Redirection-And-Tunneling]]

## Evasion Using Non-Standard Ports

Evasion Using Non-Standard Ports requires knowing or enumerating till you do know which destination ports the firewall does not block packets to. 


## References

[THM Firewalls Room](https://tryhackme.com/room/redteamfirewalls)