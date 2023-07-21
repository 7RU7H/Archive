# Obfuscation Principles

Obfuscation is an essential component of any detection evasion methodology and preventing analysis of malicious software. Obfuscation is widely used in software related fields to protect Intellectual Property and proprietary information contained in an application. [Layered obfuscation: a taxonomy of software obfuscation techniques for layered security paper](https://cybersecurity.springeropen.com/track/pdf/10.1186/s42400-020-00049-3.pdf) organises obfuscation methods by layers.

#### Taxonomy 
![](taxonomy-of-software-obfuscation-techniques-for-layered-security.png)

The **Code Element Layer** is crucial layer for describing how modifaction to payloads can be obfuscated.
![](obfuscation-techniques-of-code-element-layer.png)

**Obfuscation Method** | **Purpose** 
--- | ---
Class Hierarchy Flattening | 
Class Splitting/Coalescing | 
Dropping Modifers | 
Method Proxy |
Method Scattering/ Aggregation | 
Method Clone | 
Method Inline/Outline |
Array Transformation  | Transforms an array by splitting, merging, folding, and flattening  
Data Encoding  | Encodes data with mathematical functions or ciphers  
Data Procedurization  | Substitutes static data with procedure calls  
Data Splitting/Merging  | Distributes information of one variable into several new variables
Implicit Controls | Converts explicit controls instructions to implicit instructions  
Dispatcher-based Controls | Determines the next block to be executed during the runtime  
Probabilistic Control Flows | Introduces replications of control flows with the same semantics but different syntax  
Bogus Control Flows | Control flows deliberately added to a program but will never be executed
Junk Code | Add junk instructions that are non-functional, also known as a code stubs  
Separation of Related Code | Separate related codes or instructions to increase difficulty in reading the program  
Stripping Redundant Symbols | Strips symbolic information such as debug information or other symbol tables  
Meaningless Identifiers | Transform a meaningful identifier to something meaningless


#### String Operations for Obfuscation 

Obfuscation through preemptive deconstruction of all objects in a program in the attempt to remove all signatures at once. 
```powershell
# Concatenation
('co'+'ff'+'ee')
# Reordering
('{1}{0}'-f'ffee','co')
# Whitespace - Spliting
( 'co' +'fee' + 'e')
# Ticks - Non interpreted characters
``c`o`f`f`e``
# Case insensitivity 
cOfFeE
```

#### Control Flow Obfuscation

`if`, `elif`, `else` and `try` - `except`
```python
x = "0bfuSc4t10n"
# if / elif / else Blocks
if(x > 7):
	print("This 0bfuSc4t10n is 0bfuSc4t3d")
else:
	print("This is ignored")
# try / (catch/except)
try:
	--x
except  Exception as e:
	print("0bfuSc4t10n!")
```

Switch case
```go
func main() {
	x := "0bfuSc4t10n"
	switch x {
	case "x":
		fmt.Println("Is an x")
	case "y":
		fmt.Println("Is a Y")
	case "z":
		fmt.Println("ZZZzzzz")
	default:
		fmt.Println(x)
	}
}
```

For/while loops
```c
#include <stdio.h>
int main()
{
        int i;
        for (i = 0; i <= 10; i++)
        {
        i += 8;
                while(i != 7 || i != 9)
                {
                printf("...here we are\n");
                }
        return 0;
        }
}
```

## Arbitrary Control Flow Patterns

Programming Arbitrary Control Flow Patterns can be patched into code with the use of mathematics, logic, and/or algorithms to inject different control flow into malicious functions to obfuscate the malicious function's intent.

 [Opaque Predicate: Attack and Defense in Obfuscated Binary Code](https://etda.libraries.psu.edu/files/final_submissions/17513), states, *“An opaque predicate is a predicate whose value is known to the obfuscator but is difficult to deduce. It can be seamlessly applied with other obfuscation methods such as junk code to turn reverse engineering attempts into arduous work.”* 
```python
# Example from THM using the unsolved Collatz Conjecture 
# Does not matter it is unsolved as the known output will be one.
x = 0
while(x > 1):
	if(x%2==1):
		x=x*3+1
	else:
		x=x/2
	if(x==1):
		print("hello!") 

```

Opaque predicates either to arbitrarily add logic to a program or refactor the control flow of a pre-existing function and are either categorised as either:
- Bogus control flow 
- Probabilistic control flow

## Protecting and Stripping Identifiable Information

Interpreted languages could use tools like the deprecated [Badger PowerShell loader](https://github.com/paranoidninja/Brute-Ratel-C4-Community-Kit/blob/main/deprecated/badger_template.ps1) from the [BRC4 Community Kit](https://github.com/paranoidninja/Brute-Ratel-C4-Community-Kit) that *contains scripts, configurations and deprecated payload loaders for Brute Ratel C4* ([https://bruteratel.com/](https://bruteratel.com/))

- Compilers
- [[Packers]]

```bash
strip --strip-all $file.exe
```


## References

[Layered obfuscation: a taxonomy of software obfuscation techniques for layered security paper](https://cybersecurity.springeropen.com/track/pdf/10.1186/s42400-020-00049-3.pdf)
[THM Obfuscation Principles Room](https://tryhackme.com/room/obfuscationprinciples)
[THM Holo](https://tryhackme.com/room/hololive)
[Wikipedia Collatz Conjecture](https://en.wikipedia.org/wiki/Collatz_conjecture) 
[Badger PowerShell loader](https://github.com/paranoidninja/Brute-Ratel-C4-Community-Kit/blob/main/deprecated/badger_template.ps1) 
[BRC4 Community Kit](https://github.com/paranoidninja/Brute-Ratel-C4-Community-Kit).
