# Important PrivEsc Windows Locations 
See [[Windows-Important-Directories]] for more explaination regarding directory tree.

```powershell
C:\Windows\System32\drivers\etc\hosts           # DNS entries
C:\Windows\System32\drivers\etc\networks        # Network Settings
C:\Windows\System32\drivers\config\SAM
\repair\Sam                                     # THESE ARE BOTH BACK SAM files
```

Dot Net Version
```batch
dir C:\Windows\Microsoft.Net\Framework64\
# This directory will contain the version of dot net vX.X.XXXX
```

## Misconfiguration

Application installed in 
```
%LocalAppData%\Packages\
```