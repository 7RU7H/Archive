# Crunch

## Introduction

Crunch can create a wordlist based on criteria you specify. The output from crunch can be sent to the screen, file, or to another program.

```bash
apt install crunch
```

```bash
Usage: crunch <min> <max> [options]
# where min and max are numbers
-q # input from a wordlists
-t # flag to set a specific pattern 
-l # treat symbols @,%^ as literals
-i # invert wordlists - invert permutation position to frist position not last
-d # limit duplicate patterns
-p # --permutate [PATTERN] [PATTERN] [PATTERN] [PATTERN] [PATTERN] [PATTERN] - max is 6
# Pins
crunch 4 4 -t %%%% -o 4-digit-pins.txt
crunch 6 6 -t %%%%%% -o 6-digit-pins.txt
crunch 8 8 -t %%%%%%%% -o 8-digit-pins.txt
# Passwords where @ is literally we require a literal string so the p@ss[PATTERN] is generated
crunch 7 7 -t p@ss,%^ -l a@aaaaa > 1.txt
# Passwords
crunch 10 10 -t password%^ -o password.txt
# Terminate generate at pattern -e [PATTERN]
crunch 3 3 abc -e acc -o 2.txt
# Permutate with a max of 6 space seperated patterns
crunch 3 3 -p abc %%% XYZ -o 3.txt
# Permutate pattern and wordlist
crunch 3 3 edf -q 3.txt -o 4.txt

# Space Character Wordlists
crunch 1 5 "7ru7h " -o space.txt
head -n 10 space.txt
7
r
u
7
h

77
7r
7u
...
# Pretty cool
# Charsets:
/usr/share/crunch/charset.lst
# Using Charsets
crunch 4 4 -f charset.lst mixalpha-numeric-all -o wordlist.txt
# Startblock - from where start generating from so abc would be abc1 abc2 abc3...
crunch 4 4 -f charset.lst mixalpha-numeric-all -o wordlist.txt -s abc1
# Inverted wordlists - compare 
crunch 5 5 abc12 -t @@@%% -o dict.txt
# The above produces: aaa00, aaa01, aaa02, aaa03, aaa04...
crunch 5 5 abc12 -t @@@%% -i -o invert.txt
# The above produces: aaa00, baa00, caa00, 1aa00, 2aa00, aba00

```
Before using Crunch be extremely careful with disk memory usage exponentation! It is very easy to generate a wordlist of many Terabytes. BEWARE.

#### Patterns
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
