# TryHackMe


THM has a [Glossary](https://tryhackme.com/glossary) of all terms featured on the site 

Fix `openvpn` key error: `OPTIONS ERROR: failed to negotiate cipher with server.  Add the server's cipher ('AES-256-CBC') to --data-ciphers (currently 'AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305') if you want to connect to this server.` 
```bash
sed -i 's/cipher AES-256-CBC/data-ciphers AES-256-CBC/' *.ovpn
```

Use `date` on Linux to figure out how old a box is by year for making better judgement calls on what is actually a rabbithole. 
```bash
date --date="1360 day ago"
```

## References

[THM](https://tryhackme.com/)
[THM Glossary](https://tryhackme.com/glossary)
[redhat - formatting date command ](https://www.redhat.com/sysadmin/formatting-date-command)