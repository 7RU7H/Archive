# LDAP Recon

## Nmap

```bash
nmap -vv --script=ldap-search -p 389 --script-args ldap.maxobjects=-1 -oA nmap/ldap-search $IP
```

## ldapsearch

```bash
ldapsearch ldap://$IP -x # Simple authentication if this work try the below
ldapsearch -x -s base <namingcontexts>

# Extract an unauthenticated dump of all objects held within the LDAP directory structure
ldapsearch -LLL -x -H ldap://<domain fqdn> -b '' -s base '(objectClass=*)'
# Just Persons
ldapsearch -LLL -x -H ldap://<domain> -b 'DC=htb,DC=local' '(objectClass=Person)' | tee -a ldapsearch-person



# Extract all user objects
ldapsearch -x -H ldap://$IP -D '<domain>\<username>' -w '<password>' -b "CN=Users,DC=<domain>,DC=<domain>"
# Extract all computer objects
ldapsearch -x -H ldap://$IP -D '<domain>\<username>' -w '<password>' -b "CN=Computers,DC=<domain>,DC=<domain>"
# Extract domain admins objects
ldapsearch -x -H ldap://$IP -D '<domain>\<username>' -w '<password>' -b "CN=Domain Admins,CN=Users,DC=<domain>,DC=<domain>"
```

## ldapdomaindump
```bash
ldapdomaindump -u '<DOMAIN>\<USERNAME>' -p <PASSWORD> $IP -o $output-directory-name

#ldd2bloodhound -d $output-directory-name/*.json # Visualise with Bloodhound BUT:
# Note that these files are only compatible with **BloodHound 1.x** which is quite old. There are no plans to support the latest version as the [BloodHound.py project](https://github.com/fox-it/BloodHound.py) was made for this. With the DCOnly collection method this tool will also only talk to LDAP and collect more information than ldapdomaindump would.
```

Optional user and password

## Python Ldap
[See script for enumeration](https://github.com/curtishoughton/Penetration-Testing-Cheat-Sheet/blob/master/Enumeration/LDAP/LDAP.md)

## Rogue LDAP Server?
[[Kali-Setup-Rogue-LDAP-Server]]
A malicious LDAP server for JNDI injection attacks. [Github-veracode-research rogue-jndi](https://github.com/veracode-research/rogue-jndi)

## References
[Curtis Houghton is awesome](https://github.com/curtishoughton/Penetration-Testing-Cheat-Sheet/blob/master/Enumeration/LDAP/LDAP.md)
[Pentest CS for LDAP ivanversluis](https://github.com/ivanversluis/pentest-hacktricks/blob/master/pentesting/pentesting-ldap.md)