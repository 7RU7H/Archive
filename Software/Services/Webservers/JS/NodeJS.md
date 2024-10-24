# NodeJS


[Node.js](https://nodejs.org) is a [[Useful_JavaScript]] framework, or web technology. Or external links:
[XinYminutes JS](https://learnxinyminutes.com/docs/javascript/) and 

Node application will almost always accepts [[JSON]]

[NodeJS 2024 TypeScript integration is not compiled enjoy](https://nodejs.org/en/learn/getting-started/nodejs-with-typescript)

#### Tools

[Javascript beautifer](https://beautifier.io/) for the JS online beautifier.


#### Shells

[Shell](https://github.com/ajinabraham/Node.Js-Security-Course/blob/master/nodejsshell.py)
[Node.js Reverse shells](https://medium.com/dont-code-me-on-that/bunch-of-shells-nodejs-cdd6eb740f73)

#### Deserialization

[Deserialization](https://opsecx.com/index.php/2017/02/08/exploiting-node-js-deserialization-bug-for-remote-code-execution/) blog

#### Globals
```javascript
__dirname
__filename
exports
module
require()
```


#### Node.js Payload
```javascript
"return process.mainModule.require('child_process').execSync('cat /root/flag.txt');"
```

#### Vulnerable `Require()` 

Node.js `require()` allows for relative paths for module cache if you control the file system hijack the path `badVersionOfCalledModule` module and force that on any called functions from that module to provide *"blazingly fast"* \*cough\* code execution. 
[Freecode camp Node.js Require() ](https://www.freecodecamp.org/news/requiring-modules-in-node-js-everything-you-need-to-know-e7fbd119be8/)
[Honeybadger.io - Node.js Cache](https://www.honeybadger.io/blog/nodejs-caching/)

Get all the local paths of modules
```bash
node 
> module.paths
```

[xct](https://notes.vulndev.io/wiki/redteam/misc/other) Port Java Code to NodeJS
```java
node> password = "jU5t_a_sna_3lpm1dg347_u_4_mfr54b"> var i;> var buffer = Array(32);> for (i=0; i<8; i++) {...     buffer[i] = password.charAt(i);... }> for (; i<16; i++) {...     buffer[i] = password.charAt(23-i);... }> for (; i<32; i+=2) {...     buffer[i] = password.charAt(46-i);... }> for (i=31; i>=17; i-=2) {...     buffer[i] = password.charAt(i);... }> console.log("picoCTF{" + buffer.join("") + "}");
```
## Appendix

[Node JS security Course](https://github.com/ajinabraham/Node.Js-Security-Course)


## References

[Node.js Reverse shells](https://medium.com/dont-code-me-on-that/bunch-of-shells-nodejs-cdd6eb740f73)
[Digital Ocean Node.js Module creation](https://www.digitalocean.com/community/tutorials/how-to-create-a-node-js-module)
[XinYminutes JS](https://learnxinyminutes.com/docs/javascript/)
[Javascript beautifer](https://beautifier.io/)
[Node.js](https://nodejs.org)
[NodeJS 2024 TypeScript integration](https://nodejs.org/en/learn/getting-started/nodejs-with-typescript)