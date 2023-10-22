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

## POP3

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

[[Metasploit]] has an auxiliary scan. Worried about OSCP `metasploit` usage see the FOSS Tools section
```bash
use auxiliary/scanner/smtp/smtp_enum
msf auxiliary(smtp_enum) > set rhosts $IP
msf auxiliary(smtp_enum) > set rport 25
msf auxiliary(smtp_enum) > set USER_FILE /usr/
msf auxiliary(smtp_enum) > exploit
```

#### FOSS Tools

[pentestmonkey's smtp user enum](http://pentestmonkey.net/tools/smtp-user-enum) - usage:
```bash
smtp-user-enum v$versionNum ( http://pentestmonkey.net/tools/smtp-user-enum )

Usage: smtp-user-enum [options] ( -u username | -U file-of-usernames ) ( -t host | -T file-of-targets )

options are:
        -m n     Maximum number of processes (default: 5)
        -M mode  Method to use for username guessing EXPN, VRFY or RCPT (default: VRFY)
        -u user  Check if user exists on remote system
        -f addr  MAIL FROM email address.  Used only in "RCPT TO" mode (default: user@example.com)
        -D dom   Domain to append to supplied user list to make email addresses (Default: none)
                 Use this option when you want to guess valid email addresses instead of just usernames
                 e.g. "-D example.com" would guess foo@example.com, bar@example.com, etc.  Instead of
                      simply the usernames foo and bar.
        -U file  File of usernames to check via smtp service
        -t host  Server host running smtp service
        -T file  File of hostnames running the smtp service
        -p port  TCP port on which smtp service runs (default: 25)
        -d       Debugging output
        -w n     Wait a maximum of n seconds for reply (default: 5)
        -v       Verbose
        -h       This help message

Also see smtp-user-enum-user-docs.pdf from the smtp-user-enum tar ball.

Examples:

$ smtp-user-enum -M VRFY -U users.txt -t 10.0.0.1
$ smtp-user-enum -M EXPN -u admin1 -t 10.0.0.1
$ smtp-user-enum -M RCPT -U users.txt -T mail-server-ips.txt
$ smtp-user-enum -M EXPN -D example.com -U users.txt -t 10.0.0.1
```

Better examples and clarity:
```bash
# Enumerate potiental email addresses for valid ones
smtp-user-enum -M VRFY -U potential-email-addresses.txt -t $TargetIP -p $PORT | tee -a  smtp-user-enum-$PORT.out 
# Then make a file of valid emails
cat smtp-user-enum-25.out | grep exists | awk -F: '{print $2}' | sed 's/ exists//g'| tr -d ' ' > valid-emails.txt
```

Alternatives:
- [Python3 smtp-user-enum](https://github.com/cytopia/smtp-user-enum)
## References

[HackingArticles](https://www.hackingarticles.in/4-ways-smtp-enumeration/)
[Debug STMP connection for great description of SMTP commands that occuring exploitation of Mail servers](https://www.sparkpost.com/blog/how-to-check-an-smtp-connection-with-a-manual-telnet-session/)
[Microsoft Use Telnet to test SMTP communication on Exchange servers](https://learn.microsoft.com/en-us/exchange/mail-flow/test-smtp-telnet?view=exchserver-2019)
[gabb4r OSCP gitbook](https://gabb4r.gitbook.io/oscp-notes/service-enumeration/pop3-port-110-25)
[Pentesterlab](https://pentestlab.blog/2012/11/20/smtp-user-enumeration/)
[pentestmonkey's smtp user enum](http://pentestmonkey.net/tools/smtp-user-enum)
[Python3 smtp-user-enum](https://github.com/cytopia/smtp-user-enum)