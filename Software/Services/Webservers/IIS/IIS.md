# IIS 

`HTTPAPI httpd 2.0 (SSDP/UPnP)` is from SYS not IIS

#### Excutable extensions
- php
- asp
- aspx
- config - [PayloadsAllTheThings Example config code execution](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Upload%20Insecure%20Files/Configuration%20IIS%20web.config/web.config)

## Build an IIS website

[Build a Static Website on IIS](https://learn.microsoft.com/en-us/iis/manage/creating-websites/scenario-build-a-static-website-on-iis)


## Vulnerabilities and Enumaration

[HackTricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-web/iis-internet-information-services) : *"As any .Net application, MVC applications have a **web.config** file, where "**assemblyIdentity**" XML tags identifies every binary file the application uses... In addition, .Net MVC applications are structured to define **other web.config files**, having the aim to include any declaration for specific namespaces for each set of viewpages, relieving developers to declare “@using” namespaces in every file.*"
- https://github.com/wireghoul/htshells
- https://github.com/irsdl/IIS-ShortName-Scanner 
- [ivoidwarranties](https://www.ivoidwarranties.tech/posts/pentesting-tuts/iis/web-config/) explaination for - https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Upload%20Insecure%20Files/Configuration%20IIS%20web.config/web.config

The SSL certificates are not valid for cloudflare on the links to some HackTricks Article references

## References

[Build a Static Website on IIS](https://learn.microsoft.com/en-us/iis/manage/creating-websites/scenario-build-a-static-website-on-iis)
[Hacktricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-web/iis-internet-information-services)
https://github.com/wireghoul/htshells
https://github.com/irsdl/IIS-ShortName-Scanner 
[ivoidwarranties](https://www.ivoidwarranties.tech/posts/pentesting-tuts/iis/web-config/) 
https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Upload%20Insecure%20Files/Configuration%20IIS%20web.config/web.config