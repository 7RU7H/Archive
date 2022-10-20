
## Scanning and Enumeration

```bash
# Get components running on the website
joomscan --url http://10.10.10.150/ --random-agent --enumerate-components

# You can also check
/administrator/manifests/files/joomla.xml

# If you find components, you can often access the configuration file
# JCE component → /components/com_jce/jce.xml

# Check for vulnerabilities affecting components

# Joomlavs is also a good scanning tool
https://github.com/rastating/joomlav
```


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