
## Vulnerable Defaults

[This seems insane](https://www.drupal.org/docs/7/core/modules/php), but for the entire version 7 of Drupal you can just press the RCE me button with Authenticated Access Module is drupal core module *or* if it is enabled - was removed in [Drupal 8](https://www.drupal.org/docs/core-modules-and-themes).  The [Drupal 7 core PHP filter module adds the ability to include PHP code in posts so even in configuration  one misconfiguration or failure to properly check the php being executed is a security risk.](https://www.drupal.org/docs/8/modules/php/overview). follow the link: [[Useful_PHP]] for aid in footholding a Drupal 7 box near you.

`/var/www/html/sites/default/settings.php` important configration file containing drupal user and password.

## Tricks


```bash
# Manual user enumeration
# Step 1 : check for existing user
# 403 --> User exist
# 404 --> User doesn't exist
https://www.site.com/user/x

# Then you can get username
https://www.site.com/reset/user/x/1/1
```


```bash
# Not Drupal specific but can work too (Wordpress, SilverStripe, Joomla, Moodle, Drupal)
droopescan --help
droopescan scan --help
# Target Identification droopescan scan 
drupal -u example.org droopescan scan drupal -U list_of_urls.txt  
# You can also ommit the drupal argument, so it will trigger the cms identification 
droopescan scan -u example.org droopescan scan -U list_of_urls.txt
# Scan types 
# By default, most of the time, 4 threads droopescan scan 
drupal -u example.org --number xxx --threads xxx

# By default, all tests are done, but you can specify some manually 
# - p : plugin checks # - t : theme checks 
# - v : version checks (files checksums) 
# - i : interesting urls checks droopescan scan 
drupal -u example.org --enumerate <type>
# Getting stats and capabilities for the scanner droopescan stats`
```

## Drupwn


```bash
drupwn

positional arguments:
  mode               enum|exploit
  target             hostname to scan

optional arguments:
  -h, --help         show this help message and exit
  --users            user enumaration
  --nodes            node enumeration
  --modules          module enumeration
  --dfiles           default files enumeration
  --themes           theme enumeration
  --version VERSION  Drupal version
  --cookies COOKIES  cookies
  --thread THREAD    threads number
  --range RANGE      enumeration range
  --ua UA            User Agent
  --bauth BAUTH      Basic authentication
  --delay DELAY      request delay
  --log              file logging
  --proxy PROXY      [http|https|socks]://host:port
  --proxies PROXIES  Proxies file

```

## Online Tools
```bash
#  Attempt to detect version of Drupal Core
# Find Plugins in HTML response
# Identify theme in use
# List client side JS in page
# List iframes in page
# Test for directory indexing enabled on key locations
# Check Google Safe Browse for reputation
# Get IP information and Geolocation
https://hackertarget.com/drupal-security-scan/
```

## References

[Haax.fr](https://cheatsheet.haax.fr/web-pentest/content-management-system-cms/drupal/)