# API Fuzzing
Tools:
1. Postman
2. wfuzz
3. fuff

```bash
wfuzz -c -z file,/usr/share/seclists/Discovery/Web-Content/api/objects.txt -X POST --hc 404,400 $IP/api/items\?FUZZ\=test

gobuster dir -u 'http://box.ip/api/' -w ~/tools/SecLists/Discovery/Web-Content/api/objects.txt  -t 100 -r -o api

```


# Endpoint Enumeration
```bash
curl -X POST <machine ip>/api/items\?$PARAM\=
# 
curl -X POST <Machine IP>/api/items\?cmd\=$URLENCODEDSHELLCODE
```

