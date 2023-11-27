# IMAP Recon Cheatsheet

```bash
nc -nv $ip 143
openssl s_client -connect $ip:993 -quiet
```

[HackTricks - port 143, 993 Pentesting](https://book.hacktricks.xyz/network-services-pentesting/pentesting-imap) - IMAP Bruteforce - to get email to read
```bash
Login
    A1 LOGIN username password
Values can be quoted to enclose spaces and special characters. A " must then be escape with a \
    A1 LOGIN "username" "password"

List Folders/Mailboxes
    A1 LIST "" *
    A1 LIST INBOX *
    A1 LIST "Archive" *

Create new Folder/Mailbox
    A1 CREATE INBOX.Archive.2012
    A1 CREATE "To Read"

Delete Folder/Mailbox
    A1 DELETE INBOX.Archive.2012
    A1 DELETE "To Read"

Rename Folder/Mailbox
    A1 RENAME "INBOX.One" "INBOX.Two"

List Subscribed Mailboxes
    A1 LSUB "" *

Status of Mailbox (There are more flags than the ones listed)
    A1 STATUS INBOX (MESSAGES UNSEEN RECENT)

Select a mailbox
    A1 SELECT INBOX

List messages
    A1 FETCH 1:* (FLAGS)
    A1 UID FETCH 1:* (FLAGS)

Retrieve Message Content
    A1 FETCH 2 body[text]
    A1 FETCH 2 all
    A1 UID FETCH 102 (UID RFC822.SIZE BODY.PEEK[])

Close Mailbox
    A1 CLOSE

Logout
    A1 LOGOUT
```

[For the usage of `curl` for Interacting with IMAP - From HackTricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-imap#curl), I personally want to know what I have and have not read, but it you want to automate dumping email HackTricks has you covered.
## References

[HackTricks - port 143, 993 Pentesting](https://book.hacktricks.xyz/network-services-pentesting/pentesting-imap)