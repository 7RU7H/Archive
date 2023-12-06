# Gaining a Foothold on Active Directory

For enumeration see [[Active-Directory-Enumeration-Defined]] or general theory and definitions [[Active-Directory-Defined]]. For commands cheatsheet [[Active-Directory-Commands]] or for Privilege Escalation see [[Active-Directory-Privilege-Escalation]]. See [[Attacking-Kerberos]] for exclusively Kerberos related and information on the mechanics of Kerberos  [[Active-Directory-Kerberos-Authentication-Defined]].

## OSINT Users and Formatting

[[OSINT-People]] with some form of [[OSINT]] get names to then generated:
- [[Valid-Usernames]]
- [[Email-Harvesting]]
- [[Generating-Usernames-And-Emails]]


This half information gathering process before password spraying, no password Kerberos and domain user  

[[Generating-Likely-Passwords]]

## NTLM & NetNTLM Authenticated Services

New Technology LAN Manager(NTLM) is a family of authentication protocols used to authenticate identities of users in the context of Active Directory network. Services use Windows' challenge-response protocol  called NetNTLM. Allowing services exposed to the internet authenticating on behalf of a client not client directly authenticating to Domain Controller. 
- [[RDP]]
- Internal-Hosted Email 
- Exposed VPN endpoints integrated into AD
- Internet expose Web applications that use NetNTLM 


- **Bruteforce**
[[Hydra-Cheatsheet]], [[Medusa-Cheatsheet]], [[Brutespray-Cheatsheet]], [[Crowbar-CheatSheat]]

## LDAP Bind Credentials
Lightweight Directory Access Protocol (LDAP) is a vendor-neutral application protocol for accessing and maintaining distributed directory information services over IP.  In the context of Active Directory it is used as an authentication mechanism where an application directly verifies the user's credentials. LDAP authentication is used in AD contexts to integrate third-party applications with AD. For more see [[LDAP-Recon]].

#### LDAP Authentication

1. User requests `Service Use` with AD credentials
1. Service performs `LDAP Bind Request` to DC with AD credentials of user 
1. DC provide `Bind Response`
1. Service requests `User Search`
1. DC  responds with `User search` result
1. `LDAP Bind` request with user request with AD credentials of user 
1. DC sends `Bind Response`

- **Internet Exposed LDAP = Same attacks as NTML**

- **LDAP Pass-Back**

Requires access to device configuration.
Alter LDAP configuration IP or hostname of LDAP server to a rogue server, forcing device to attempt LDAP authentication to our rogue device, which can be then intercepted.

```bash
nc -lvp 389
```
If response contains `supportedCapabilities` then the service is trying negotiate the LDAP authenication method details.

- **LDAP server setup**
[Debian based](https://wiki.debian.org/LDAP/OpenLDAPSetup)
[Arch based](https://wiki.archlinux.org/title/OpenLDAP)
[[Kali-Setup-Rogue-LDAP-Server]]
Remember to patch rogue LDAP server with `olcSaslSecProps.ldif` 

```
#olcSaslSecProps.ldif 
dn: cn=config 
replace: olcSaslSecProps 
olcSaslSecProps: noanonymous,minssf=0,passcred
```

Then execute LDAP authentication passing the rogue server as arguments to which the service will attempt to communicate, capture with `tcpdump`.

```bash
sudo tcpdump -SX -i $interface tcp port 389
```

[Medium: Pwning Printers with LDAP Pass-Back Attack](https://medium.com/r3d-buck3t/pwning-printers-with-ldap-pass-back-attack-a0d8fa495210)

## Authentication Relays
Server Message Block(SMB) protocol allows client-server communication and is used in AD networks various utilities and administration. Previous versions have numerous vulnerabilities and exploits, some setting run legacy systems that do not support newer versions of SMB. For more SMB related recon see [[SMB-Recon-Cheatsheet]].

- **Intercepting NetNTLM Challenge**

Use [[Responder-Cheatsheet]] to poison the responses during NetNTLM authentication tricking the client to communicate with `responder` not the server. On a real LAN, Responder will attempt to poison any  Link-Local Multicast Name Resolution (LLMNR),  NetBIOS Name Server (NBT-NS), and Web Proxy Auto-Discovery (WPAD) requests that are detected.

Requirements:
1. SMB signing must be either disabled or enable but not enforced
1. Responder need to get a hash of an account with administrative privileges - we may need to figure out whom on the network has these privileges

- **SMB Relay Man in the Middle Attack**

1. Attacker runs responder
```bash
sudo responder -I $interface
```
2. User sends `NTLM Negotiate`
3. Attacker incepts and forwards NTLM Authentication 
4. Server responds with NTLM Challenge encrypted with User's hash
5. Attackers forwards the NTLM challenge to user
6. User send challenge response
7. Attacker forwards challenge response
8. Server grants access
9. Attacker sends Access Denied error to user
10. Attacker accesses server resources


## Microsoft Deployment Toolkit

[Microsoft Deployment Toolkit](https://www.microsoft.com/en-gb/download/details.aspx?id=54259) (MDT) is a Microsoft service that assists with automating the deployment of Microsoft Operating Systems (OS), it was once commonly integrated with Microsoft's System Center Configuration Manager (SCCM) now rebranded, but basically the same as SCCM under [Microsoft Endpoint Manager](https://docs.microsoft.com/en-us/mem/) (MEM). MEM manages all updates for all Microsoft applications, services, and operating systems, whereas the MDT manages preconfiguration that so IT just connects the machine to the AD network and automation of boot image loading, updating and configuration occurs with MEM. 

For Attackers this is a valuable target to control as the scope of the system control is large and would allow for generating persistence after a cleanup or any new machines and lower level attacks against preconfiguring at boot level. 

#### PXE Boot

PXE boot allow new devices that are connected to the netowkr to  load and install the OS directly over network connection. MDT can be used to create, manage, and host PXE boot images.  PXE boot is usually integrated with DHCP, which means that if DHCP assigns an IP lease, the host is allowed to request the PXE boot image and start the network OS installation process.

1. User sends DHCP Discover(requests IP addess and PXE service info)
2. Server sends DHCP Offer(sends open IP and PXE service info)
3. User sends DHCP Request(accept IP address)
4. Server sends DHCP Acknowledge
5. Client performs Boot Service Discover
6. Server Acknowledge(sends PXE bott information)
7. Client requests PXE Boot via TFTP
8. Server delivers PXE Boot via TFTP

Boot image can exploited:
1. Inject a privilege escalation vector - preload a nefarious Local Administrator 
1. Perform password scraping attacks to recover AD credential during installation 

#### PXE Boot Image Retrieval

1. Firstly attempt to request an IP and the PXE boot preconfigure details via DHCP from the MDT server
2. Secondly use TFTP to request each of the BCD files and enumerate the configurations
- Note these parts are not included included in the [THM Breaching AD Room](https://tryhackme.com/room/breachingad). 

```batch
tftp -i $MDT-SERVER-IP GET "pxee-boot-image-name.bcd" conf.bcd
```

3. Use [Powerpxe-github](https://github.com/wavestone-cdt/powerpxe) to read the \*.bcd file(s)

```powershell
Import-Module .\PowerPXE.ps1
$BCDFile = "conf.bcd"
Get-WimFile -bcdFile $BCDFile
# >>>> Identify wim file : 
# <PXE Boot Image Location will be outputed here
```

Download with tftp 
```powershell 
tftp -i $MDT-SERVER-IP GET "<PXE Boot Image Location>" pxeboot.wim
# Once downloaded use the PowerPXE module to extract credentials
Get-FindCredentials -WimFile pxeboot.wim
```


## Configuration Files

Depending on the host various configuration files contain useful in extracting AD credentials 
-   Web application config files   
-   Service configuration files
-   Registry keys
-   Centrally deployed applications - these usually need to authenticate to the domain during installation and execution 

Can be used to automated this process with scripts like:
[Seatbelt](https://github.com/GhostPack/Seatbelt)



## Mitigation

1. User awareness and training about disclosing sensitive information and not trusting suspicious emails
2. Limit exposure of AD services and application from the Internet
3. Enforce Network Access NAC to prevent rogue devices
4. Enforce SMB signing - prevent relay attacks
5. Principle of least privileges 



## References

[THM AD Basics Room](https://tryhackme.com/room/activedirectorybasics)
[THM Breaching AD Room](https://tryhackme.com/room/breachingad)
[NTML Microsoft Documentation](https://docs.microsoft.com/en-us/windows-server/security/kerberos/ntlm-overview)
[LDAP Wiki](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol)
[WPAD Wiki](https://en.wikipedia.org/wiki/Web_Proxy_Auto-Discovery_Protocol)
[SMB Wiki](https://en.wikipedia.org/wiki/Server_Message_Block)
[network encyclopedia](https://networkencyclopedia.com/netbios-name-server-nbns/)
[hacktricks](https://book.hacktricks.xyz/generic-methodologies-and-resources/pentesting-network/spoofing-llmnr-nbt-ns-mdns-dns-and-wpad-and-relay-attacks)
[mdsec](https://www.mdsec.co.uk/2021/02/farming-for-red-teams-harvesting-netntlm/)
[truesec](https://www.truesec.com/hub/blog/mitigating-ntlm-relay-attacks-on-active-directory-certificate-services-ad-cs-adv210003-kb5005413-petitpotam)
[r3d-buck3t](https://medium.com/r3d-buck3t/pwning-printers-with-ldap-pass-back-attack-a0d8fa495210)
[Microsoft Deployment Toolkit](https://www.microsoft.com/en-gb/download/details.aspx?id=54259)
[Medium: Pwning Printers with LDAP Pass-Back Attack](https://medium.com/r3d-buck3t/pwning-printers-with-ldap-pass-back-attack-a0d8fa495210)
[Powerpxe-github](https://github.com/wavestone-cdt/powerpxe)