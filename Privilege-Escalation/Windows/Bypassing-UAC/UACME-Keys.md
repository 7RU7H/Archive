# UACME Keys
This is just a straight rip from github

1.  Author: Leo Davidson
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\sysprep\sysprep.exe
    -   Component(s): cryptbase.dll
    -   Implementation: ucmStandardAutoElevation
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 8.1 (9600)
        -   How: sysprep.exe hardened LoadFrom manifest elements
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
2.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\sysprep\sysprep.exe
    -   Component(s): ShCore.dll
    -   Implementation: ucmStandardAutoElevation
    -   Works from: Windows 8.1 (9600)
    -   Fixed in: Windows 10 TP (> 9600)
        -   How: Side effect of ShCore.dll moving to \KnownDlls
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
3.  Author: Leo Davidson derivative by WinNT/Pitou
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\oobe\setupsqm.exe
    -   Component(s): WdsCore.dll
    -   Implementation: ucmStandardAutoElevation
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 TH2 (10558)
        -   How: Side effect of OOBE redesign
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
4.  Author: Jon Ericson, WinNT/Gootkit, mzH
    -   Type: AppCompat
    -   Method: RedirectEXE Shim
    -   Target(s): \system32\cliconfg.exe
    -   Component(s): -
    -   Implementation: ucmShimRedirectEXE
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 TP (> 9600)
        -   How: Sdbinst.exe autoelevation removed, KB3045645/KB3048097 for rest Windows versions
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
5.  Author: WinNT/Simda
    -   Type: Elevated COM interface
    -   Method: ISecurityEditor
    -   Target(s): HKLM registry keys
    -   Component(s): -
    -   Implementation: ucmSimdaTurnOffUac
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 TH1 (10147)
        -   How: ISecurityEditor interface method changed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
6.  Author: Win32/Carberp
    -   Type: Dll Hijack
    -   Method: WUSA
    -   Target(s): \ehome\mcx2prov.exe, \system32\migwiz\migwiz.exe
    -   Component(s): WdsCore.dll, CryptBase.dll, CryptSP.dll
    -   Implementation: ucmWusaMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 TH1 (10147)
        -   How: WUSA /extract option removed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
7.  Author: Win32/Carberp derivative
    -   Type: Dll Hijack
    -   Method: WUSA
    -   Target(s): \system32\cliconfg.exe
    -   Component(s): ntwdblib.dll
    -   Implementation: ucmWusaMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 TH1 (10147)
        -   How: WUSA /extract option removed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
8.  Author: Leo Davidson derivative by Win32/Tilon
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\sysprep\sysprep.exe
    -   Component(s): Actionqueue.dll
    -   Implementation: ucmStandardAutoElevation
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 8.1 (9600)
        -   How: sysprep.exe hardened LoadFrom manifest
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
9.  Author: Leo Davidson, WinNT/Simda, Win32/Carberp derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation, ISecurityEditor, WUSA
    -   Target(s): IFEO registry keys, \system32\cliconfg.exe
    -   Component(s): Attacker defined Application Verifier Dll
    -   Implementation: ucmAvrfMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 TH1 (10147)
        -   How: WUSA /extract option removed, ISecurityEditor interface method changed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
10.  Author: WinNT/Pitou, Win32/Carberp derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation, WUSA
    -   Target(s): \system32\{New}or{Existing}\{autoelevated}.exe, e.g. winsat.exe
    -   Component(s): Attacker defined dll, e.g. PowProf.dll, DevObj.dll
    -   Implementation: ucmWinSATMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 TH2 (10548)
        -   How: AppInfo elevated application path control hardening
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
11.  Author: Jon Ericson, WinNT/Gootkit, mzH
    -   Type: AppCompat
    -   Method: Shim Memory Patch
    -   Target(s): \system32\iscsicli.exe
    -   Component(s): Attacker prepared shellcode
    -   Implementation: ucmShimPatch
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 8.1 (9600)
        -   How: Sdbinst.exe autoelevation removed, KB3045645/KB3048097 for rest Windows versions
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
12.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\sysprep\sysprep.exe
    -   Component(s): dbgcore.dll
    -   Implementation: ucmStandardAutoElevation
    -   Works from: Windows 10 TH1 (10240)
    -   Fixed in: Windows 10 TH2 (10565)
        -   How: sysprep.exe manifest updated
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
13.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\mmc.exe EventVwr.msc
    -   Component(s): elsext.dll
    -   Implementation: ucmMMCMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS1 (14316)
        -   How: Missing dependency removed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
14.  Author: Leo Davidson, WinNT/Sirefef derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system\credwiz.exe, \system32\wbem\oobe.exe
    -   Component(s): netutils.dll
    -   Implementation: ucmSirefefMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 TH2 (10548)
        -   How: AppInfo elevated application path control hardening
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
15.  Author: Leo Davidson, Win32/Addrop, Metasploit derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\cliconfg.exe
    -   Component(s): ntwdblib.dll
    -   Implementation: ucmGenericAutoelevation
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS1 (14316)
        -   How: Cliconfg.exe autoelevation removed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
16.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\GWX\GWXUXWorker.exe, \system32\inetsrv\inetmgr.exe
    -   Component(s): SLC.dll
    -   Implementation: ucmGWX
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS1 (14316)
        -   How: AppInfo elevated application path control and inetmgr executable hardening
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
17.  Author: Leo Davidson derivative
    -   Type: Dll Hijack (Import forwarding)
    -   Method: IFileOperation
    -   Target(s): \system32\sysprep\sysprep.exe
    -   Component(s): unbcl.dll
    -   Implementation: ucmStandardAutoElevation2
    -   Works from: Windows 8.1 (9600)
    -   Fixed in: Windows 10 RS1 (14371)
        -   How: sysprep.exe manifest updated
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
18.  Author: Leo Davidson derivative
    -   Type: Dll Hijack (Manifest)
    -   Method: IFileOperation
    -   Target(s): \system32\taskhost.exe, \system32\tzsync.exe (any ms exe without manifest)
    -   Component(s): Attacker defined
    -   Implementation: ucmAutoElevateManifest
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS1 (14371)
        -   How: Manifest parsing logic reviewed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
19.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\inetsrv\inetmgr.exe
    -   Component(s): MsCoree.dll
    -   Implementation: ucmInetMgrMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS1 (14376)
        -   How: inetmgr.exe executable manifest hardening, MitigationPolicy->ProcessImageLoadPolicy->PreferSystem32Images
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
20.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\mmc.exe, Rsop.msc
    -   Component(s): WbemComn.dll
    -   Implementation: ucmMMCMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS3 (16232)
        -   How: Target requires wbemcomn.dll to be signed by MS
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
21.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation, SxS DotLocal
    -   Target(s): \system32\sysprep\sysprep.exe
    -   Component(s): comctl32.dll
    -   Implementation: ucmSXSMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS3 (16232)
        -   How: MitigationPolicy->ProcessImageLoadPolicy->PreferSystem32Images
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
22.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation, SxS DotLocal
    -   Target(s): \system32\consent.exe
    -   Component(s): comctl32.dll
    -   Implementation: ucmSXSMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.5.0
23.  Author: Leo Davidson derivative
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\pkgmgr.exe
    -   Component(s): DismCore.dll
    -   Implementation: ucmDismMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.5.1
24.  Author: BreakingMalware
    -   Type: Shell API
    -   Method: Environment variables expansion
    -   Target(s): \system32\CompMgmtLauncher.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmCometMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS2 (15031)
        -   How: CompMgmtLauncher.exe autoelevation removed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
25.  Author: Enigma0x3
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\EventVwr.exe, \system32\CompMgmtLauncher.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmHijackShellCommandMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS2 (15031)
        -   How: EventVwr.exe redesigned, CompMgmtLauncher.exe autoelevation removed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
26.  Author: Enigma0x3
    -   Type: Race Condition
    -   Method: File overwrite
    -   Target(s): %temp%\GUID\dismhost.exe
    -   Component(s): LogProvider.dll
    -   Implementation: ucmDiskCleanupRaceCondition
    -   Works from: Windows 10 TH1 (10240)
    -   AlwaysNotify compatible
    -   Fixed in: Windows 10 RS2 (15031)
        -   How: File security permissions altered
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
27.  Author: ExpLife
    -   Type: Elevated COM interface
    -   Method: IARPUninstallStringLauncher
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmUninstallLauncherMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS3 (16199)
        -   How: UninstallStringLauncher interface removed from COMAutoApprovalList
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
28.  Author: Exploit/Sandworm
    -   Type: Whitelisted component
    -   Method: InfDefaultInstall
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmSandwormMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 8.1 (9600)
        -   How: InfDefaultInstall.exe removed from g_lpAutoApproveEXEList (MS14-060)
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
29.  Author: Enigma0x3
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\sdclt.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmAppPathMethod
    -   Works from: Windows 10 TH1 (10240)
    -   Fixed in: Windows 10 RS3 (16215)
        -   How: Shell API update
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
30.  Author: Leo Davidson derivative, lhc645
    -   Type: Dll Hijack
    -   Method: WOW64 logger
    -   Target(s): \syswow64\{any elevated exe, e.g wusa.exe}
    -   Component(s): wow64log.dll
    -   Implementation: ucmWow64LoggerMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.0
31.  Author: Enigma0x3
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\sdclt.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmSdcltIsolatedCommandMethod
    -   Works from: Windows 10 TH1 (10240)
    -   Fixed in: Windows 10 RS4 (17025)
        -   How: Shell API / Windows components update
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
32.  Author: xi-tauw
    -   Type: Dll Hijack
    -   Method: UIPI bypass with uiAccess application
    -   Target(s): \Program Files\Windows Media Player\osk.exe, \system32\EventVwr.exe, \system32\mmc.exe
    -   Component(s): duser.dll, osksupport.dll
    -   Implementation: ucmUiAccessMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.1
33.  Author: winscripting.blog
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\fodhelper.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmShellRegModMethod
    -   Works from: Windows 10 TH1 (10240)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.2
34.  Author: James Forshaw
    -   Type: Shell API
    -   Method: Environment variables expansion
    -   Target(s): \system32\svchost.exe via \system32\schtasks.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmDiskCleanupEnvironmentVariable
    -   Works from: Windows 8.1 (9600)
    -   AlwaysNotify compatible
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.2
35.  Author: CIA & James Forshaw
    -   Type: Impersonation
    -   Method: Token Manipulations
    -   Target(s): Autoelevated applications
    -   Component(s): Attacker defined
    -   Implementation: ucmTokenModification
    -   Works from: Windows 7 (7600)
    -   AlwaysNotify compatible, see note
    -   Fixed in: Windows 10 RS5 (17686)
        -   How: ntoskrnl.exe->SeTokenCanImpersonate additional access token check added
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
36.  Author: Thomas Vanhoutte aka SandboxEscaper
    -   Type: Race condition
    -   Method: NTFS reparse point & Dll Hijack
    -   Target(s): wusa.exe, pkgmgr.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmJunctionMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.4
37.  Author: Ernesto Fernandez, Thomas Vanhoutte
    -   Type: Dll Hijack
    -   Method: SxS DotLocal, NTFS reparse point
    -   Target(s): \system32\dccw.exe
    -   Component(s): GdiPlus.dll
    -   Implementation: ucmSXSDccwMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.5
38.  Author: Clement Rouault
    -   Type: Whitelisted component
    -   Method: APPINFO command line spoofing
    -   Target(s): \system32\mmc.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmHakrilMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.6
39.  Author: Stefan Kanthak
    -   Type: Dll Hijack
    -   Method: .NET Code Profiler
    -   Target(s): \system32\mmc.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmCorProfilerMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.7
40.  Author: Ruben Boonen
    -   Type: COM Handler Hijack
    -   Method: Registry key manipulation
    -   Target(s): \system32\mmc.exe, \system32\recdisc.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmCOMHandlersMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 19H1 (18362)
        -   How: Side effect of Windows changes
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
41.  Author: Oddvar Moe
    -   Type: Elevated COM interface
    -   Method: ICMLuaUtil
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmCMLuaUtilShellExecMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.7.9
42.  Author: BreakingMalware and Enigma0x3
    -   Type: Elevated COM interface
    -   Method: IFwCplLua
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmFwCplLuaMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS4 (17134)
        -   How: Shell API update
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
43.  Author: Oddvar Moe derivative
    -   Type: Elevated COM interface
    -   Method: IColorDataProxy, ICMLuaUtil
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmDccwCOMMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v2.8.3
44.  Author: bytecode77
    -   Type: Shell API
    -   Method: Environment variables expansion
    -   Target(s): Multiple auto-elevated processes
    -   Component(s): Various per target
    -   Implementation: ucmVolatileEnvMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS3 (16299)
        -   How: Current user system directory variables ignored during process creation
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
45.  Author: bytecode77
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\slui.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmSluiHijackMethod
    -   Works from: Windows 8.1 (9600)
    -   Fixed in: Windows 10 20H1 (19041)
        -   How: Side effect of Windows changes
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
46.  Author: Anonymous
    -   Type: Race Condition
    -   Method: Registry key manipulation
    -   Target(s): \system32\BitlockerWizardElev.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmBitlockerRCMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS4 (>16299)
        -   How: Shell API update
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
47.  Author: clavoillotte & 3gstudent
    -   Type: COM Handler Hijack
    -   Method: Registry key manipulation
    -   Target(s): \system32\mmc.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmCOMHandlersMethod2
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 19H1 (18362)
        -   How: Side effect of Windows changes
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
48.  Author: deroko
    -   Type: Elevated COM interface
    -   Method: ISPPLUAObject
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmSPPLUAObjectMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS5 (17763)
        -   How: ISPPLUAObject interface method changed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
49.  Author: RinN
    -   Type: Elevated COM interface
    -   Method: ICreateNewLink
    -   Target(s): \system32\TpmInit.exe
    -   Component(s): WbemComn.dll
    -   Implementation: ucmCreateNewLinkMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS1 (14393)
        -   How: Side effect of consent.exe COMAutoApprovalList introduction
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
50.  Author: Anonymous
    -   Type: Elevated COM interface
    -   Method: IDateTimeStateWrite, ISPPLUAObject
    -   Target(s): w32time service
    -   Component(s): w32time.dll
    -   Implementation: ucmDateTimeStateWriterMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS5 (17763)
        -   How: Side effect of ISPPLUAObject interface change
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
51.  Author: bytecode77 derivative
    -   Type: Elevated COM interface
    -   Method: IAccessibilityCplAdmin
    -   Target(s): \system32\rstrui.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmAcCplAdminMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS4 (17134)
        -   How: Shell API update
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
52.  Author: David Wells
    -   Type: Whitelisted component
    -   Method: AipNormalizePath parsing abuse
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmDirectoryMockMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.0.4
53.  Author: Emeric Nasi
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\sdclt.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmShellRegModMethod
    -   Works from: Windows 10 (14393)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.1.3
54.  Author: egre55
    -   Type: Dll Hijack
    -   Method: Dll path search abuse
    -   Target(s): \syswow64\SystemPropertiesAdvanced.exe and other SystemProperties*.exe
    -   Component(s): \AppData\Local\Microsoft\WindowsApps\srrstr.dll
    -   Implementation: ucmEgre55Method
    -   Works from: Windows 10 (14393)
    -   Fixed in: Windows 10 19H1 (18362)
        -   How: SysDm.cpl!_CreateSystemRestorePage has been updated for secured load library call
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
55.  Author: James Forshaw
    -   Type: GUI Hack
    -   Method: UIPI bypass with token modification
    -   Target(s): \system32\osk.exe, \system32\msconfig.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmTokenModUIAccessMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.1.5
56.  Author: Hashim Jawad
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\WSReset.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmShellRegModMethod2
    -   Works from: Windows 10 (17134)
    -   Fixed in: Windows 11 (22000)
        -   How: Windows components redesign
    -   Code status: removed starting from v3.5.7 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
57.  Author: Leo Davidson derivative by Win32/Gapz
    -   Type: Dll Hijack
    -   Method: IFileOperation
    -   Target(s): \system32\sysprep\sysprep.exe
    -   Component(s): unattend.dll
    -   Implementation: ucmStandardAutoElevation
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 8.1 (9600)
        -   How: sysprep.exe hardened LoadFrom manifest elements
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
58.  Author: RinN
    -   Type: Elevated COM interface
    -   Method: IEditionUpgradeManager
    -   Target(s): \system32\clipup.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmEditionUpgradeManagerMethod
    -   Works from: Windows 10 (14393)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.2.0
59.  Author: James Forshaw
    -   Type: AppInfo ALPC
    -   Method: RAiLaunchAdminProcess and DebugObject
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmDebugObjectMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.2.3
60.  Author: Enigma0x3 derivative by WinNT/Glupteba
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\CompMgmtLauncher.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmGluptebaMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: Windows 10 RS2 (15063)
        -   How: CompMgmtLauncher.exe autoelevation removed
    -   Code status: removed starting from v3.5.0 ![tractor](https://github.githubassets.com/images/icons/emoji/unicode/1f69c.png)
61.  Author: Enigma0x3/bytecode77 derivative by Nassim Asrir
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\slui.exe, \system32\changepk.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmShellRegModMethod
    -   Works from: Windows 10 (14393)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.2.5
62.  Author: winscripting.blog
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\computerdefaults.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmShellRegModMethod
    -   Works from: Windows 10 RS4 (17134)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.2.6
63.  Author: Arush Agarampur
    -   Type: Dll Hijack
    -   Method: ISecurityEditor
    -   Target(s): Native Image Cache elements
    -   Component(s): Attacker defined
    -   Implementation: ucmNICPoisonMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.2.7
64.  Author: Arush Agarampur
    -   Type: Elevated COM interface
    -   Method: IIEAxiAdminInstaller, IIEAxiInstaller2, IFileOperation
    -   Target(s): IE add-on install cache
    -   Component(s): Attacker defined
    -   Implementation: ucmIeAddOnInstallMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.1
65.  Author: Arush Agarampur
    -   Type: Elevated COM interface
    -   Method: IWscAdmin
    -   Target(s): Shell Protocol Hijack
    -   Component(s): Attacker defined
    -   Implementation: ucmWscActionProtocolMethod
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.2
66.  Author: Arush Agarampur
    -   Type: Elevated COM interface
    -   Method: IFwCplLua, Shell Protocol Hijack
    -   Target(s): Shell protocol registry entry and environment variables
    -   Component(s): Attacker defined
    -   Implementation: ucmFwCplLuaMethod2
    -   Works from: Windows 7 (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.3
67.  Author: Arush Agarampur
    -   Type: Shell API
    -   Method: Shell Protocol Hijack
    -   Target(s): \system32\fodhelper.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmMsSettingsProtocolMethod
    -   Works from: Windows 10 TH1 (10240)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.4
68.  Author: Arush Agarampur
    -   Type: Shell API
    -   Method: Shell Protocol Hijack
    -   Target(s): \system32\wsreset.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmMsStoreProtocolMethod
    -   Works from: Windows 10 RS5 (17763)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.5
69.  Author: Arush Agarampur
    -   Type: Shell API
    -   Method: Environment variables expansion, Dll Hijack
    -   Target(s): \system32\taskhostw.exe
    -   Component(s): pcadm.dll
    -   Implementation: ucmPcaMethod
    -   Works from: Windows 7 (7600)
    -   AlwaysNotify compatible
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.6
70.  Author: V3ded
    -   Type: Shell API
    -   Method: Registry key manipulation
    -   Target(s): \system32\fodhelper.exe, \system32\computerdefaults.exe
    -   Component(s): Attacker defined
    -   Implementation: ucmShellRegModMethod3
    -   Works from: Windows 10 (10240)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.7
71.  Author: Arush Agarampur
    -   Type: Dll Hijack
    -   Method: ISecurityEditor
    -   Target(s): Native Image Cache elements
    -   Component(s): Attacker defined
    -   Implementation: ucmNICPoisonMethod2
    -   Works from: Windows 7 RTM (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.8
72.  Author: Emeric Nasi
    -   Type: Dll Hijack
    -   Method: Dll path search abuse
    -   Target(s): \syswow64\msdt.exe, \system32\sdiagnhost.exe
    -   Component(s): BluetoothDiagnosticUtil.dll
    -   Implementation: ucmMsdtMethod
    -   Works from: Windows 10 (10240)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.5.9
73.  Author: orange_8361 and antonioCoco
    -   Type: Shell API
    -   Method: .NET deserialization
    -   Target(s): \system32\mmc.exe EventVwr.msc
    -   Component(s): Attacker defined
    -   Implementation: ucmDotNetSerialMethod
    -   Works from: Windows 7 RTM (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.6.0
74.  Author: zcgonvh
    -   Type: Elevated COM interface
    -   Method: IElevatedFactoryServer
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmVFServerTaskSchedMethod
    -   Works from: Windows 8.1 (9600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.6.1
75.  Author: zcgonvh derivative by Wh04m1001
    -   Type: Elevated COM interface
    -   Method: IDiagnosticProfile
    -   Target(s): Attacker defined
    -   Component(s): Attacker defined
    -   Implementation: ucmVFServerDiagProfileMethod
    -   Works from: Windows 7 RTM (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.6.2
76.  Author: HackerHouse
    -   Type: Dll Hijack
    -   Method: Dll path search abuse, Registry key manipulation
    -   Target(s): \syswow64\iscsicpl.exe
    -   Component(s): iscsiexe.dll
    -   Implementation: ucmIscsiCplMethod
    -   Works from: Windows 7 RTM (7600)
    -   Fixed in: unfixed ![see_no_evil](https://github.githubassets.com/images/icons/emoji/unicode/1f648.png)
        -   How: -
    -   Code status: added in v3.6.3