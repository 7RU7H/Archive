# ICMP

The Internet Control Messaging Protocol (ICMP) operates at the Transport layer of TCP/IP. It plays a crucial support function: when there is a problem with the reception of data, it alerts the sender with various kinds of error messages. It generally does not transmit data itself, aside from these error codes. Commonly used to test connectivity via _ping_ (ICMP ECHO). Many administrators erroneously think that ICMP is solely for the `ping` and `traceroute` utilities. They end up not accounting for ICMP traffic, while focusing on TCP and UDP. This provides an attacker with a mostly unobserved communications path.

```bash
ping
```

OS Specific
- Windows `tracert` uses ICMP
- Linux and BSD `traceroute` uses UDP

- ICMP can be used to in Exfiltration: [[Data-Exfiltration-Over-ICMP]]
- One can close existing TCP sessions with specially crafted ICMP unreachable packets (blind connection reset attack): [https://www.owasp.org/images/2/2b/ICMP_Attacks.pdf](https://www.owasp.org/images/2/2b/ICMP_Attacks.pdf)
- Multiple DoS attacks exist that use ICMP: Smurf, Black Nurse, WinNuke, ...
- Can potentially identify which software is pinging you. Linux and Windows use different patterns in their payloads. Some monitoring software advertises itself within the payload. Check this with a sniffer.
- Can be used for transferring files and shell services if an organization isn't watching ICMP traffic:
    - [https://github.com/droberson/icmp-exfil](https://github.com/droberson/icmp-exfil)
    - [https://github.com/JeremyNGalloway/LOKI2](https://github.com/JeremyNGalloway/LOKI2)
- Had a tool similar to this used against my team successfully in an attack/defend CTF:
    - [https://github.com/droberson/icmp-backdoor](https://github.com/droberson/icmp-backdoor)


## References

[GitHub droberson/rtfm/ interaction.md#icmp-notes](https://github.com/droberson/rtfm/blob/master/interaction.md#icmp-notes)