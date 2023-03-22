# SMTP Cheatsheet
Simple Mail Transport Protocol (SMTP)
Vulnerable Email Servers can contain valuable information. 
See [[Network-Protocols-Cheatsheet]] for port information.

See [Debug STMP connection for great description of SMTP commands that occuring exploitation of MAil servers](https://www.sparkpost.com/blog/how-to-check-an-smtp-connection-with-a-manual-telnet-session/)

## Telnet
```bash
telnet $IP 25
nc -nv $IP 25
EHLO # client server identification Hello
VRFY $useremail # verify email address
EXPN # Ask server for membership
# To quit telnet is worse than vim
[CTRL] + $escapekey_show_on_initial_connection 
telnet> help # Display commands 
telnet> close


```
Code 250,251,252 means accepted and user account is valid; code 550 means invalid user.


## Metasploit
```bash
use auxiliary/scanner/smtp/smtp_enum
msf auxiliary(smtp_enum) > set rhosts $IP
msf auxiliary(smtp_enum) > set rport 25
msf auxiliary(smtp_enum) > set USER_FILE /usr/
msf auxiliary(smtp_enum) > exploitv
```

## References

[HackingArticles](https://www.hackingarticles.in/4-ways-smtp-enumeration/)
[Debug STMP connection for great description of SMTP commands that occuring exploitation of MAil servers](https://www.sparkpost.com/blog/how-to-check-an-smtp-connection-with-a-manual-telnet-session/)
[Microsoft Use Telnet to test SMTP communication on Exchange servers](https://learn.microsoft.com/en-us/exchange/mail-flow/test-smtp-telnet?view=exchserver-2019)