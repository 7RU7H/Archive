# Masscan 

Beware you cannot use [[Proxies]] with masscan as it has its own TCP Stack.

```bash
sudo masscan -p0-65535 -oG masscan.log --rate=$beware -e $interface $ip/cidr
sudo masscan --top-ports 100 $ip # nmap like top ports
-oX filename: Output to filename in XML.
-oG filename: Output to filename in Grepable** format.
-oJ filename: Output to filename in JSON format.

```

Firstly you need to use some output format to a log file `-o* .log` as stdout does not have a nice display like [[Nmap-Cheatsheet]] 

Scan entire port range through a vpn tunnel for your CTFs at rate that upper end of potato computers can handle and save the output to `.log` file.
```bash
sudo masscan --top-ports 100 10.10.10.0/24 
sudo masscan -p0-65535 -oG masscan/masscan.log --rate 500 -e tun0 $ip
```

## References
[Daniel Miessler Article](https://danielmiessler.com/study/masscan/)
