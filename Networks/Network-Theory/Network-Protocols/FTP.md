# FTP

- Control Connection - connection request - Port 21 for commands 
- Data Connection - post authenication, used for transferring data -  Port 20 for data
- Varienty of  clients: Telnet, Filezilla (Common IoC),  CuteFTP
```bash
wget -r ftp://[username]:[password]@[ip]/
ftp ip
# Active mode is used by client and server to negoiate authenication
-n 	prevent autologon
-v 	verbose server output

USER username
PASS password
SYST	# system		system info
PASV	# passive		enter passive mode - this is first command that is sent after auth
TYPE A	# type ascii	enter ASCII mode
ASCII   # Will perform the same as the above 
IMAGE   # Binary mode 
EBCDIC  # for EBCDIC character set
STAT	# status		give server status
LOCAL   # "Type L n" for machines that do not support 8-bit bytes transfer - n is byte size

# If (up/down)loading files that are binaries!
binary # prepare server for binary mode transfer
get x.exe

ls -la		list directory, sometimes ls DOES NOT WORK
get file
put file	upload files!
```


## Hardening

[Secure vsftpd](https://www.xmodulo.com/secure-ftp-service-vsftpd-linux.html)
```bash
# Edit
/etc/vsftpd.conf # Ubuntu, Debian or Linux Mint 
/etc/vsftpd/vsftpd.conf # CentOS, Fedora or RHEL
# Disable Anonymous Login
anonymous_enable=NO
# Restart
service vsfptd restart
systemctl restart vsfptd
```

## References


[Secure vsftpd](https://www.xmodulo.com/secure-ftp-service-vsftpd-linux.html)
