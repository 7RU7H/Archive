
## Scanning and Enumeration

```bash
# Kali-Rolling
sudo apt install joomscan
# Get components running on the website
joomscan --url http://10.10.10.150/ --random-agent --enumerate-components

# You can also check
/administrator/manifests/files/joomla.xml

# If you find components, you can often access the configuration file
# JCE component → /components/com_jce/jce.xml

# Check for vulnerabilities affecting components

# Joomlavs is also a good scanning tool
https://github.com/rastating/joomlav

# Scan using random agent through burpsuite proxy while trying to enumerate components
joomscan -u http://target.com -ec -r- --proxy 127.0.0.1:8080 # | tee -a joomscan-report 
```


## Common Files

```bash
README.txt
htaccess.txt
web.config.txt
configuration.php
LICENSE.txt
administrator
administrator/index.php # Default admin login
index.php?option=<nameofplugin>
administrator/manifests/files/joomla.xml
plugins/system/cache/cache.xml
```
[Joomla.xml is for pre version 4.0 and will contain the version](https://docs.joomla.org/Manifest_files)

## Reverse Shell

```bash
# You must first log as admin
# Then you must activate the PHP extension in settings
System → Component → Media → “php” in legal extensions and nothing in ignored extension

# If it's not enough and the manager is detecting malicious PHP upload, you can still edit templates
# For example, the /index.php on the “protostar" template
→ Use reverse shell from pentestmonkey
→ http://pentestmonkey.net/tools/web-shells/php-reverse-shell

# On old versions, the control panel and features are different, but you can use templates
# First go into templates parameters and activate preview
# Then, on one template it is possible to edit code
# Then it is possible to add shell (weevely for example)
```


## References

[Haax.fr](https://cheatsheet.haax.fr/web-pentest/content-management-system-cms/joomla/)
[six2dez](https://github.com/six2dez/pentest-book/blob/master/enumeration/webservices/joomla.md)
[Joomla Documentation Manifest files](https://docs.joomla.org/Manifest_files)