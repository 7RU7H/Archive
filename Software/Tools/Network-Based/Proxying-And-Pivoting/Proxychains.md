# Proxychains

[Proxychains](https://github.com/haad/proxychains) *" - a tool that forces any TCP connection made by any given application to follow through proxy like TOR or any other SOCKS4, SOCKS5 or HTTP(S) proxy. Supported auth-types: "user/pass" for SOCKS4/5, "basic" for HTTP. ProxyChains is a UNIX program, that hooks network-related libc functions in dynamically linked programs via a preloaded DLL and redirects the connections through SOCKS4a/5 or HTTP proxies."*

Proxychains is a proxifier tool that is pre-installed on [[Kali]] Linux, configured to tunnel traffic over one or more proxies, Proxychains support SOCKS4, SOCKS5, and HTTP(S) proxies. [http://proxychains.sourceforge.net/](http://proxychains.sourceforge.net/) it explicitly states it supports TCP and DNS (which actually can be UDP or TCP) from [superuser](https://superuser.com/questions/442995/is-ping-not-supposed-to-work-via-proxychains).

The usage of `proxychains` is primarily determined by the `proxychains` configuration file, which is modifiable for a user to define how network connects are routed  `proxychains`  

`proxychains` looks for configuration in the following order:
- SOCKS5 proxy port in environment variable `${PROXYCHAINS_SOCKS5}` (if set, no further configuration will be searched)
- file listed in environment variable `${PROXYCHAINS_CONF_FILE}` or provided as a -f argument to `proxychains` script or binary.    
- `./proxychains.conf`
- `$(HOME)/.proxychains/proxychains.conf`
- `/etc/proxychains.conf`

Example workflow and usage
```bash
vim /etc/proxychains4.conf
# Append the line below, removing or added `#` to include or exclude lines 
socks5 127.0.0.1 1337
# Run a cli tool through proxychains
# Example assumes that we are reverse port forwarding from a remote machine (forwarding a http port 80 on internal machine to the remote  machine) to our local machine to port 1337 on the loopback address 
# KALI <- $RemoteMachine <- $InteralWebApp
proxychains nikto -h http://127.0.0.1:1337
proxychains -q nikto -h http://127.0.0.1:1337 # quite proxychains output 
```

Adjust to Network interface and CPU! - [From hackwhackandsmack](https://www.hackwhackandsmack.com/?p=1021)
```bash
seq 1 1000 | xargs -P 50 -I{} proxychains nmap -p {} -sT -Pn --open -n -T4 --min-parallelism 100 --min-rate 1 --oG proxychains_nmap --append-output <IP Address>
```


There are multiple types of `proxychains` options: 
- `chain_len`, option to specify the number of proxies to be used.	
- `dynamic_chain`
	- Dynamic:
		- Each connection will be done via chained proxies all proxies chained in the order as they appear in the list.
		- At least one proxy must be online to play in chain (dead proxies are skipped) otherwise `EINTR` is returned to the application

- `strict_chain`
	- Strict:
		- Each connection will be done via chained proxies all proxies chained in the order as they appear in the list. 
		- all proxies must be online to play in chain otherwise `EINTR` is returned to the app
- `round_robin_chain`
	- Round Robin:
		- Each connection will be done via chained proxies of `chain_len` length all proxies chained in the order as they appear in the list at least one proxy must be online to play in chain (dead proxies are skipped).
		- The start of the current proxy chain is the proxy after the last proxy in the previously invoked proxy chain.
		- If the end of the proxy chain is reached while looking for proxies start at the beginning again otherwise `EINTR` is returned to the app
		- These semantics are not guaranteed in a multi-threaded environment.
- `random_chain` 
	- Random: 
		- Each connection will be done via random proxy (or proxy chain, see  `chain_len`) from the list.
		- This option is good to test your IDS :)
- `proxy_dns` 
	- If running [[Nmap-Cheatsheet]] through `proxychains` comment out `proxy_dns` as `sudo nmap` will attempt to resolve DNS or use `nmap -n` for no DNS resolution. 




## References

[Github Proxychains](https://github.com/haad/proxychains) 
[Script hackwhackandsmack](https://www.hackwhackandsmack.com/?p=1021)
[http://proxychains.sourceforge.net/](http://proxychains.sourceforge.net/) 
[superuser](https://superuser.com/questions/442995/is-ping-not-supposed-to-work-via-proxychains)
[THM Wreath Room](https://tryhackme.com/room/wreath)