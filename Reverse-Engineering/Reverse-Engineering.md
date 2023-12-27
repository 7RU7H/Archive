# Reverse Engineering


- Reverse Engineering - from a binary get a approximate source code  
	- Preventing Rabbit holing 
		- Beware be aware of alternate character encoding
		- Labelling datatypes
			- Clear naming conventions for possibilities or questions 
		- Identifying Junk 
		- Dealing with [[Obfuscation-Principles]]
			- Identification of intent 
			- Identification components to program obfuscation 
				- For example seeding with time - checking your local and *non-local* - either the binary or the remote server's time.  
		- Identifying patterns of control flow
			- Cross referencing: variables,  
			- Standard or Non-standard implementation of known algorithms
				- Constant values sometimes called magic numbers are used requirement for the algorithm based on a Number Theory property of the value  
	- Controlling and breaking to understand what is actually happen during obfuscated sections of control flow	
		- Patch the binary and or set environment variables to control the program 


Contents of this page are adapted from noting Chris Eagle's methodology - [Kernelcon - Reverse Engineering with Chris Eagle](https://www.youtube.com/watch?v=YhyBRMOutOs)

```bash
# Check if stripped and general context
file $binary
# Check the size of the binary for fingerprinting lanaguages
ls -la 
# Check the compile and where it was built
# Lib.c enumeration 
strings $binary | grep -i gcc  
# Beware encodings
strings -e s # 7-bit byte (used for ASCII, ISO 8859) - Default
strings -e S # 8-bit byte
strings -e b # 16-bit bigendian
strings -e l # 16-bit littleendian


# Use a decompiler Ida, radare2, ghidra
# Chris does not use pwntools, but pwntools is good
# Find main() ..if you can..
# Do not panic with entropy, obfuscation, etc consider that it is only x amount of 
# Healthy personal RTFM reminder 
man $cfunctionsName
```



## References

[Kernelcon - Reverse Engineering with Chris Eagle](https://www.youtube.com/watch?v=YhyBRMOutOs)
[IDA and Malware Reverse Eng. 101 by Jake Williams](https://www.youtube.com/watch?v=h8CkxCpnxes)
## Appendix

#### Notes from [IDA and Malware Reverse Eng. 101 by Jake Williams](https://www.youtube.com/watch?v=h8CkxCpnxes)

[IDA and Malware Reverse Eng. 101 by Jake Williams](https://www.youtube.com/watch?v=h8CkxCpnxes)

```
regshot snapshots the registry
use fast ssd nvme VM for `scan dir` option REQUIRED. Compare registry changes

procmon, real time register changes, less noisy than sysmon
- process create filter, filter iut more noise

combine regshot and procmon


process hacker - check dll, edit memory on the fly
- if x86 and x64 components it should be in programs folder
memory tab of process hacker you can find string you were looking for - live jex editor

netsh is tcpdump with PROCESS


targets of opputunity

create the file c:\program.exe

process calls:
c:\program.exe is genius as it will in process also be the inital lookup
is the path qualified
is the path unquoted 
CreateFile (create or open) failures: 

Column | Relation | Value
--- | --- | --- 
Operation | is | CreateFile
Result | is not | SUCCESS
Path | Ends with | exe

regshot finds new services - process hacker has a popup on new service creation


majorgeeks site 100% spyware free

- Use traffic analysis to find insecure updates
	- is it over https?
		- is certificate pinned?
			- MITM the cert if is not
		- is update signed?
			 - if not the update does not certificate validate, swap out executable
		- is signature validated?
		- how is it validated?
		- Specific Certificate fingerprint, is principle name?
			- you can create self sign certs with any principle name


SysWow64 - x86 calls on third party good blue event monitor  commonly exploit because pathing

writing tasks and executing tasks is a race condition

if path is not explicit is then system hoping x
```

#### Notes from Chris Eagle from Kernelcon

Reverse Engineering with Chris Eagle from [Kernelcon - Reverse Engineering with Chris Eagle](https://www.youtube.com/watch?v=YhyBRMOutOs)
```bash
# Preventing Rabbit holing 
# Labelling datatypes
# Identifying Junk 
# Identifying patterns of control flow
# Patch the binary and or set environment variables to control the program


# Check if stripped and general context
file $binary
# Check the size of the binary for fingerprinting lanaguages
ls -la 
# Check the compile and where it was built
# Lib.c enumeration 
strings $binary | grep -i gcc  
# Use a decompiler Ida, radare2, ghidra
# Chris does not use pwntools, but pwntools is good
# Find main() ..if you can..
# Do not panic with entropy, obfuscation, etc consider that it is only x amount of 
# Healthy personal RTFM reminder 
man $cfunctionsName

# Getting the data typing correct is a main objective - labeling data structures and variables gets closer to source code than mess 
# Assign Datatypes, Assign Datatypes, Assign Datatypes - define 
# clear naming conventions for possibilities or questions 
# It cleans up the decompilation

# Cross referencing - highlighting in IDA helps figure out the next phase of connect what gets used and where and then you can ask why and what it is entails for reverse engineering the software 

# Data masking - is used in this talk to describe masking aspect of the control flow of the application with junk control flow. Not in the taxonomy of - https://cybersecurity.springeropen.com/counter/pdf/10.1186/s42400-020-00049-3.pdf 

# According to https://medium.com/@beeindian04/how-hackers-break-data-masking-23cac3ec6740 and  some other source data masking has the use of mask data that is considered sensitive; techniques to unmask 
# Brute forcing - try ALL THE THINGS TILL WE GET MATCH!
# Side channel attacks - analyses the masking technique
# Data interference attack - interfere with control to break the masking functionality

# Checking for standard implementation and non standard of algorithms 
# Some data values are important constants in algorithms 
# Is the algorithm implemented 


# Beware character encodings - weird characters like emoji can do weird things either by definition of the encoding and platform or the PROGRAMMER and their program we are reversing

# With random number generator mess with the seeding - int0x80 
# If randomness is seeded with a constant like time the constantly increments but has a human pattern as in the time format
# Compare time with local and non-local times
# Do what is required collect a pattern of sequences that the psuedo-random generator
# Nth term...?

```

With `gdb` to perform some dynamic analysis to confirm indicators of static addresses
```bash
shell pgrep $binaryname
attach # attach to the procress
info proc map # Check for static addresses
```


```python
# The following is the script created 

s = socket.socket()
s.connect(target)

def task(s, n):
	ru(s, "next? ")
	s.send()

interact(s)
s.close()
```