# Useful Javascript
```javascript
var x = 1;
var y = { foo: "bar"}; // object with property named foo with value "bar"
var y = 2;
function addNumbers(x, y) {return x +y; }
//methods in JS could be consider as:
//A function that is a property of an object
//Methods can reference values of the object that owns it with the keyword = "this";
var cheese = {
	name: 'Gouda'
	isApplied: 'sliced atop butter'
	toString: function() {
		return this.name + " placed on crackers " + this.isApplied;
	}
};
cheese.toString()
```


## Minification
Minification compresses JS files by removing unnecessary content: ws, comment, also with and as part of dev obfusaction. Various JS library use various techniques to minified the source code, obfuscating JS is make the source code increbily slow. On top of it being JS... 

JS beautifier is a good tool to de-minify


## Files  

Client side js files SHOULD NOT contain any secret values, passwords, encryption jeys or any "hidden" functionality - but when has that stop JS devs.


