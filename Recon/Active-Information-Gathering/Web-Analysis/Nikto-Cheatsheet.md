# Nikto Cheatsheet 
## Scan options  
```bash
nikto -h $IP -port $PORT-1,$PORT-2 -output nikto/port-$PORT.txt 
nikto -h $DOMAIN -output nikto/$DOMAIN.txt
nikto -h $IP -Tuning $0-9[a-c,x]
nikto -h $IP -ssl                    # ssl
nikto -h $IP -useragent Mozilla/5.00 # Evade IDS
nikto -h $IP -maxtime $seconds # Define maximum scan time  
nikto -h $IP  -until # Scan duration  
nikto -h $IP -vhost # Define host header  
nikto -h $IP -no404  # Skip http 404 guessing  
nikto -h $IP -nossl # Stop using SSL during scan  
nikto -h $IP -ssl # Force to use SSL  
nikto -update  #Update scan engine plugins  
nikto -h $IP -dbcheck # Check database   
nikto -h $IP -useproxy (Proxy IP address) # Web host scan via a proxy 
nikto -h $IP -config (filename.conf) # Use a specified file as a database  
nikto -h $IP -nolookup 	# Stop DNS lookup for hosts  
nikto -h $IP -nocache 	# Stop caching responses for scans
```
## Tuning
If you need to check for a specific vulnerablity

Option | Description
--- | ---
`0` | File Upload
`1` | Interesting File / Seen in logs
`2` | Misconfiguration / Default File
`3` | Information Disclosure
`4` | Injection (XSS/Script/HTML)
`5` | Remote File Retrieval - Inside Web Root
`6` | Denial of Service
`7` | Remote File Retrieval - Server Wide
`8` | Command Execution / Remote Shell
`9` | SQL Injection
`a` | Authentication Bypass
`b` | Software Identification
`c` | Remote Source Inclusion
`x` | Reverse Tuning Options (i.e., include all except specified)

## Display 
Option | Description
--- | ---
1 | Display redirects  
2 | Display cookies  
3 | Display 200 ok response  
4 | Display Web URLs requiring authentication  
D | Display debug output  
E | Show HTTP errors  
P | Print to STDOUT  
V | Verbose output display

## Plugins
```bash
-Plugin apacheuser

```


## References
[rangeforce](https://materials.rangeforce.com/tutorial/2019/12/05/Nikto/)