# NodeJS
Is a [[Useful_Javascript]] framework, or web technology.


[READ](https://github.com/ajinabraham/Node.Js-Security-Course)

## Shell
[Shell](https://github.com/ajinabraham/Node.Js-Security-Course/blob/master/nodejsshell.py)

## Deserialization

[deserialization](https://opsecx.com/index.php/2017/02/08/exploiting-node-js-deserialization-bug-for-remote-code-execution/)

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

## Vulnerable Require() 

Because [Node.js](https://nodejs.org/en/knowledge/getting-started/what-is-require/) `require()` allows for relative paths for module cache  if filesystem control is in your favour hijack the path `badVersionOfCalledModule` module and force that on any called functions from theat module to provide *"blazely fast"* \*cough\* code execution. 
[Freecode camp Node.js Require() ](https://www.freecodecamp.org/news/requiring-modules-in-node-js-everything-you-need-to-know-e7fbd119be8/)
[Honeybadger.io - Node.js Cache](https://www.honeybadger.io/blog/nodejs-caching/)

Get all the local paths of modules
```bash
node 
> module.paths
```

