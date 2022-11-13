# Shellter

[Shellter](https://www.shellterproject.com/) *"Shellter is a dynamic shellcode injection tool, and the first truly dynamic PE infector ever created. It can be used in order to inject shellcode into native Windows applications (currently 32-bit applications only). The shellcode can be something yours or something generated through a framework, such as Metasploit."* Please support with Donatations, Shellter Pro Licences and their Training Course. This Article is provide some basic helpful information and is in no way extensive.

## Installation
On Linux requires Wine
Kali:
```bash
sudo apt install wine
sudo apt install shellter
```
BlackArch:
```bash
```
ParrotOS:
```bash
```

## Basic Usage
Shellter will obfuscates both the payload and payload decoder before injecting into a executable, there are two divergent modes for the injection process. At each stage Shellter provides feedback, utilities and some customisability like steath mode and user passed custom payloads.  

**Auto mode** - let Shellter automate selection of injection location and injection process

**Manual mode** - DIY injections

**Backup** - Shellter create a backup of file before analysis and any alteration.

**PE Target** - pass a `.exe`, Shellter will analyze and alter the execution flow to inject and execute a later provided payload. Analysis will provide compatibility information, before locate injection location.

**Enable Stealth Mode?** - Make the target executable behave as is regularly would.

**Payload (Selection)** - Select from a list of loads or a user provided custom payload

**Regular Payload Options** - Set [[Metasploit]] options for one of the selected [[MSFvenom-Payloads]].

**Verification Stage** - Shellter attempt to inject payload into `.exe` to reach the first instruction of the payload to test actual  applicability of the AV-Evasion executable.

## Tips and Tricks 
From [Shellter](https://www.shellterproject.com/tipstricks/)

-   **Find a few 32-bit standalone legitimate executables** that always work for you and stick with them for as long as they do the job.  
    - However, take in serious consideration what is discussed in this **[article](https://www.shellterproject.com/an-important-tip-for-shellter-usage/)**, thus avoid using executables of popular applications when not needed.  
    - Unless you are using the Steath Mode for a RedTeam job because you want to trick the victim to run a specific backdoored application, there is no reason to use a different executable every time. Just make sure you use a clean one.

-   Before using a legitimate executable, try to scan it using an online multi-AV scanner. Sometimes **AVs do produce false positives**, so it’s good to know that your chosen executable wasn’t detected as something malicious in the first place.

-   **Don’t use packed executables!**  
    If you get a notification that the executable is probably packed, then get another one.

-   **Don’t use Shellter with executables produced by other pentesting tools or frameworks.** These have possibly been flagged already by many AV vendors. Since Shellter actually traces the execution flow of the target application, you also risk to ‘infect’ yourself if you do that.

-   **If you just need to execute your payload during a pentesting job, you don’t need to enable the Stealth mode feature.** This feature is useful during Red Team engagements, since it enables Shellter to maintain the original functionality of the infected application.

-   **If you decide to use the Dynamic Thread Context Keys (DTCK) feature then try to avoid enabling obfuscation for every single step.** This feature enables an extra filtering stage which reduces even more the available injection locations, so it’s better not to increase a lot the size of the code to be injected.  
    - So as a rule of thumb, in this case just choose to obfuscate the IAT handler. If you use command line just add ‘––polyIAT’ and don’t enable any other obfuscation features.

-   **If you want to inject a DLL with a reflective loader, try to keep your DLL as small as possible** and use an executable that has a section, where the code has been traced, that can fit it.  
    - Think before you do!
    -   If you are not sure about how to use Shellter, and what each feature does, then **use the Auto Mode**. It has been put there for this purpose. Use it!

-   **If you are just interested in bypassing the AV and execute your payload,** hence not looking at the Stealth Mode feature, then **various uninstallers dropped by installed programs might be what you need**.  
	- These are generally standalone and small in size, which makes them perfect for generic usage.

-   **If you really want to use the Manual Mode, make sure you understand enough what each feature does.** 
	- Reading the documentation about Shellter is also something you should do first.

-   **If you use the Manual Mode, don’t just trace for a very small number of instructions.** The point and one of the unique features of Shellter is it’s ability to trace down the execution flow so that it doesn’t inject into predictable locations. **Don’t ruin it for yourself. **
	- Usually, 50k instructions should be fine, but as you go deeper in the execution flow the better it gets.  
	- If you think that reaching the amount of instructions that you chose it takes too long, you can always interrupt the tracing stage by pressing CTRL+C and proceed with the rest of the injection process.

- In order to restore the execution flow through the **Stealth Mode option, custom payloads need to terminate by exiting the current thread.**



## References 
[Shellter](https://www.shellterproject.com/tipstricks/)