# Anti-Malware Scan Interface (AMSI)

[Microsoft:]() *"The Windows Antimalware Scan Interface (AMSI) is a versatile interface standard that allows your applications and services to integrate with any antimalware product that's present on a machine. AMSI provides enhanced malware protection for your end-users and their data, applications, and workloads."*

Anti-Malware Scan Interface is a security feature that will allow any applications or services to integrate into antimalware products. It scan payloads and script before execution inside of the runtime. The AMSI feature is integrated into these components of Windows 10.

-   User Account Control, or UAC (elevation of EXE, COM, MSI, or ActiveX installation)
-   PowerShell (scripts, interactive use, and dynamic code evaluation)
-   Windows Script Host (wscript.exe and cscript.exe)
-   JavaScript and VBScript
-   Office VBA macros

AMSI is instrumented in both System.Management.Automation.dll and within the CLR itself. When inside the CLR, it is assumed that Defender is already being instrumented; this means AMSI will only be called when loaded from memory.

AMSI Architecture
![](amsi7archi.jpg)

The Result structure that stores the scan results
```cpp
//amsi.h
typedef enum AMSI_RESULT {
  // Known good. No detection found, and the result is likely not going to change after a future definition update.
  AMSI_RESULT_CLEAN,
  // No detection found, but the result might change after a future definition update.
  AMSI_RESULT_NOT_DETECTED,
  // Administrator policy blocked this content on this machine (beginning of range).
  // Results within this range are officially blocked by the admin specified policy
  AMSI_RESULT_BLOCKED_BY_ADMIN_START,
  // Administrator policy blocked this content on this machine (end of range).
  // Results within this range are officially blocked by the admin specified policy
  AMSI_RESULT_BLOCKED_BY_ADMIN_END,
  // Detection found. The content is considered malware and should be blocked.
  AMSI_RESULT_DETECTED
} ;
```

[ASMI Result Documentation](https://learn.microsoft.com/en-us/windows/win32/api/amsi/ne-amsi-amsi_result): *"The antimalware provider may return a result between 1 and 32767, inclusive, as an estimated risk level. the larger the result, the riskier it is to continue with the content. These values are provider specific, and may indicate a malware family or ID."*

## Instrumentation

AMSI is implemented in this location: `src/System.Management.Automation/engine/runtime/CompiledScriptBlock.cs`
```csharp
// C# instrument AMSI - can be used by third-parties
var scriptExtent = scriptBlockAst.Extent;    
	if (AmsiUtils.ScanContent(scriptExtent.Text, scriptExtent.File) == AmsiUtils.AmsiNativeMethods.AMSI_RESULT.AMSI_RESULT_DETECTED)    
	{     
		var parseError = new ParseError(scriptExtent, "ScriptContainedMaliciousContent", ParserStrings.ScriptContainedMaliciousContent);     
		throw new ParseException(new[] { parseError });    
	} 
	      
	if (ScriptBlock.CheckSuspiciousContent(scriptBlockAst) != null)    
	{     
		HasSuspiciousContent = true;    
	}

```
-   AMSI Win32 API, [https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-functions](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-functions)
-   AMSI COM Interface, [https://docs.microsoft.com/en-us/windows/win32/api/amsi/nn-amsi-iamsistream](https://docs.microsoft.com/en-us/windows/win32/api/amsi/nn-amsi-iamsistream)
[Information about AMSI integration in third-party products](https://docs.microsoft.com/en-us/windows/win32/amsi/dev-audience](https://docs.microsoft.com/en-us/windows/win32/amsi/dev-audience)





Illustrated workflow below describes the end-to-end flow of AMSI's integration with macro execution within Microsoft Office.
![](integ-js-vba.png)

## References

[Documentation AMSI](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-portal)
[Documentation - How AMSI Helps](https://learn.microsoft.com/en-us/windows/win32/amsi/how-amsi-helps)
[ASMI Result Documentation](https://learn.microsoft.com/en-us/windows/win32/api/amsi/ne-amsi-amsi_result)
[AMSI Documentation](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-portal)
[THM Holo Room](https://tryhackme.com/room/hololive)
[AMSI Win32 API antimalware-scan-interface-functions](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-functions)
[Documentation AMSI COM Interface nn-amsi-iamsistream](https://docs.microsoft.com/en-us/windows/win32/api/amsi/nn-amsi-iamsistream)
[Information about AMSI integration in third-party products](https://docs.microsoft.com/en-us/windows/win32/amsi/dev-audience](https://docs.microsoft.com/en-us/windows/win32/amsi/dev-audience)