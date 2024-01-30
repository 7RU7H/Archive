# Red Team Weaponization


Weaponisation or Exploitation  is second stage of the [[Varonis-Cyber-Kill-Chain]], [[Unified-Kill-Chain]] and [[Lockhead-Martin-Cyber-Kill-Chain]] with aim to use an generated malicious code to exploit a target machine and gain initial access. For an article containing a listing of how this is done see [[Red-Team-Tooling]]. This article will be a collection template code and explaination as to its use and using the [THM Red Team Weaponisation](https://tryhackme.com/room/weaponization) as inspirational starting point to build this article. I highly recommend the subcription to THM as two virtual machines attacted this room provide a good playground for experimentation with the hassle of making, configuring and host a VM for the same purpose.  

## Delivery

See [[File-Transfers]], [[Windows-File-Transfers]] and [[Data-Exfiltration-Defined]] all containing some basic and advance uses, while exfiltration maybe in the title these methods can be using internally to transfer files potential with [[Port-Redirection-And-Tunnelling]]. But with that stated there is also delivery via:
- Email
- SMS
- Controlling IoT devices
- Physical Taps and Injectors
- Hosting on a Red Team controlled Web Server
- USB
- Malicious Device Cables
- Bring Your Own Device To Work 

## Windows Scripting Host (WSH)

Windows scripting host is a built-in Windows administration tool that runs batch files to automate and manage tasks within the operating system. It is a Windows native engine, cscript.exe (for command-line scripts) and wscript.exe (for UI scripts), which are responsible for executing various Microsoft [Visual Basic Scripts (VBScript)](https://en.wikipedia.org/wiki/VBScript), including `.vbs` and `.vbe`. See [[Useful-Visual-Basic]] for more generalised use of VBS.

## An HTML Application (HTA)

HTML Application (HTA) allows create a downloadable files,  dynamicHTLM pages that contain JScript and VBScript that encapsulates internal how it should displayed and rendered. The exploitation of this mechanicanism is that is native packaging method that contains potential malicious code that can executed.  The THM Room suggests [ActiveX](https://en.wikipedia.org/wiki/ActiveX) , although note that in the last decade was notorious for exploitation and commonly removed or disabled or filtered by Windows Defender APT. See [[Useful-Visual-Basic]] for use case of HTA and [[Useful_JavaScript]] for a basic understanding and list of good [[Vulnerable-Javascript-Functions]] to leverage follow the latter link.

Another way to generate and server malicious HTA is with [[Metasploit]] and the module `exploit/windows/misc/hta_server`

## Visual Basic for Application (VBA)

Visual Basic for Applications is programming language developed by Microsoft implemented for Microsoft applications design for automating tasks of nearly every keyboard and mouse interaction between a user and Microsoft Office applications. This automation is in the form of script-like applications call Macros, which are Microsoft Office applications that contain embedded code that can access the [Windows API](https://en.wikipedia.org/wiki/Windows_API) and low level functionality. Generally this weaponised by the Red Team by either phishing to get a masqurading document or excel file via a human controlled channel and requiring a unsuspecting victim to enable the macro - email to then execute malicious code in the macro. Again see [[Useful-Visual-Basic]].

## Powershell

Powershell is an object-oriented programming language executed from the Dynamic Language Runtime (DLR) in .NET with some exceptions for legacy uses. Although less prevelent in modern Red Teaming as it is more easy to monitor than C sharp usage, it is still very powerful weapon of choice. See [[PowerShell]] and [[Basic_Powershell]] for respective insights and glossary of usage.

## C2

Follow the link to [[Introduction-To-Command-And-Control-Frameworks]]. These framework contain all of the above and [[Useful_Csharp]] method from exploitation to exfiltration and for a listing of C2s see [[C2-Matrix]].


## References
[THM Red Team Weaponisation](https://tryhackme.com/room/weaponization)
[Visual Basic Scripts (VBScript)](https://en.wikipedia.org/wiki/VBScript)
[Windows API](https://en.wikipedia.org/wiki/Windows_API)