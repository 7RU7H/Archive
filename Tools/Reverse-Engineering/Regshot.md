# Regshot

Regshot snapshots the Windows Registry to compare the results between two snapshots. This is useful in [[Dynamic-Malware-Analysis]] in Malware creating methods of persistence or in [[Finding-Windows-Exploits]] as 0days in third party software can be from misconfiguration of the registry hive during installation.


- Compare logs saved as Plain Text or HTML document
- Scan multiple listed directories - if you have custom hives and subsystems
- Set the output path
- 1st Shot - `Shot | Shot and Save ... | Load ...`
- *Do something that modifies the registry hive..*
- `Compare`

## References

