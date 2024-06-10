# Windows  Persistance

For general overview of persistance that OS neutral: [[Persistence]], but for AD related see [[Active-Directory-Persistence]].

[persistence-info.github.io](https://github.com/persistence-info/persistence-info.github.io) is *"The repository tries to gather an information about Windows persistence mechanisms to make the protection/detection more efficient. Most of the information is well known for years, being actively used within various scenarios."*

Consider reviewing and supporting [pentestlab.blog](https://pentestlab.blog/methodologies/red-teaming/persistence/) for this table that I have not had time to read here:

|==No==|==Technique==|==MITRE ID==|==Administrator Rights==|
|---|---|---|---|
|1|[Registry Run Keys](https://pentestlab.blog/2019/10/01/persistence-registry-run-keys/)||No|
|2|[Service Registry Permission Weakness](https://pentestlab.blog/2020/01/22/persistence-modify-existing-service/)||No|
|3|[Scheduled Tasks](https://pentestlab.blog/2019/11/04/persistence-scheduled-tasks/)||No|
|4|[Shortcut Modification](https://pentestlab.blog/2019/10/08/persistence-shortcut-modification/)||No|
|5|[BITS Jobs](https://pentestlab.blog/2019/10/30/persistence-bits-jobs/)||No|
|6|[PowerShell Profile](https://pentestlab.blog/2019/11/05/persistence-powershell-profile/)||No|
|7|[Screensaver](https://pentestlab.blog/2019/10/09/persistence-screensaver/)||No|
|8|[Component Object Model Hijacking](https://pentestlab.blog/2020/05/20/persistence-com-hijacking/)||No|
|9|[Change Default File Association](https://pentestlab.blog/2020/01/06/persistence-change-default-file-association/)||No|
|10|[Office Application Startup](https://pentestlab.blog/2019/12/11/persistence-office-application-startup/)||No|
|11|[Visual Studio Code Extensions](https://pentestlab.blog/2024/03/04/persistence-visual-studio-code-extensions/)||No|
|12|[Explorer](https://pentestlab.blog/2024/03/05/persistence-explorer/)||No|
|13|[WinLogon Helper DLL](https://pentestlab.blog/2020/01/14/persistence-winlogon-helper-dll/)||Yes|
|14|[RID Hijacking](https://pentestlab.blog/2020/02/12/persistence-rid-hijacking/)||Yes|
|15|[Time Providers](https://pentestlab.blog/2019/10/22/persistence-time-providers/)||Yes|
|16|[Image File Execution Options Injection](https://pentestlab.blog/2020/01/13/persistence-image-file-execution-options-injection/)||Yes|
|17|[Application Shimming](https://pentestlab.blog/2019/12/16/persistence-application-shimming/)||Yes|
|18|[DLL Search Order Hijacking](https://pentestlab.blog/2020/03/04/persistence-dll-hijacking/)||Yes|
|19|[AppInit DLLs](https://pentestlab.blog/2020/01/07/persistence-appinit-dlls/)||Yes|
|20|[Netsh Helper DLL](https://pentestlab.blog/2019/10/29/persistence-netsh-helper-dll/)||Yes|
|21|[Accessibility Features](https://pentestlab.blog/2019/11/13/persistence-accessibility-features/)||Yes|
|22|[Port Monitors](https://pentestlab.blog/2019/10/28/persistence-port-monitors/)||Yes|
|23|[Security Support Provider](https://pentestlab.blog/2019/10/21/persistence-security-support-provider/)||Yes|
|24|[AMSI](https://pentestlab.blog/2021/05/17/persistence-amsi/)||Yes|
|25|[WMI Event Subscription](https://pentestlab.blog/2020/01/21/persistence-wmi-event-subscription/)||Yes|
|26|[Print Spooler](https://pentestlab.blog/2021/08/02/universal-privilege-escalation-and-persistence-printer/)||Yes|
|27|[Certificates](https://pentestlab.blog/2021/09/13/account-persistence-certificates/)||Yes|
|28|[Notepad++](https://pentestlab.blog/2022/02/14/persistence-notepad-plugins/)||Yes|
|29|[Event Log](https://pentestlab.blog/2024/01/08/persistence-event-log/)||Yes|
|30|[Event Log Online Help](https://pentestlab.blog/2023/03/07/persistence-event-log-online-help/)||Yes|
|31|[Context Menu](https://pentestlab.blog/2023/03/13/persistence-context-menu/)||Yes|
|32|[Service Control Manager](https://pentestlab.blog/2023/03/20/persistence-service-control-manager/)||Yes|
|33|[Windows Telemetry](https://pentestlab.blog/2023/11/06/persistence-windows-telemetry/)||Yes|
|34|[Scheduled Task Tampering](https://pentestlab.blog/2023/11/20/persistence-scheduled-task-tampering/)||Yes|
|35|[Disk Clean Up](https://pentestlab.blog/2024/01/29/persistence-disk-clean-up/)||Yes|
|36|[Windows Setup Script](https://pentestlab.blog/2024/02/05/persistence-windows-setup-script/)||Yes|
|37|[Waitfor](https://pentestlab.blog/2020/02/04/persistence-waitfor/)||Yes|
|38|[New Service](https://pentestlab.blog/2019/10/07/persistence-new-service/)||Yes|
|39|[Modifying Existing Service](https://pentestlab.blog/2020/01/22/persistence-modify-existing-service/)||Yes|
|40|[DLL Proxy Loading](https://pentestlab.blog/2024/04/03/persistence-dll-proxy-loading/)||No|
## Contents

[[Windows-Persistence-Tampering-with-Unprivileged-Accounts]]
[[Windows-Persistence-Backdooring-Files]]
[[Windows-Persistence-Abusing-Services]]
[[Windows-Persistence-Abusing-Scheduled-Tasks]]
[[Windows-Persistence-Logon-Triggered]]
[[Windows-Persistence-RDP]]
[[Windows-Persistence-Implant-Existing-Services]]


## References

[THM Windows Persistence Room](https://tryhackme.com/room/windowslocalpersistence)
[Hexacorn - Windows Persistence](https://www.hexacorn.com/blog/category/autostart-persistence/)[PayloadsAllTheThings - Windows Persistence](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Persistence.md)   
[Oddvar Moe - Windows Persistence Through RunOnceEx](https://oddvar.moe/2018/03/21/persistence-using-runonceex-hidden-from-autoruns-exe/)  
[PowerUpSQL](https://www.netspi.com/blog/technical/network-penetration-testing/establishing-registry-persistence-via-sql-server-powerupsql/)
[persistence-info.github.io](https://github.com/persistence-info/persistence-info.github.io)
[pentestlab.blog](https://pentestlab.blog/methodologies/red-teaming/persistence/) 