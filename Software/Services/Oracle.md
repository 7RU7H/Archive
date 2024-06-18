# Oracle

All tools used below are supported by  [[Kali]], `nmap` has default scripts for Oracle Services  [[Nmap-Cheatsheet]] and [[Nmap-AllTheScripts]]; 
```bash
# oscanner
oscanner -s $ip -P 1040

# sidguess
sidguess -i $ip -d /usr/share/wordlists/metasploit/unix_users.txt

# tnscmd10g
tnscmd10g version -h $ip
```

[[Metasploit]] has Auxiliary Modules:
- https://github.com/rapid7/metasploit-framework/tree/master/modules/auxiliary/admin/oracle
## References

[OlivierLaflamme/Cheatsheet-God - Cheatsheet_Oracle.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Oracle.txt)
[rapid7 GitHub - Oracle Auxiliary Modules](https://github.com/rapid7/metasploit-framework/tree/master/modules/auxiliary/admin/oracle)