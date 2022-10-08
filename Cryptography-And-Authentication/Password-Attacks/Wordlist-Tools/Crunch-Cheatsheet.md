# Crunch

## Introduction
Crunch can create a wordlist based on criteria you specify. The output from crunch can be sent to the screen, file, or to another program.

```bash
apt install crunch
```

```bash
Usage: crunch <min> <max> [options]
# where min and max are numbers
-t # flag to set a specific pattern 
```
Before using Crunch be extremely careful with disk memory usage exponentation! It is very easy to generate a wordlist of many Terabytes. BEWARE.

## Patterns

Pattern Character | Character Translation
---  | ---
`@` | Lower case alphabet characters
`,` | Upper case alphabet characters
`%` | Numeric characters
`^` | Special characters including space



## References
[hadenlabs](https://github.com/hadenlabs/cheatsheet/blob/develop/crunch)
[mivang](https://github.com/mivang/cheatsheets/blob/master/crunch)
[hackingarticles](https://www.hackingarticles.in/a-detailed-guide-on-crunch/)
