# Printer Hacking 

[Wikipedia IPP](https://en.wikipedia.org/wiki/Internet_Printing_Protocol) states: *"The **Internet Printing Protocol** (**IPP**) is a specialized [communication protocol](https://en.wikipedia.org/wiki/Communication_protocol "Communication protocol") for communication between client devices (computers, mobile phones, tablets, etc.) and printers (or [print servers](https://en.wikipedia.org/wiki/Print_server "Print server")). It allows clients to submit one or more [print jobs](https://en.wikipedia.org/wiki/Print_job "Print job") to the network-attached printer or print server, and perform tasks such as querying the status of a [printer](https://en.wikipedia.org/wiki/Printer_(computing) "Printer (computing)"), obtaining the status of print jobs, or cancelling individual print jobs."*

Port 631 - 

Visit the local [[IPP]] page for more details, but for hacking [THM Printer 101 Room](https://tryhackme.com/r/room/printerhacking101) states: *"an open IPP port can expose a lot of sensitive information such as printer name, location, model, firmware version, or even printer wifi SSID."*

#### Printer Web Interfaces

Do not forget that Printer Administrator panels: `firefox -w -u $ip:$port`
- [[CUPS]]
#### PRET

[PRET](https://github.com/RUB-NDS/PRET) *"Printer Exploitation Toolkit - The tool that made dumpster diving obsolete."*

Install for [[Kali]]
```bash
# commented out driverless printing
apt install python3-colorama python3-pysnmp4 # imagemagick ghostscript
git clone https://github.com/RUB-NDS/PRET.git

```

```powershell
pip install win_unicode_console
```

- `pret.py` - Executable main program
- `capabilities.py` - Routines to check for printer language support
- `discovery.py` - Routines to list printers using SNMP broadcast
- `printer.py` - Generic code to describe a printing device
- `postscript.py` - PS specific code (inherits from class printer)
- `pjl.py` - PJL specific code (inherits from class printer)
- `pcl.py` - PCL specific code (inherits from class printer)
- `helper.py` - Help functions for output, logging, sockets, etc.
- `codebook.py` - Static table of PJL status/error codes
- `fuzzer.py` - Constants for file system fuzzing
- `mibs/*` - Printer specific SNMP MIBs
- `db/*` - database of supported models
- `lpd/*` - Scripts for LPD fuzzing

Printer Languages supported by [PRET](https://github.com/RUB-NDS/PRET), but it is better to just `help` to list the commands supported potentially by the Printer
1. PS (Postscript)
2. PJL (Printer Job Language)
3. PCL (Printer Command Language)

```bash
python3 pret.py $IP:$PORT pjl
python3 pret.py laserjet.lan ps
python3 pret.py /dev/usb/lp0 pcl

PRET Commands:
help      # List available commands or get detailed help with 'help cmd'.
debug     # Enter debug mode. Use 'hex' for hexdump:  debug [hex]
load      # Run commands from file:  load cmd.txt
loop      # Run command for multiple arguments:  loop <cmd> <arg1> <arg2> …
open      # Connect to remote device:  open <target>
close     # Disconnect from device.
timeout   # Set connection timeout:  timeout <seconds>
discover  # Discover local printer devices via SNMP.
print     # Print image file or raw text:  print <file>|"text"
site      # Execute custom command on printer:  site <command>
exit      # Exit the interpreter.
```

Generic file system operations with a PS/PJL/PCL specific implementation are:
```python
┌───────────┬─────┬─────┬─────┬────────────────────────────────────────┐
│ Command   │ PS  │ PJL │ PCL │ Description                            │
├───────────┼─────┼─────┼─────┼────────────────────────────────────────┤
│ ls        │  ✓  │  ✓  │  ✓  │ List contents of remote directory.     │
│ get       │  ✓  │  ✓  │  ✓  │ Receive file: get <file>               │
│ put       │  ✓  │  ✓  │  ✓  │ Send file: put <local file>            │
│ append    │  ✓  │  ✓  │     │ Append to file: append <file> <str>    │
│ delete    │  ✓  │  ✓  │  ✓  │ Delete remote file: delete <file>      │
│ rename    │  ✓  │     │     │ Rename remote file: rename <old> <new> │
│ find      │  ✓  │  ✓  │     │ Recursively list directory contents.   │
│ mirror    │  ✓  │  ✓  │     │ Mirror remote filesystem to local dir. │
│ cat       │  ✓  │  ✓  │  ✓  │ Output remote file to stdout.          │
│ edit      │  ✓  │  ✓  │  ✓  │ Edit remote files with vim.            │
│ touch     │  ✓  │  ✓  │     │ Update file timestamps: touch <file>   │
│ mkdir     │  ✓  │  ✓  │     │ Create remote directory: mkdir <path>  │
├───────────┼─────┼─────┼─────┼────────────────────────────────────────┤
│ cd        │  ✓  │  ✓  │     │ Change remote working directory.       │
│ pwd       │  ✓  │  ✓  │     │ Show working directory on device.      │
│ chvol     │  ✓  │  ✓  │     │ Change remote volume: chvol <volume>   │
│ traversal │  ✓  │  ✓  │     │ Set path traversal: traversal <path>   │
├───────────┼─────┼─────┼─────┼────────────────────────────────────────┤
│ format    │  ✓  │  ✓  │     │ Initialize printer's file system.      │
│ fuzz      │  ✓  │  ✓  │     │ File system fuzzing: fuzz <category>   │
├─ ─ ─ ─ ─ ─┴─ ─ ─┴─ ─ ─┴─ ─ ─┴─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┤
│   path   - Explore fs structure with path traversal strategies.      │
│   write  - First put/append file, then check for its existence.      │
│   blind  - Read-only tests for existing files like /etc/passwd.      │
├───────────┬─────┬─────┬─────┬────────────────────────────────────────┤
│ df        │  ✓  │  ✓  │     │ Show volume information.               │
│ free      │  ✓  │  ✓  │  ✓  │ Show available memory.                 │
└───────────┴─────┴─────┴─────┴────────────────────────────────────────┘
```


#### Cheatsheets

 This is a mirror from 2017 website that was provided by the [THM Printer 101 Room](https://tryhackme.com/r/room/printerhacking101) uses http so [BEWARE defanged: http://hacking-printers.net/wiki/index.php/Printer_Security_Testing_Cheat_Sheet](hxxp[://]hacking-printers[.]net/wiki/index[.]php/Printer_Security_Testing_Cheat_Sheet]) states *"To systematically check for vulnerabilities in a printing device, first perform a generic network assessment and check for printer-specific web based information leaks using Praeda. Then, use the following cheat sheet to quickly find flaws in printer languages and network protocols."*

| Category                     | Attack               | Protocol                                                  | Testing                                                       |                     |
| ---------------------------- | -------------------- | --------------------------------------------------------- | ------------------------------------------------------------- | ------------------- |
| Denial of service            | Transmission channel | TCP                                                       | `while true; do nc printer 9100; done`                        |                     |
| Document processing          | n/a                  | PS                                                        | PRET commands: disable, hang                                  |                     |
| n/a                          | n/a                  | PJL                                                       | PRET commands: disable, offline                               |                     |
| Physical damage              | n/a                  | PS                                                        | PRET command: destroy                                         |                     |
| n/a                          | n/a                  | PJL                                                       | PRET command: destroy                                         |                     |
| Privilege escalation         | Factory defaults     | SNMP                                                      | `snmpset -v1 -c public printer 1.3.6.1.2.1.43.5.1.1.3.1 i 6`  |                     |
| n/a                          | n/a                  |                                                           | PML                                                           | PRET command: reset |
| n/a                          | n/a                  | PS                                                        | PRET command: reset                                           |                     |
| Accounting bypass            | n/a                  | TCP                                                       | Connect to printer directly, bypassing the print server       |                     |
| n/a                          | n/a                  | IPP                                                       | Check if you can set a username without authentication        |                     |
| n/a                          | n/a                  | PS                                                        | Check if PostScript code is preprocessed on print server      |                     |
| n/a                          | n/a                  | PJL                                                       | PRET command: pagecount                                       |                     |
| Fax and Scanner              | multiple             | Install printer driver and (ab)use fax/scan functionality |                                                               |                     |
| Print job access             | Print job retention  | PS                                                        | PRET command: capture                                         |                     |
| Print job manipulation   n/a | n/a                  | PS                                                        | PRET commands: cross, overlay, replace                        |                     |
| Information disclosure       | Memory access        | PJL                                                       | PRET command: nvram dump                                      |                     |
| File system access      n/a  | n/a                  | PS                                                        | PRET commands: fuzz, ls, get, put, …                          |                     |
| n/a                          | n/a                  | PJL                                                       | PRET commands: fuzz, ls, get, put, …                          |                     |
| Credential disclosure        | n/a                  | PS                                                        | PRET commands: lock, unlock                                   |                     |
| n/a                          | n/a                  | PJL                                                       | PRET commands: lock, unlock                                   |                     |
| Code execution               | Buffer overflows     | PJL                                                       | PRET command: flood                                           |                     |
| n/a                          | n/a                  | LPD                                                       | ./lpdtest.py printer in                                       |                     |
| Firmware updates             | n/a                  | PJL                                                       | Flip a bit, check if the modified firmware is still accepted  |                     |
| Software packages            | multiple  n/a        | n/a                                                       | Obtain an SDK and write your own proof-of-concept application |                     |

## References

[Wikipedia IPP](https://en.wikipedia.org/wiki/Internet_Printing_Protocol)
[BEWARE defanged: http://hacking-printers.net/wiki/index.php/Printer_Security_Testing_Cheat_Sheet](hxxp[://]hacking-printers[.]net/wiki/index[.]php/Printer_Security_Testing_Cheat_Sheet])
[PRET](https://github.com/RUB-NDS/PRET)
[THM Printer 101 Room](https://tryhackme.com/r/room/printerhacking101) 