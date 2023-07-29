# NodeJS


[Node.js](https://nodejs.org) is a [[Useful_Javascript]] framework, or web technology. Or external links:
[XinYminutes JS](https://learnxinyminutes.com/docs/javascript/) and 


Node application will almost always accepts [[JSON]]


## Tools

[Javascript beautifer](https://beautifier.io/) for the JS online beautifier.


## Shells

[Shell](https://github.com/ajinabraham/Node.Js-Security-Course/blob/master/nodejsshell.py)
[Node.js Reverse shells](https://medium.com/dont-code-me-on-that/bunch-of-shells-nodejs-cdd6eb740f73)

## Deserialization

[Deserialization](https://opsecx.com/index.php/2017/02/08/exploiting-node-js-deserialization-bug-for-remote-code-execution/) blog

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
"return process.mainModule.require('child_process').execSync('cat /root/flag.txt');"
```

## Vulnerable Require() 

Because Node.js `require()` allows for relative paths for module cache  if filesystem control is in your favour hijack the path `badVersionOfCalledModule` module and force that on any called functions from theat module to provide *"blazely fast"* \*cough\* code execution. 
[Freecode camp Node.js Require() ](https://www.freecodecamp.org/news/requiring-modules-in-node-js-everything-you-need-to-know-e7fbd119be8/)
[Honeybadger.io - Node.js Cache](https://www.honeybadger.io/blog/nodejs-caching/)

Get all the local paths of modules
```bash
node 
> module.paths
```

## Appendix

[Node JS security Course](https://github.com/ajinabraham/Node.Js-Security-Course)


## References

[Node.js Reverse shells](https://medium.com/dont-code-me-on-that/bunch-of-shells-nodejs-cdd6eb740f73)
[Digital Ocean Node.js Module creation](https://www.digitalocean.com/community/tutorials/how-to-create-a-node-js-module)
[XinYminutes JS](https://learnxinyminutes.com/docs/javascript/)
[Javascript beautifer](https://beautifier.io/)
[Node.js](https://nodejs.org)