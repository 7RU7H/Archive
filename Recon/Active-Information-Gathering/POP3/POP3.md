This is not [[SMTP-Recon-Cheatsheet]], this is port 110... I made that mistake atleast once.

```bash
# Retrieve POP3 server capabilities (CAPA, TOP, USER, SASL, RESP-CODES, LOGIN-DELAY, PIPELINING, EXPIRE, UIDL, IMPLEMENTATION)  
nmap -v -sV --version-intensity=5 --script pop3-capabilities -p T:110 IP

# Try to bruteforce POP3 accounts
nmap --script pop3-brute --script-args pop3loginmethod=SASL-LOGIN -p T:110 IP
nmap --script pop3-brute --script-args pop3loginmethod=SASL-CRAM-MD5 -p T:110 IP
nmap --script pop3-brute --script-args pop3loginmethod=APOP -p T:110 IP
```


Connecting
```bash
telnet $ip 110
nc -nv $ip 110
```

POP commands:
```bash
USER uid # Log in as "uid"
PASS $password
STAT # Statics
LIST # List mail
RETR n # Read email  number n
DELE n # Delete email number n
RSET # undo changes
QUIT 
TOP # Show fist n lines of message number msg
CAPA # Get capabilities

# Default credentials to try 

USER admin
PASS admin

USER root
PASS root

USER root
PASS toor

# Once logged
list
```


## References

[haax.fr](https://cheatsheet.haax.fr/network/services-enumeration/110_pop3/)
[HackTricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-pop)