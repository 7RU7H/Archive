# Tools

## Linux Local Tools

```bash
ltrace		# display system and library

```

## Windows Local Tools

## Cross Platform CLI Tools
```bash
strings	 	# display printable strings in file(s)
```


## GDB

## GEF
*`GEF` (pronounced ʤɛf - "Jeff") is a kick-ass set of commands for X86, ARM, MIPS, PowerPC and SPARC to make GDB cool again for exploit dev. It is aimed to be used mostly by exploit developers and reverse-engineers, to provide additional features to GDB using the Python API to assist during the process of dynamic analysis and exploit development.* [Documentation](https://gef.readthedocs.io/en/master/)
To run:
```bash
gdb -q /path/to/my/bin
```


## Ghidra
[[Ghidra-Cheatsheet]]

## Immunity Debugger

Step into  `F7`
Step over `F8`
Debug menu `F9`

To search `right-click inside disassemble window -> Search for -> [Various search all arguments`.

To set a breakpoint `Select line on disassembly window -> F2`.

Excute till return `Ctrl + F9`

Overflow with `Open -> Enter Filename <Name>; Files of type: <Type>; Arguments: <Pass arguments here> `

## Mona
## Putty
## Pwntools
[Python library documentation](http://docs.pwntools.com/en/stable)
[GDB plugin documentation](https://browserpwndbg.readthedocs.io/en/docs/)
Installation
```bash
apt-get update
apt-get install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pwntools
```

## Radare2
[Introductory Documentation](https://github.com/radareorg/radare2/blob/master/doc/intro.md)

[[Radare2 Commands]], [[Radare2-Cheatsheet]] are avaliable



## References
[THM Intro to x86-64 room](https://tryhackme.com/room/introtox8664)
[THM Ghidra room](https://tryhackme.com/room/ccghidra)
[THM Radare2 room](https://tryhackme.com/room/ccradare2)
[Tib3rius Cheatsheet](https://github.com/Tib3rius/Pentest-Cheatsheets/blob/master/exploits/buffer-overflows.rst)