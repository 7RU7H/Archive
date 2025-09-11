# Javascript Vulnerable Functions
For [[JavaScript]]

[Jokes aside](https://www.youtube.com/watch?v=Uo3cL4nrGOk), [[JavaScript]]...

## Node.js

#### fs, readFile, readFileSync
```javascript 
fs module // allows an attacker to read the contents of files
// Invoked with require, all method have (a)sychronous versions
require('fs').readFileSync(<filename>)
// -> 
var fs=require("fs");fs.readFileSync("/app/configs/index.js").toString('utf8')
						 

```

#### process, child process
Use to gather information on current Node.js processes - it **global**
`child-process` creates processes in Node.Js with any below:
```javascript
spawn() // returns a stream
fork()
exec() 	//return the entire buffer
execFile
```

```javascript
evaluate()
```

#### RCE eval()
```javascript
eval() // Executes run-time code
// Enumeration: Endpoints and unusual behaviour the Application displays
// Use: Curl, Postman to find suspicious responses
// Observe: Varients datatypes in a data object
// Prove: use process
```



Migitation:
1. Use Safer Functions
1. Validate user input before processing
1. Sanitize Characters


## Lang Flavour

#### exploit Template()

```

```
Migitation:

