# Immunity Debugger

Open file to debug `File -> Open` , it will open in a paused state

Step into  `F7`
Step over `F8`
Debug menu `F9`

To search `right-click inside disassemble window -> Search for -> [Various search all arguments`.

To set a breakpoint `Select line on disassembly window -> F2`.

Execute till return `Ctrl + F9`

Overflow with `Open -> Enter Filename <Name>; Files of type: <Type>; Arguments: <Pass arguments here> `

## Mona

```
!mona config -set workingfolder c:\mona\%p

# Controlling EIP 
# Mona should display a log window with the output of the command. 
# msf-pattern_create $x
!mona findmsp -distance $x 
# If not, "Window" menu -> "Log data" 
# To  switch back to standard view -> choose "CPU").
msf-pattern_offset -q $pattern_in_eip
# Bad character enumeration
# Generate a bytearray using mona, and exclude the null byte (\x00) by default
!mona bytearray -b "\x00"
# Compare ESP
!mona compare -f C:\mona\oscp\bytearray.bin -a $ESP
```