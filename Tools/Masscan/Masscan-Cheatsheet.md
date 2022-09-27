# Masscan 
Firstly you need to use some output format to a log file `-o* .log` as stdout does not have a nice display like [[Nmap-Cheatsheet]] 


Scan entire port range through a vpn tunnel for your CTFs at rate that upper end of potato computers can handle and save the output to `.log` file.
```bash
sudo masscan -p0-65535 -oG masscan/masscan.log --rate 500 -e tun0 $ip
```

## References
[Daniel Miessler Article](https://danielmiessler.com/study/masscan/)
