# Tools

## Linux Local Tools

```bash
ltrace		# display system and library

```

## Windows Local Tools

## Cross Platform CLI Tools


#### Strings
Different strings encoding may reveal different hardcoded credentials on poor designed applications
```bash
strings -e s # 7-bit byte (used for ASCII, ISO 8859) - Default
strings -e S # 8-bit byte
strings -e b # 16-bit bigendian
strings -e l # 16-bit littleendian
```

## EDG

[[EDB]]

## GDB

## GEF

*`GEF` (pronounced ʤɛf - "Jeff") is a kick-ass set of commands for X86, ARM, MIPS, PowerPC and SPARC to make GDB cool again for exploit dev. It is aimed to be used mostly by exploit developers and reverse-engineers, to provide additional features to GDB using the Python API to assist during the process of dynamic analysis and exploit development.* [Documentation](https://gef.readthedocs.io/en/master/)
```bash
# probably will require root privileges..
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"
# for extras!
wget -q -O- https://github.com/hugsy/gef/raw/main/scripts/gef-extras.sh | sh
# Inside GDB - 2023 kali python3-NOGEFHERE for apt :(
gdb -q
pi import urllib.request as u, tempfile as t; g=t.NamedTemporaryFile(suffix='-gef.py'); open(g.name, 'wb+').write(u.urlopen('https://tinyurl.com/gef-main').read()); gdb.execute('source %s' % g.name)
```

To run:
```bash
gdb -q /path/to/my/bin
```


## Ghidra

[[Ghidra-Cheatsheet]]

## Immunity Debugg

[[Immunity-Debugger-Helpsheet]]

## Mona

[[Mona]]

## Putty

## Pwntools

[Python library documentation](http://docs.pwntools.com/en/stable)
[GDB plugin documentation](https://browserpwndbg.readthedocs.io/en/docs/)
Installation - beware command below are for Kali - 2023 - pip is not used
```bash
apt-get update
apt install python3-pwntools
```

## Radare2

[Introductory Documentation](https://github.com/radareorg/radare2/blob/master/doc/intro.md)

[[Radare2-Commands]], [[Radare2-Cheatsheet]] are avaliable
```bash
<cmd>? # each command has a help use it 
is # Removing some of the symbols to make the display cleaner
aaa # Analyze
db main # set breakpint on main
dc # continue execution
```



## References

[THM Intro to x86-64 room](https://tryhackme.com/room/introtox8664)
[THM Ghidra room](https://tryhackme.com/room/ccghidra)
[THM Radare2 room](https://tryhackme.com/room/ccradare2)
[Tib3rius Cheatsheet](https://github.com/Tib3rius/Pentest-Cheatsheets/blob/master/exploits/buffer-overflows.rst)
[Radare2 Introductory Documentation](https://github.com/radareorg/radare2/blob/master/doc/intro.md)
[Python library documentation](http://docs.pwntools.com/en/stable)
[GDB plugin documentation](https://browserpwndbg.readthedocs.io/en/docs/)
[GEF Documentation](https://gef.readthedocs.io/en/master/)