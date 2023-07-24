# Gobuster Cheatsheet



Directory mode 
```bash
gobuster dir -u http://10.10.10.10 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
```

DNS mode
```bash
gobuster dns -d mydomain.thm -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt
```

Vhost mode
```bash
gobuster vhost -u http://example.com -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt
```

Blacklisting Status code
```bash
-b	--status-codes-blacklist	# Negative status codes
gobuster dir $url $wordlist -b 302 # uid errors add more status codes
```

```bash
-c	--cookies	# Cookies to use for requests
-x	--extensions	# File extension(s) to search for
-H	--headers	# Specify HTTP headers, -H 'Header1: val1' -H 'Header2: val2'
-k	--no-tls-validation # Skip TLS certificate verification
-n	--no-status	# Don\'t print status codes
-P	--password	# Password for Basic Auth
-s	--status-codes	# Positive status codes

-U	--username	# Username for Basic Auth
```

## References

[Ippsec](https://ippsec.rocks)