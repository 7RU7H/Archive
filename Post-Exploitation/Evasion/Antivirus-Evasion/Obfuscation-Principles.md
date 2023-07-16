# Obfuscation Principles
Obfuscation is an essential component of any detection evasion methodology and preventing analysis of malicious software. Obfuscation is widely used in software related fields to protect Intellectual Property and proprietary information contained in an application. [Layered obfuscation: a taxonomy of software obfuscation techniques for layered security paper](https://cybersecurity.springeropen.com/track/pdf/10.1186/s42400-020-00049-3.pdf) organizes obfuscation methods by layers.

#### Taxonomy 
![](taxonomy-of-software-obfuscation-techniques-for-layered-security.png)

The **Code Element Layer** is crucial layer for describing how modifaction to payloads can be obfuscated.
![](obfuscation-techniques-of-code-element-layer.png)

**Obfuscation Method** | **Purpose**  
--- | ---
Class Hierarchy Flatterning | 
Class Splitting/Coalescing | 
Dropping Modifers | 
Method Proxy |
Methdo Scattering/ Aggregation | 
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


## String Obfuscation Operations

```powershell
# Concatenate  
('co'+'ff'+'ee')
# Reorder
('{1}{0}'-f'ffee','co')
# Whitespace 
( 'co' +'fee' + 'e')
```


## References
[Layered obfuscation: a taxonomy of software obfuscation techniques for layered security paper](https://cybersecurity.springeropen.com/track/pdf/10.1186/s42400-020-00049-3.pdf)
[THM Obfuscation Principles Room](https://tryhackme.com/room/obfuscationprinciples)
[THM Holo](https://tryhackme.com/room/hololive)