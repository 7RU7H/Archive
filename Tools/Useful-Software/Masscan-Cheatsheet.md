# Masscan Cheatsheet

Beware you cannot use [[Proxies]] with masscan as it has its own TCP Stack.

```bash
sudo masscan -p0-65535 -oG masscan.log --rate=$beware -e $interface $ip/cidr
sudo masscan --top-ports 100 $ip # nmap like top ports
-oX filename: Output to filename in XML.
-oG filename: Output to filename in Grepable** format.
-oJ filename: Output to filename in JSON format.

```


## References

[Daniel Miessler](https://danielmiessler.com/study/masscan/)