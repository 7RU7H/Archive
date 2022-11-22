# Useful Javascript

Firstly I apolegise for those reading this. Javascript seems insane to me. How is a integer not a data type or why should strings and integer be concatenate or how undefined variable not illegal? Above 95% of the internet is this. So it is important to know, but if you have come from other languages I decide to refer to as much to Wallace and Gromit to actual make the learning of this stick in my brain rather than exclamatory *"why?"* at everything instead of question with curiousity. [Here is meme joke for those who may be upset by Javascript or my insignificant opinions](https://www.youtube.com/watch?v=Uo3cL4nrGOk). Web Apps exist and I have to hack them sometimes, I respect Javascript and what has done for the world and internet.

## Browser Tools

Browser Developer Tools, `Ctrl + F12`  is a underated and very powerful utility to understand and interact with Javascript. Every Browser has one. Use it.
- Inspector tab `Right Click -> Inspect Element` 
- Console tab can view log/error messages and run JS code within the browser. 
- Debugger tab  can set breakpoints and step-through instructions. Consider prettifying the JS from its mimified format - click  `{ }` at the botton of the middle of the pane. 
- Network tab display the HTTP requests associated with the web page, like Burpsuite without the proxy.
- Storage tab - shows cache data, cookies, metadata (this storage help reduce traffic quantity)

## JS in a page

**Objects** are abstract containers that respresented by data types and contain characteristics, you **Declare** objects to create and define it, **Assign** -ing value to that object and define **Scope** to what the object can affect and its accessiblity - outside a code block it is global (generally a bad idea) and inside it is local variable.

```javascript
// This is just comment made by '//' not code.
// There is cheese and cracker references to make my life learn javascript more comfortable - - think wallace and grommit, if not go watch wallace and grommit JS is evil. Lol
const x = 1; // = is the assignment operator the ; closes the statement syntactically
var y = { foo: "bar"}; // object with property named foo with value "bar"
var y = 2; // integers are not data types! Lunacy
var z; // Z is undefined... Insanity.
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
console.log(x + some_butter); // -> "1with Butter to keep the cheese on top!" Maddness.
```

Different ways variable create keywords
Task |  `var`  | `let` | `const`
 --- | --- | --- | ---
Declared before use | N/A | X | X
Block Scope | N/A | X | X
Redeclare | X | N/A | N/A 
Reassign | X | X | N/A 



## Minification

Minification compresses JS files by removing unnecessary content: ws, comment, also with and as part of dev obfusaction. Various JS library use various techniques to minified the source code, obfuscating JS is make the source code increbily slow. On top of it being JS... JS beautifier is a good tool to de-minify


## Files  

Client side Javascript files **Should Not** contain any secret values, passwords, encryption keys or any "hidden" functionality - but when has that stop developers.


