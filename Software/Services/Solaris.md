
#### Solaris vulnerabilities

[ypupdated_exec](https://www.rapid7.com/db/modules/exploit/solaris/sunrpc/ypupdated_exec/) has [[Metasploit]] exploits against Solaris 2.7, 8, 9, and 10


From updated Markdown Mirror: [GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_Solaris.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Solaris.txt):

Solaris 7:
```bash
sadmind_exec # SADMIND -   weakness in default security settings  - allows root - rootdown.pl
**ttyprompt # TELNET -    buffer overflow in solaris login - manual through telnet client
sendmail_exec # LPD -       line printer daemon buffer overflow  - allows root
heap_noir # DTSPCD -    CDE common desktop environment heap overflow  TCP port 6112, runs with root
ypupdated_exec # YPUPDATED - weakness in handling of the command shell - allows root
kcms_readfile # kcms / ttdbserverd remote file read (only in msf2)
```

Solaris 8:       
```bash
sadmind_exec # SADMIND -   weakness in default security settings  - allows root - rootdown.pl
**ttyprompt # TELNET -    buffer overflow in solaris login - manual through telnet client
sendmail_exec # LPD -       line printer daemon buffer overflow  - allows root
heap_noir # DTSPCD -    CDE common desktop environment heap overflow  TCP port 6112, runs with root
ypupdated_exec # YPUPDATED - weakness in handling of the command shell - allows root.
#  no exploit - sadmind_adm_build_path  SADMIND  -  stack buffer overflow in adm_build_path() function.
kcms_readfile # kcms / ttdbserverd remote file read (only in msf2)
```

Solaris 9:
```bash
sadmind_exec # SADMIND -   weakness in default security settings  - allows root - rootdown.pl
ypupdated_exec # YPUPDATED - weakness in handling of the command shell - allows root.
sadmind_adm_build_path # SADMIND  -  stack buffer overflow in adm_build_path() function.
kcms_readfile         kcms / ttdbserverd remote file read (only in msf2)
```
Solaris 10:
```bash
fuser # TELNET - authentication bypass through -f command - can be manually exploited
ypupdated_exec  # YPUPDATED - weakness in handling of the command shell - allows root.
```


Solaris 11:
```bash
fuser # TELNET - authentication bypass through -f command - can be manually exploited 
```

Adding a solaris user:
```bash
useradd -u 0 -o pentestuser 
passwd -d pentestuser
```
Familiarise yourself with `rpcinfo`, `nfsshell`, `showmount`, `mount -t nfs'


## References

[GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_Solaris.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_Solaris.txt)
[rapid7 - ypupdated_exec](https://www.rapid7.com/db/modules/exploit/solaris/sunrpc/ypupdated_exec/)
