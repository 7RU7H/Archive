# Active Directory Privilege Escalation
For exploitation see [[AD-Exploitation-Hub]] or general theory and definitions [[Active-Directory-Defined]]. For commands cheatsheet [[Active-Directory-Commands]] or for enumeration see [[Active-Directory-Enumeration-Defined]]. [[Networks/Network-Protocols]] are used extensive, especially [[DNS-Defined]] in AD networks.

THIS VERY WORK IN PROGRESS! AND VERY EARLY THERE ARE BETTER ELSEWHERE

## Scripts
[ADAPE](https://github.com/hausec/ADAPE-Script)

## Tooling
[Flangvik/SharpCollection](https://github.com/Flangvik/SharpCollection) is  a github repose that contains ..*"
Nightly builds of common C# offensive tools, fresh from their respective master branches built and released in a CDI fashion using Azure DevOps release pipelines."* 

## General Enumeration
Go to [[Active-Directory-Enumeration-Cheatsheet]] for a full listing of just commands; [[Active-Directory-Enumeration-Defined]] for more detail whys and hows, but it is still a Windows system you have foothold on so [[Windows-Privilege-Escalation-Vectors]] maybe required! 


## Powerview
PowerView "is a powershell tool to gain network situational awareness one Windows domains." For a good concatenation of all the [[Powerview-Cheatsheet]]s see follow the link.
[Powerview](https://github.com/PowerShellMafia/PowerSploit/blob/dev/Recon/PowerView.ps1)

Due to AD commands are a restricted to DCs and some(times) Adminstrators. Get PowerView on the box, you need some help.
```powershell
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

## Bloodhound and Sharphound
Mapping out the Domain and its properties is key to mental digesting the interconnected system of systems, abstrat and physical see: [[Neo4j-And-Bloodhound-Guide]]


## Users and Groups
[[Active-Directory-Default-Security-Groups-Table]] also contains addition pwnables possiblities.
```powershell
net user $user $password /add /domain
net group "$groupname" /add $user

# LAPs group can read passwords
Get-ADComputer -Filter 'ObjectClass -eq "computer"' -Property *
# Password is in output or Kali lapsdumper
```

## Exploitation Tool
[[Impacket-Cheatsheet]]
[[Kerbrute-Cheatsheet]]
[[Crackmapexec-Cheatsheet]]

You want to target the subnet and then as you laterally move through the network the Adminstrators and DCs.
`crackmapexec smb $IP -u users.txt -p passes.txt`

## Recon Tools

- **DNS**
For more about [[DNS-Defined]], for enumeration for DNS see both 
[[DNS-Recon-Active]] and [[DNS-Recon-Passive]].
- **SMB**
See [SMB tool](SMB-Recon-Cheatsheet.md) and [[RPCClient-Cheatsheet]]
- **LDAP**
[[LDAP-Recon]]

#### Empire and Starkiller
[[Empire]]

Rubeus, [[Seatbelt-Helpsheet]], [[Mimikatz-Cheatsheet]]


#### Metasploit and Proxychains

Metasploit combined with proxychains can used to pivot and access segmented sections of network.
The shells create route through then inaccessable parts of the network can be mapped beyond the shell's address.
To proxy through the network see sections on [[Proxies]] and [[Pivoting-and-Proxying-with-Metasploit]] 

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
impersonate_token $TOKEN
```


## Services

```powershell
setspn -T medin -Q  */*        # extract all accounts in the SPN - service principle name - service and account mapping
```