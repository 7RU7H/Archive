# Windows Network Forensics


#### Named Pipes

Named-Pipes: Local or Network-based inter-process communication

System Resource Usage Monitor - 30-60 day log retention lifespan
- Application, Service, Network and User activity
- `C:\Windows\System32\sru\SRUDB.dat` - SRUM Database

Use [[KAPE]] to export SRUM data - this file is locked with running
```powershell
.\kape.exe --tsource C:\Windows\System32\sru --tdest %SRUMPATH%\SRUM --tflush --mdest %SRUMPATH%\MODULE --mflush --module SRUMDump --target SRUM
```
With the `SRUDB.dat` file, we can use the [srum-dump](https://github.com/MarkBaggett/srum-dump) utility: provide path to database, output, path to SRUM template, path to SOFTWARE hive of the [[Windows-Registry]] 

#### Windows Firewall Logs

 Logs found: `C:\Windows\System32\LogFiles\Firewall`

##### Network Analysis

[[PowerShell]]  
```powershell
netstat -ano # All TCP and process IDs, numeric (do not resolve names)
netstat -b # executables handles per connection
netstat -p # protocol


# Unique IPs
(Get-NetTCPConnection).remoteaddress | Sort-Object -Unique
# Information on a specific IP
Get-NetTCPConnection -remoteaddress 10.10.10.10 | select state, creationtime, localport,remoteport | ft -autosize

# TCP connections and assoicated processes
Get-NetTCPConnection | select LocalAddress,localport,remoteaddress,remoteport,state,@{name="process";Expression={(get-process -id $_.OwningProcess).ProcessName}}, @{Name="cmdline";Expression={(Get-WmiObject Win32_Process -filter "ProcessId = $($_.OwningProcess)").commandline}} | sort Remoteaddress -Descending | ft -wrap -autosize
# UDP connections
Get-NetUDPEndpoint | select local*,creationtime,remote* | ft -autosize

# DNS Cache: On Windows is a local database
Get-DnsClientCache | ? Entry -NotMatch "workst|servst|memes|kerb|ws|ocsp" | out-string -width 1000
#  Read entries from the \etc\hosts
gc -tail 4 "C:\Windows\System32\Drivers\etc\hosts"

# RDP sessions
qwinsta
# SMB Shares
Get-SmbConnection
Get-SmbShare
```

Packet Monitoring - beware normal authentication occurs if you have keys to decrypt traffic so does anyone that finds an packet captures
```powershell
pktmon # start stop reset 
pktmon counters # view amount of packets captured
pktmon etl2txt # convert to text file
pktmon etl2pcap # convet to pcap
```

## References

[THM Room Windows Network Analysis](https://tryhackme.com/r/room/windowsnetworkanalysis)
[srum-dump](https://github.com/MarkBaggett/srum-dump) 