# SMTP Cheatsheet

Simple Mail Transport Protocol (SMTP) - Vulnerable Email Servers can contain valuable information. 
See [[Network-Protocols]] for port information.

See [Debug STMP connection for great description of SMTP commands that occuring exploitation of MAIL servers](https://www.sparkpost.com/blog/how-to-check-an-smtp-connection-with-a-manual-telnet-session/)

## SMTP with Telnet 
```bash
telnet $IP 25
nc -nv $IP 25
EHLO all # client server identification Hello
VRFY $useremail # verify email address
EXPN # Ask server for membership
# To quit telnet is worse than vim
[CTRL] + $escapekey_show_on_initial_connection 
telnet> help # Display commands 
telnet> quit
```
Code 250,251,252 means accepted and user account is valid; code 550 means invalid user.

## Pop3

```c
POP commands:
  USER uid           Log in as "uid"
  PASS password      Substitue "password" for your actual password
  STAT               List number of messages, total mailbox size
  LIST               List messages and sizes
  RETR n             Show message n
  DELE n             Mark message n for deletion
  RSET               Undo any changes
  QUIT               Logout (expunges messages if no RSET)
  TOP msg n          Show first n lines of message number msg
  CAPA               Get capabilities
```
## Metasploit

[[Metasploit]] has an auxiliary scan.
```bash
use auxiliary/scanner/smtp/smtp_enum
msf auxiliary(smtp_enum) > set rhosts $IP
msf auxiliary(smtp_enum) > set rport 25
msf auxiliary(smtp_enum) > set USER_FILE /usr/
msf auxiliary(smtp_enum) > exploit
```

## References

[HackingArticles](https://www.hackingarticles.in/4-ways-smtp-enumeration/)
[Debug STMP connection for great description of SMTP commands that occuring exploitation of MAil servers](https://www.sparkpost.com/blog/how-to-check-an-smtp-connection-with-a-manual-telnet-session/)
[Microsoft Use Telnet to test SMTP communication on Exchange servers](https://learn.microsoft.com/en-us/exchange/mail-flow/test-smtp-telnet?view=exchserver-2019)
[gabb4r OSCP gitbook](https://gabb4r.gitbook.io/oscp-notes/service-enumeration/pop3-port-110-25)