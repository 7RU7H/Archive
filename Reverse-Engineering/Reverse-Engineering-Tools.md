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

```bash
shell pgrep $binaryname
attach # attach to the procress
info proc map # Check for static addresses
```

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
pwn --help
usage: pwn [-h] {asm,checksec,constgrep,cyclic,debug,disasm,disablenx,elfdiff,elfpatch,errno,hex,libcdb,phd,pwnstrip,scramble,shellcraft,template,unhex,update,version} ...

Pwntools Command-line Interface

positional arguments:
  {asm,checksec,constgrep,cyclic,debug,disasm,disablenx,elfdiff,elfpatch,errno,hex,libcdb,phd,pwnstrip,scramble,shellcraft,template,unhex,update,version}
    asm                 Assemble shellcode into bytes
    checksec            Check binary security settings
    constgrep           Looking up constants from header files. Example: constgrep -c freebsd -m ^PROT_ '3 + 4'
    cyclic              Cyclic pattern creator/finder
    debug               Debug a binary in GDB
    disasm              Disassemble bytes into text format
    disablenx           Disable NX for an ELF binary
    elfdiff             Compare two ELF files
    elfpatch            Patch an ELF file
    errno               Prints out error messages
    hex                 Hex-encodes data provided on the command line or stdin
    libcdb              Print various information about a libc binary
    phd                 Pretty hex dump
    pwnstrip            Strip binaries for CTF usage
    scramble            Shellcode encoder
    shellcraft          Microwave shellcode -- Easy, fast and delicious
    template            Generate an exploit template
    unhex               Decodes hex-encoded data provided on the command line or via stdin.
    update              Check for pwntools updates
    version             Pwntools version

options:
  -h, --help            show this help message and exit
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