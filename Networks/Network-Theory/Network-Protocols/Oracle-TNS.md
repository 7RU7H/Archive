# Oracle-TNS

[[Metasploit]]
```ruby 
# Some old version of MSF can just ask for SID
#msf1
msf> use auxiliary/scanner/oracle/sid_enum
msf> set rhost <IP>
msf> run
#msf2
msf> use auxiliary/admin/oracle/tnscmd
msf> set CMD (CONNECT_DATA=(COMMAND=STATUS))
msf> set rhost <IP>
msf> run #The SID are inside: SERVICE=(SERVICE_NAME=<SID_NAME>)

#msf6 
# Brute force the SID
msf>use auxiliary/admin/oracle/sid_brute
# Brute force user accounts
msf>scanner/oracle/oracle_login

```