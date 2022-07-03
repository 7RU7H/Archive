# LDAP Recon

## Nmap

```bash
nmap -vv --script=ldap-search -p 389 --script-args ldap.maxobjects=-1 -oA nmap/ldap-search $IP
```

## ldapsearch

```bash
ldapsearch $IP -x # Simple authentication if this work try the below
ldapsearch -x -s base <namingcontexts>

# Extract an unauthenticated dump of all objects held within the LDAP directory structure
ldapsearch -LLL -x -H ldap://<domain fqdn> -b '' -s base '(objectclass=*)'
# Just Persons
ldapsearch -LLL -x -H ldap://htb.local -b 'DC=htb,DC=local' '(objectClass=Person)' > ldapsearch-person



# Extract all user objects
ldapsearch -x -h <IP Address> -D '<domain>\<username>' -w '<password>' -b "CN=Users,DC=<domain>,DC=<domain>"
# Extract all computer objects
ldapsearch -x -h $IP -D '<domain>\<username>' -w '<password>' -b "CN=Computers,DC=<domain>,DC=<domain>"
# Extract domain admins objects
ldapsearch -x -h <IP Address> -D '<domain>\<username>' -w '<password>' -b "CN=Domain Admins,CN=Users,DC=<domain>,DC=<domain>"
```

## ldapdomaindump
```bash
ldapdomaindump -u '<DOMAIN>\<USERNAME>' -p <PASSWORD> $IP -o output.txt
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