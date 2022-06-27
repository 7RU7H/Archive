# API Fuzzing
**Key indicator that you should not bruteforce is rate limiting the /api/ route** 

Tools:	
1. Postman
2. wfuzz
3. [[ffufCS]]
4. [[gobusterCS]]

```bash
wfuzz -c -z file,/usr/share/seclists/Discovery/Web-Content/api/objects.txt -X POST --hc 404,400 $IP/api/items\?FUZZ\=test

gobuster dir -u 'http://box.ip/api/' -w ~/tools/SecLists/Discovery/Web-Content/api/objects.txt  -t 100 -r -o api

```


# Endpoint Enumeration
[[Curl-Cheatsheet]]
```bash
curl -X POST <machine ip>/api/items\?$PARAM\=
# 
curl -X POST <Machine IP>/api/items\?cmd\=$URLENCODEDSHELLCODE
```

