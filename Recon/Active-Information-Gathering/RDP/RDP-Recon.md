
When logon to domain, try the various: `sub.domain.local\$user` not just what is displayed 


Version and Vulnerability Identification
```bash
# Using nmap NSE scripts
nmap -Pn -sV --version-intensity=5 -p T:3389 --script=xxxx <IP>

# Determines which Security layer and Encryption level is supported by the RDP service
rdp-enum-encryption

# Checks if a machine is vulnerable to MS12-020 RDP vulnerability
rdp-vuln-ms12-020.nse 
```


Credential Brute Force
```bash
# Using ncrack for one user
ncrack -vv -u nina -P passwords.txt rdp://IP
```


## References

[haax.fr](https://cheatsheet.haax.fr/network/services-enumeration/3389_rdp/)