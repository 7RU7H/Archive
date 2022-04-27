# Useful Python 

This is a condensed and *Hacking Themed* resource for python.
Remember with python [you need a ruler for tab indentatio](https://www.youtube.com/watch?v=YnL9vAFphmE) and [sometimes we have a competition to write the longest list comprehension...and sometimes it's in production...and sometimes we don't call it a competition but work](https://www.youtube.com/watch?v=BgxklT94W0I) which requires a [phd](https://www.youtube.com/watch?v=xyrgkui0uCA).

# Basics

## Fundamentals

```python3 
#! /usr/bin/python3 # Shebang line
# Comments with # 
	# Tab indentation is

myInt = 1337
myFloat = 1010.0101
myString = "ping"
print(f"{myString[0]} {myString[1]} {myString[2]} {myString[3]} string slicing with \[1:2\] {myString[1:2]} python")
myList = ["burp", "gobuster", "hydra", "empire", "nikto", "nmap", "sqlmap", "wfuzz", "SecLists","PayloadAllTheThings","OWASPtop10","Discover by Lee Baird",False,True]
print(f"{myString}.. using f-string(these can be used in variable declaration aswell!) in a print to stdout")
print(f"reference by index value with square bracks: \[{mylist[1}\]") 
# Data storage types
myMatrix = [
            [0,0,0],
            [0,1,0],
            [0,0,0],
        ]
myTuple_Zero, myTuple_One,myTuple_leet, myTuple_MFS, myTuple_Burp = (0,1,1337,4444,8000) 
mySet = {"nmap", "brutespray", "gobuster", "nikto"}
myDict = {
    8000 : "Burp Suite Proxy"
    admin : "password"
    True : False
    definition : "A dictionary is a key value pair, the string is the value, but its key is defintion"
}
myDict["to add to a dictionary"] = "simply have a key in square brackets and assign a value" 

# Useful functions
len()
type()
str() # string type casting
int() # int type casting
round(myFloat)
sorted()
set(myList)
# Useful methods
myList.append("crackmapexec")
.remove
.contains
.split
.index
# Looping with for, for range, while keywords
for tool in myList:
	print(f"{tool} is ready for use!")
	print("SERIOUS COUNTING IN A WHILE AND THEN AFOR LOOP")
    	i = 0
    	while i < 10:
        	print(i)
        	i += 1
		for i in range myDict:
			print(f"{i+{str({int(i)})} is f strings nesting")
```

Functions

```python3 
def commands():
    theMethod = {
             "nmap":" -sC -sV -O -T 4 -p- ",
             "nikto":" -h ",
             "gobuster":" dir -u http://"
        }

    gobusterVar = {
                "dirbusterDirMed":" -w /usr/share/dirbuster/directory-list-2.3-medium.txt",
                "dirbCommon":" -w /usr/share/dirb/common.txt"
        }

    ip = "10.10.10.10"

    for k in theMethod.keys():
        if k != "gobuster":
            print(f"{k}{theMethod[k]}{ip}")
        else:
            for l in gobusterVar:
                print(f"{k}{theMethod[k]}{ip}{gobusterVar[l]}")

    print("complete")
```
File IO and User Input with keyword input

```python3
# This consider nooby 
print("Would you like to read from the demo.txt? Y/n:")
    if input('Y'):
        f = open("demo.txt", "r")
        data = f.read()
        for line in f:
        print(line)
        f.close()

# It is better to use with that auto closes after use - good for tear down code!
with open(ip_range, "r") as f:

```
## Next level

Emumerate is commonly consider better in many case for solving problems with iterables.
They return index and elem
```
for i,word in emunerate('iteratables are tuples, lists, sets, dict, strings')
print(i,char)
i = 20
while i > 0:
    print(f"Tick tock...{i} and {char} seconds left")
    i -= 1
```
Nonlocal keyword

```python3
nonlocal thisnotglobalbutoutsidefunctionscoping se with care
```
Modules and packages allow for programmers to segment code to organise and allow other code to reuse that code.
Avoid importing loops main.py-\>foo.py\<-\>bay.py 

```python3
import module
import package.package_module
from something import onething
externalImports = "External modules work in a similar way except we will need to make them available in our PYTHONPATH so they can be imported. This can be done by downloading the module manually and placing it in a directory that Python will search for modules in. We can also do this automatically by using a tool named pip. Pip is a Python package installer that will make it very easy to download and install Python modules into appropriate locations on our system."
print(externalImports)


```

Ternary and shortcircuiting

```python
is_ternary = True
ternary_op_message = "This message will print at evaluation of the boolean  of is_tenery with if and else" if is_tenary else "Not ternary"
print(is_ternary)
if is_ternary or is_short_circuiting
print("Short circuiting using or with is_ternary and is_short_circuiting being True")
print("is keyword check the value in memory is the same")
```
Function declaration, returns, \*args and \*\*kwargs

```python3
def super_func(*args)
    return sum(args)

def special_func(**kwargs)

print("super_func() with *args can accept any number of any type of arguments")
print("special_func(**kwargs) can accept any number of any type keyword=value")
print("Ordering dule: params, *args, defult parameters then **kwargs")
```

# CLI and ENV
```bash
python3 
python3 -v
```

# Appendix

## Tips for cleaner code

```python3
print("Ints type convert wto float when they become decimal values")
print("Don't read the dictionary")
print("Don't comment too much make documentation as code")
print("Dictionary is unordered, key - value pair")
print("Scope is what variable do I have access to")
print("Keys are immutable, has to be unique")
print("Lists are ordered, denoted by square brackets")
print("Are collection of unique unordered objects")
print("Tuples are immutable")
print("code if clear'n'clear")
print("Simple and standardised, without bad smells can be readable to be refactored if needed")
print("Predicately domain delivery under SOLID design principles")
print("DRY but away from condition pyramids of doom")
print("Functionally like lego, compositional and extendable but closed for modification")
```

