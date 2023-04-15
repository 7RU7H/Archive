# JSON Web Tokens

[[JSON]]

Common Terms | Description/Human Readable
--- | --- 
`nbf <epoch>` |Not before
`exp` | expires

JSON Web Tokens [https://jwt.io/](https://jwt.io/)

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

signature = 

```
