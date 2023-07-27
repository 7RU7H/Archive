# Windows Hardening

This article will split first part general understanding about Windows Hardening specifics aswell general important practices, then a second half which will be powershell commands.

## Defence Points

-   Identity & access management.
	-  As a principle, always follow the **Principle of Least Privilege**, which states that (Per [CISA](https://www.cisa.gov/uscert/bsi/articles/knowledge/principles/least-privilege#:~:text=The%20Principle%20of%20Least%20Privilege%20states%20cthat%20a%20subject%20should,should%20not%20have%20that%20right)) “_a subject should be given only those privileges needed for it to complete its task. If a subject does not need an access right, the subject should not have that right_”.
	- Password Policy; Lockout Policy,
	- [[Windows-User-Account-Control]], [[Bypassing-Windows-User-Account-Control]]
-   Network management
	- Disable unused devices `Control panel > System and Security Setting > System > Device Manager`
	- Protecting Local Domain Name System (DNS)
		- `C:\Windows\System32\Drivers\etc\hosts` - Check for malicious insertion, change Write permissions
	- Disable SMBv1 
		- `Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol`
	- Prevent [Blue Keep](https://en.wikipedia.org/wiki/BlueKeep) , Disable Remote Access
		- `settings > Remote Desktop`
	- Clear Arp cache
		- `arp -d`
	- [[Firewalls]] and [[Evading-Firewalls]]; `wf.msc`
	- [[Windows-Networking]], [[Windows-Networking-Commands]]
-   Application management.
	- [[Windows-Services]], `services.msc`
	- Microsoft Store only applications: `Setting > Select Apps and Features` and then select `The Microsoft Store only`
	- AppLocker - add rule to block file based on its publisher name
	- MS Edge
		- Protect the Browser through Microsoft SmartScreen  `Settings > Windows Security > App and Browser Control > Reputation-based Protection > SmartScreen for Microsoft Edge`
-   Storage & Compute
	- Data Encryption with BitLocker: 
		- `Start > Control Panel > System and Security > BitLocker Drive Encryption`
	- Windows Secure Boot
		- `msinfo32 > BIOS Mode and Secure Boot`
	- Backup data - `Settings > Update and Security > Backup` 
-   Registry Management 
	- `regedit`
-  Patch Management
	- `Click Start > Settings > Update & Security > Window Updates.`
-  Event Handling
	- [[Sysmon-Events]], [[Windows-Events-To-Monitor]]
	- Event viewer; `eventvwr`, default location `C:\WINDOWS\system32\config\folder`
- Telemetry
	- `diagtrack.dll` and `%ProgramData%\Microsoft\Diagnosis` is sent every 15 minutes
	- `Services Console > Connected User Experiences
- Microsoft Office
	- Context dependent - Banks rely on Macros 
	- Read: [Microsoft Attack Surface Reduction Rules](https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/attack-surface-reduction-rules-reference?view=o365-worldwide)

#### Sandboxing Application
This may not be a provide a substitute for a serious SOC sandbox, **BEWARE** running known or unknown unsafe software:
`Click Start > Search for 'Windows Features' and turn it on > Select Sandbox > Click OK to restart`

## References
[THM Room Windows Hardening](https://tryhackme.com/room/microsoftwindowshardening)
[CISA](https://www.cisa.gov/uscert/bsi/articles/knowledge/principles/least-privilege#:~:text=The%20Principle%20of%20Least%20Privilege%20states%20cthat%20a%20subject%20should,should%20not%20have%20that%20right)

## Appendix 

#### Microsoft Office Batch Script 
The [THM Room Windows Hardening](https://tryhackme.com/room/microsoftwindowshardening) included an awesome batch script for hardening Microsoft Office:

```batch
:: Office Hardening Script
:: Based on best practices
::#######################################################################
::
::#######################################################################
:: References
::#######################################################################
:: https://gist.github.com/ceramic-skate0/2270c9d54a64a63a309b8bf62c6e01ab
:: Windows Defender References
:: ASR Rules https://www.darkoperator.com/blog/2017/11/11/windows-defender-exploit-guard-asr-rules-for-office
:: ASR and Exploit Guard https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-exploit-guard/attack-surface-reduction-exploit-guard
:: ASR Rules https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/attack-surface-reduction
:: Easy methods to test rules https://demo.wd.microsoft.com/?ocid=cx-wddocs-testground
:: Resource on the rules and associated event IDs https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/event-views
:: Defender sandboxing https://cloudblogs.microsoft.com/microsoftsecure/2018/10/26/windows-defender-antivirus-can-now-run-in-a-sandbox/
:: Defender exploit protection https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-exploit-guard/customize-exploit-protection
:: Application Guard https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-guard/install-wd-app-guard 
:: Defender cmdline https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/command-line-arguments-windows-defender-antivirus
::
:: General hardening references
:: LSA Protection https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn408187(v=ws.11)?redirectedfrom=MSDN
::
:: Microsoft Office References: 
:: Disable DDE https://gist.github.com/wdormann/732bb88d9b5dd5a66c9f1e1498f31a1b
:: Disable macros https://decentsecurity.com/block-office-macros/
::
:: Enable and configure Windows Defender and advanced settings
::#######################################################################
::
:: Reset Defender to defaults. Commented out but available for reference
::"%programfiles%"\"Windows Defender"\MpCmdRun.exe -RestoreDefaults
:: https://docs.microsoft.com/en-us/windows/client-management/mdm/policy-csp-defender#defender-submitsamplesconsent
:: https://docs.microsoft.com/en-us/powershell/module/defender/set-mppreference?view=win10-ps
::
:: Start Defender Service
sc start WinDefend
::Enable Windows Defender sandboxing
setx /M MP_FORCE_USE_SANDBOX 1
:: Update signatures
"%ProgramFiles%"\"Windows Defender"\MpCmdRun.exe -SignatureUpdate
:: Enable Defender signatures for Potentially Unwanted Applications (PUA)
powershell.exe Set-MpPreference -PUAProtection enable
:: Enable Defender periodic scanning
reg add "HKCU\SOFTWARE\Microsoft\Windows Defender" /v PassiveMode /t REG_DWORD /d 2 /f
:: Enable Cloud functionality of Windows Defender
powershell.exe Set-MpPreference -MAPSReporting Advanced
powershell.exe Set-MpPreference -SubmitSamplesConsent 0
::
:: Enable early launch antimalware driver for scan of boot-start drivers
:: 3 is the default which allows good, unknown and 'bad but critical'. Recommend trying 1 for 'good and unknown' or 8 which is 'good only'
reg add "HKCU\SYSTEM\CurrentControlSet\Policies\EarlyLaunch" /v DriverLoadPolicy /t REG_DWORD /d 3 /f
::
:: Enable ASR rules in Win10 1903 ExploitGuard to mitigate Office malspam
:: Blocks Office childprocs, Office proc injection, Office win32 api calls & executable content creation
:: Note these only work when Defender is your primary AV
::
:: Block Office Child Process Creation 
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EFC-AADC-AD5F3C50688A -AttackSurfaceReductionRules_Actions Enabled
:: Block Process Injection
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84 -AttackSurfaceReductionRules_Actions Enabled
:: Block Win32 API calls in macros
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B -AttackSurfaceReductionRules_Actions Enabled
:: Block Office from creating executables
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 3B576869-A4EC-4529-8536-B80A7769E899 -AttackSurfaceReductionRules_Actions Enabled
:: Block execution of potentially obfuscated scripts
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 5BEB7EFE-FD9A-4556-801D-275E5FFC04CC -AttackSurfaceReductionRules_Actions Enabled
:: Block executable content from email client and webmail
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550 -AttackSurfaceReductionRules_Actions Enabled
:: Block JavaScript or VBScript from launching downloaded executable content
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids D3E037E1-3EB8-44C8-A917-57927947596D -AttackSurfaceReductionRules_Actions Enabled
:: Block lsass cred theft
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2 -AttackSurfaceReductionRules_Actions Enabled
:: Block untrusted and unsigned processes that run from USB
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4 -AttackSurfaceReductionRules_Actions Enabled
:: Block Adobe Reader from creating child processes
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c -AttackSurfaceReductionRules_Actions Enabled
:: Block persistence through WMI event subscription
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids e6db77e5-3df2-4cf1-b95a-636979351e5b -AttackSurfaceReductionRules_Actions Enabled
:: Block process creations originating from PSExec and WMI commands
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids d1e49aac-8f56-4280-b9ba-993a6d77406c -AttackSurfaceReductionRules_Actions Enabled


::
::#######################################################################
:: Enable and Configure Microsoft Office Security Settings
::#######################################################################
::
:: Harden all version of MS Office itself against common malspam attacks
:: Disables Macros, enables ProtectedView
:: ---------------------
reg add "HKCU\Software\Policies\Microsoft\Office\12.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\12.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\14.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\14.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Outlook\Security" /v markinternalasunsafe /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Word\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Excel\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\PowerPoint\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Outlook\Security" /v markinternalasunsafe /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Word\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Excel\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\PowerPoint\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\19.0\Outlook\Security" /v markinternalasunsafe /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Office\19.0\Word\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\19.0\Excel\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\19.0\PowerPoint\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\19.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\19.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
::
:: Harden all version of MS Office itself against DDE malspam attacks
:: Disables Macros, enables ProtectedView
:: ---------------------
::
reg add "HKCU\Software\Microsoft\Office\14.0\Word\Options" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\14.0\Word\Options\WordMail" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\15.0\Word\Options" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\15.0\Word\Options\WordMail" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options\WordMail" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
::

:: Windows Update Settings
:: Prevent Delivery Optimization from downloading Updates from other computers across the internet
:: 1 will restrict to LAN only. 0 will disable the feature entirely
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\" /v DODownloadMode /t REG_DWORD /d 1 /f

```


