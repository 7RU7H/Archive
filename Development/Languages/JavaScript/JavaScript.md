# JavaScript

Firstly I apologise for those reading this. JavaScript seems insane to me. How is a integer not a data type or why should strings and integer be concatenate or how undefined variable not illegal? Above 95% of the internet is this. So it is important to know, but if you have come from other languages I decide to refer to as much to Wallace and Gromit to actual make the learning of this stick in my brain rather than exclamatory *"why?"* at everything instead of question with curiosity. [Here is meme joke for those who may be upset by Javascript or my insignificant opinions](https://www.youtube.com/watch?v=Uo3cL4nrGOk). Web Apps exist and I have to hack them sometimes, I respect JavaScript and what has done for the world and internet.

[Mark Rendle - Programming's Greatest mistakes](https://www.youtube.com/watch?v=Y9clBHENy4Q) - JavaScript
```javascript
'B' + 'a' ++ 'a' + 'a' === 'BaNaNa'
```

## Browser Tools

Browser Developer Tools, `Ctrl + F12`  is a underrated and very powerful utility to understand and interact with JavaScript. Every Browser has one. Use it.
- Inspector tab `Right Click -> Inspect Element` 
- Console tab can view log/error messages and run JS code within the browser. 
- Debugger tab  can set breakpoints and step-through instructions. Consider prettifying the JS from its mimified format - click  `{ }` at the bottom of the middle of the pane. 
- Network tab display the HTTP requests associated with the web page, like Burp Suite without the proxy.
- Storage tab - shows cache data, cookies, metadata (this storage help reduce traffic quantity)

## JS in a page

**Objects** are abstract containers that represented by data types and contain characteristics, you **Declare** objects to create and define it, **Assign** -ing value to that object and define **Scope** to what the object can affect and its accessibility - outside a code block it is global (generally a bad idea) and inside it is local variable.

```javascript
let a = "a" // block-scoped mutable variable
var b = 1 // GLOBAL mutatable variable - avoid
const c = a+b // block-scoped constant variable

// Operators
// +
// ++
// -
// --
// *
// /
// %
// let ComparisonOperator = "
// ==
// === // Equal and identiical
// !=
// !== // Not identical
// <
// <=
// >
// >=
// >=
// This is just comment made by '//' not code.
// There is cheese and cracker references to make my life learn javascript more comfortable - - think wallace and grommit, if not go watch wallace and grommit JS is evil. Lol
const x = 1; // = is the assignment operator the ; closes the statement syntactically
var y = { foo: "bar"}; // object with property named foo with value "bar"
var y = 2; // integers are not data types! Lunacy
var z; // Z is undefined... Insanity.
if x !== 2 {
	switch (y) {
		case 1:
			for (a = 1; a <= 10; a++) {
				console.log(`Number: ${a}`); // ${substitute with literal value no format specifiers }
				}
			break;
		default:
			document.write('script'); // document, HTML DOM write method()
	}
} else if {
	while (x <=y) {
		console.log(x++x+y) // enjoy
		console.log('B' + 'a' ++ 'a' + 'a')
	}
} else {
	switch ;
}

const crackers_types ["Water Biscuit", "Cream Cracker"]; // String array
// Naming is case sensitive; letters, numbers and underscore and dollar sign, must not begin with a digit and must not be a keyword
let some_butter = "with Butter to keep the cheese on top!";   
function addNumbers(x, y) {return x +y; };
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
cheese.toString();
console.log(cheese + some_butter); //String concatenation
console.log(x + some_butter); // -> "1with Butter to keep the cheese on top!" Madness.

// Objects
var choosePill = { // This is also a global btw..beware
	pillOne: 'Red',
    pillTwo: 'Blue',
    pillThree: 'Escape the bounds on your concept of context and choice'
};
// Arrays
let indexes ['zeroth','oneth','twoth'];
indexs[0];
```

For functions consider which ES versions - [w3schools JS Versions](https://www.w3schools.com/js/js_versions.asp)

Different ways variable create keywords

| Task                | `var` | `let` | `const` |
| ------------------- | ----- | ----- | ------- |
| Declared before use | N/A   | X     | X       |
| Block Scope         | N/A   | X     | X       |
| Redeclare           | X     | N/A   | N/A     |
| Reassign            | X     | X     | N/A     |
|                     |       |       |         |

## Source Code

#### Minification

Minification compresses JS files by removing unnecessary content: ws, comment, also with and as part of dev obfuscation. Various JS library use various techniques to minified the source code, obfuscating JS is make the source code incredibly slow. On top of it being JS... 
\

- JS beautifier is a good tool to de-minify.
- Either [[CyberChef]] your minified code or [lissy93](https://notes.aliciasykes.com/40065/50-awesome-dev-tool-tips):
- Under `⋮` → `Settings` → `Experiments` Select `Automatically pretty print in the Sources Panel`.


## Files  

Client side JavaScript files **Should Not** contain any secret values, passwords, encryption keys or any "hidden" functionality - but when has that stop developers.


## Web App Tricks

These are not techniques for abuse or exploitation just cool thing I found on the internet 

Turn copy and paste when it is turned on 
```js
// fireship.io
stopaimmediatePropatio()
```

## References

[Fireship.io ](https://www.youtube.com/shorts/7bmsDg4BaKw)
[Mark Rendle - Programming's Greatest mistakes](https://www.youtube.com/watch?v=Y9clBHENy4Q)
[THM Room - Javascript Basics](https://tryhackme.com/r/room/javascriptbasics)
[w3schools HTML DOM write()](https://www.w3schools.com/jsref/met_doc_write.asp)
[w3schools JS Versions](https://www.w3schools.com/js/js_versions.asp)
[lissy93 Dev Tips](https://notes.aliciasykes.com/40065/50-awesome-dev-tool-tips)