# Wordpress 

## Introduction

## What to look for
/var/www/html/wp-config.php contain credentials

## Directory  Busting 
Seclist wordlists
```
Discovery/Web-Content/URLs/urls-wordpress-3.3.1.txt/
Discovery/Web-Content/CMS/wordpress.fuzz.txt/
Passwords/Honeypot-Captures/wordpress-attacks-july2014.txt
```

## Shells
Seclists
```
/usr/share/seclists/Web-Shells/WordPress
```

## WPscan

[Free 25 API requests per day](https://wpscan.com/pricing)

```bash
wpscan --url  -e --api-token $APIKEY # -o filename
```

```bash
# optional - all plugins, themes, plus timthumbs
# vp,vt,tt,cb,dbe,u,m
ap at t tt dbe u m cb
```

## Hashes
Hashcat Hashmode = 400


## Reverse Shells
Use php reverse shells. Places to put them:

Theme Editor use a 404 template as it won't break the site.
Plugin Editor  then go to /wp-content/plugins/<pluginname.php>