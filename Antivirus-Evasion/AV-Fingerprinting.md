# AntiVirus Fingerprinting

## THM Example C\#

```csharp
using System;
using System.Management;

internal class Program
{
    static void Main(string[] args)
    {
        var status = false;
        Console.WriteLine("[+] Antivirus check is running .. ");
        string[] AV_Check = { 
            "MsMpEng.exe", "AdAwareService.exe", "afwServ.exe", "avguard.exe", "AVGSvc.exe", 
            "bdagent.exe", "BullGuardCore.exe", "ekrn.exe", "fshoster32.exe", "GDScan.exe", 
            "avp.exe", "K7CrvSvc.exe", "McAPExe.exe", "NortonSecurity.exe", "PavFnSvr.exe", 
            "SavService.exe", "EnterpriseService.exe", "WRSA.exe", "ZAPrivacyService.exe" 
        };
        var searcher = new ManagementObjectSearcher("select * from win32_process");
        var processList = searcher.Get();
        int i = 0;
        foreach (var process in processList)
        {
            int _index = Array.IndexOf(AV_Check, process["Name"].ToString());
            if (_index > -1)
            {
                Console.WriteLine("--AV Found: {0}", process["Name"].ToString());
                status = true;
            }
            i++;
        }
        if (!status) { Console.WriteLine("--AV software is not found!");  }
    }
}
```


## SharpEDRChecker

[SharpEDRChecker](https://github.com/PwnDexter/SharpEDRChecker)is *"Checks running processes, process metadata, Dlls loaded into your current process and the each DLLs metadata, common install directories, installed services and each service binaries metadata, installed drivers and each drivers metadata, all for the presence of known defensive products such as AV's, EDR's and logging tools."*

New and improved C# Implementation of [Invoke-EDRChecker](https://github.com/PwnDexter/Invoke-EDRChecker). Checks running processes, process metadata, Dlls loaded into your current process and each DLLs metadata, common install directories, installed services and each service binaries metadata, installed drivers and each drivers metadata, all for the presence of known defensive products such as AV's, EDR's and logging tools. Catches hidden EDRs as well via its metadata checks, more info can be found in my blog post [here](https://redteaming.co.uk/2021/03/18/sharpedrchecker/).
