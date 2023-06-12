# Printer Security Testing Cheat Sheet

To systematically check for vulnerabilities in a printing device, first perform a generic network assessment and check for printer-specific web based information leaks using Praeda. Then, use the following cheat sheet to quickly find flaws in printer languages and network protocols.

Category | Attack | Protocol | Testing
--- | --- | --- | ---
Denial of service    |   Transmission channel     | TCP |        while true; do nc printer 9100; done
Document processing   | n/a  | PS     | PRET commands: disable, hang
  n/a| n/a | PJL         | PRET commands: disable, offline
Physical damage      | n/a   | PS     | PRET command: destroy
  n/a| n/a | PJL        | PRET command: destroy
Privilege escalation |   Factory defaults      |  SNMP | `snmpset -v1 -c public printer 1.3.6.1.2.1.43.5.1.1.3.1 i 6`
  n/a| n/a | | PML      | PRET command: reset
  n/a| n/a | PS     | PRET command: reset
Accounting bypass    | n/a    | TCP |        Connect to printer directly, bypassing the print server
  n/a| n/a | IPP   |  Check if you can set a username without authentication
  n/a| n/a | PS   | Check if PostScript code is preprocessed on print server
  n/a| n/a | PJL  | PRET command: pagecount
Fax and Scanner     | multiple |    Install printer driver and (ab)use fax/scan functionality
Print job access    |    Print job retention     | PS     | PRET command: capture
Print job manipulation   n/a| n/a | PS     | PRET commands: cross, overlay, replace
Information disclosure |  Memory access    | PJL      | PRET command: nvram dump
File system access      n/a| n/a | PS     | PRET commands: fuzz, ls, get, put, …
  n/a| n/a | PJL | PRET commands: fuzz, ls, get, put, …
Credential disclosure  | n/a  | PS     | PRET commands: lock, unlock
  n/a| n/a | PJL    | PRET commands: lock, unlock
Code execution  | Buffer overflows         | PJL | PRET command: flood
  n/a| n/a | LPD  |   ./lpdtest.py printer in
Firmware updates     |  n/a  | PJL |        Flip a bit, check if the modified firmware is still accepted
Software packages       | multiple  n/a| n/a |    Obtain an SDK and write your own proof-of-concept application