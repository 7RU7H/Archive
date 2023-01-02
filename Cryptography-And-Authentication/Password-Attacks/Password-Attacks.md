# Password Attacks

## Quick Links

For just [OpenWall wiki's sample hashes can be found here](https://openwall.info/wiki/john/sample-hashes) and similarly [Hashcat's example hashes](https://hashcat.net/wiki/doku.php?id=example_hashes). These are good for rough useful visual guide and naming format for both tools usage. For basic cryptography see [[Cryptography101]] and [[De-Or-En-Cryption]] for applications you may need

## Introduction 

We can use a [Dictionary Attack](https://en.wikipedia.org/wiki/Dictionary_attack) using a wordlist or we can [Brute Force](https://en.wikipedia.org/wiki/Brute-force_attack) all possible character combination. If hashes are leaked misconfiguration or another exploit or from a [Pass-the-hash-Attack](https://en.wikipedia.org/wiki/Pass_the_hash), the attacker can then perform [Password Cracking](https://en.wikipedia.org/wiki/Password_cracking). 

## Wordlists

Kali, Parrot and Arch wordlists generally found  in `/usr/share/wordlists/`. These can be built, mutated and generated with various tools covered with links to cheatsheet in this article. For growing list of great wordlists see [[Wordlist-Library]] contain familiar lists like: [assetnote](https://wordlists.assetnote.io/) or [seclists](https://github.com/danielmiessler/SecLists)


## Default passwords

[[Default-Passwords-Data-Recovery-Table]] or by going to [the source](https://datarecovery.com/rd/default-passwords/)
https://cirt.net/passwords
https://default-password.info/

## Password Attacks Against Network Sevices
1. Noisy attack

1. Dangerous, can damage service for regular users
1. Time consuming - exponentiation of hopeful `< x^passwords_to_try`
	1. Worst case its `$total_usernames^$total_passwords` 
	1. Even slower if as protocol even restrict threaded interaction
		1.   SMB
		2.   RDP

## Cracking Password Hashes

Most system store password authentication locally in to for of cryptographic hashes. Linux stores hashes in `/etc/shadow` implementing shadow-utils, see [slashroot](https://www.slashroot.in/how-are-passwords-stored-linux-understanding-hashing-shadow-utils). Whereas for Windows systems are storeed in Security Accounts Manager(SAM); from NT 4.0 SP3 SYSKEY feature partial encrypts the SAM file. Previous and including Windows 2003 LM  and NTLM hashes are stored rather than just NTLM(**UNSALTED**) disabling LM from Vista onwards. Some hashes have [Salts](https://en.wikipedia.org/wiki/Salt_(cryptography)) to improve password storage security . Identification is the first stage to cracking as there are a vast number of types and strengths. Weak passwords are bad m'kay to see list of dumped passwords head over to [skullsecurity](https://wiki.skullsecurity.org/index.php?title=Passwords).

## Tools
[Raw tools for cracking link here](https://inventory.raw.pm/tools.html#title-tools-cracking)

Tool | Description | Local Cheatsheet | Links
--- | --- | --- | ---
Cewl | crawl a website and extract strings or keywords  | [[Cewl-Cheatsheet]] |
Crunch | offline wordlist creation | [[Crunch-Cheatsheet]] |
Cupp | create custom wordlists | |
Mentalist | gui wordlist generation | |
Haiti | hash identifier | |
Hashid | Hash identifier | | [psypanda](https://psypanda.github.io/hashID/)
John | hash cracker |  [[John-The-Ripper-Cheatsheet]]
Hashcat | hash cracker | [[Hashcat-Cheatsheet]]
Hydra |  De-facto Login Bruteforcer | [[Hydra-Cheatsheet]] | [kalitools](https://www.kali.org/tools/hydra/) [github](https://github.com/vanhauser-thc/thc-hydra)
Brutespray | Brute-Forcing from Nmap output also with default creds | [[Brutespray-Cheatsheet]] |[kalitools](https://github.com/x90skysn3k/brutespray) [github](https://www.kali.org/tools/brutespray/)
Crowbar | Brute force the RDP service on a single host with a specified username and wordlist, using 1 thread. | [[Crowbar-CheatSheat]] | [kalitools](https://www.kali.org/tools/crowbar/) [github](https://github.com/galkan/crowbar)
Medusa | Medusa is a speedy, parallel, and modular, login brute-forcer. |  |[kalitools](https://www.kali.org/tools/medusa/) [github](https://github.com/jmk-foofus/medusa)
pth-winexe | Path the Hash tool | [[PtH-winexe-Cheatsheet]] |  

# Wordlist generation tools
This section contains some breif description of tools and links to cheatsheets.

#### Mentalist
[Mentalist](https://github.com/sc0tfree/mentalist) is a GUI generator, very easy to use, but with some issues on some distros.

#### Cewl
[Cewl](https://github.com/digininja/CeWL), spiders and scraps a site for words to build a list. The scrapped list's application in password cracking is minimal at best and generally would not meet password-enforcement requirements. For full cheatsheet [[Cewl-Cheatsheet]]
```
cewl -w list.txt -d 5 -m 5 <url> # --depth --morethanorequalto <wordsize>
```

#### Others
At some point I will check these
https://github.com/tp7309/TTPassGen
https://github.com/therodri2/username_generator.git

# Wordlist fetchers
https://github.com/BlackArch/wordlistctl
https://github.com/initstring/lyricpass 

#### pwngen
[pwngen](https://github.com/toxydose/pnwgen ) is a phhone number generator

#### John the Ripper
For full cheatsheet [[John-The-Ripper-Cheatsheet]]
```bash
john --list=formats | grep ?
john --rules=RULENAME
john --show --format=? hash # Show the cracked hash, after its been cracked
john --list=rules
# ~/.john/john.pot # contain current sessions cracked hashes
```

#### Wordlistctl
python3 /opt/wordlistctl/wordlistctl.py


## Hashcracking

[OpenWall wiki's sample hashes can be found here](https://openwall.info/wiki/john/sample-hashes) and similarly [Hashcat's example hashes](https://hashcat.net/wiki/doku.php?id=example_hashes)These are good for rough useful visual guide and naming format for both tools usage. [Hashkiller is a identifing service it has a self signed cert, but offensive security recommends it so ask yourself first](https://hashkiller.co.uk/) 

#### Train of thought and methodology guide
1. This all about trial and error
1. Hardware configuration matters
2. Pick good wordlists
3.  Combinations:
        Capital leter at the start
        Symbol at the end
        all small

####  Concepts with some John-The-Ripper-Custom-Rules
Wordlist expansion with JOHN!
```bash
john --wordlist=/wordlist.txt --rules=rulename --stdout >> newlist.txt


# Border mutation 
#       commonly used combinations of digits and special symbols 
#               can be added at the end or at the beginning, or both

[List.Rules:borderMut5]
cAz"[0-9!@#$%^&*()_+][0-9!@#$%^&*()_+][0-9!@#$%^&*()_+][0-9!@#$%^&*()_+][0-9!@#$%^&*()_+]"

[List.Rules:borderMut3]
cAz"[0-9!@#$%^&*()_+][0-9!@#$%^&*()_+][0-9!@#$%^&*()_+]"

For "CaPiTaLiSeD LeTtEr ThEn LoWeRcAsE" --rules=NT

    Freak mutation - letters are replaced with similarly looking special symbols
    Case mutation - the program checks all variations of uppercase/lowercase letters for any character
   
#  Order mutation
#       character order is reversed

[List.Rules:reversed]
r
```

**Mutation typology**
Mutation | Description
--- | ---
Repetition mutation | the same group of characters are repeated several times
Vowels mutation | vowels are omitted or capitalized
Strip mutation | one or several characters are removed
Swap mutation |  some characters are swapped and change places
Duplicate mutation | some characters are duplicated
Delimiter mutation | delimiters are added between characters

## Password Spray Attacks

Password spraying is an effective technique used to identify valid credentials, used also for discovring weak passwords against authenication of various [[Networks/Network-Protocols]]. Common weak passwords often follow pattern and format like: `[season][currentyear]`

- **Tools**

[RDPassSpray](https://github.com/xFreed0m/RDPassSpray)
[[Brutespray-Cheatsheet]]
[[Crackmapexec-Cheatsheet]]
[SprayingToolkit](https://github.com/byt3bl33d3r/SprayingToolkit) (atomizer.py)
[MailSniper](https://github.com/dafthack/MailSniper)

## Pass the Hash
Discovered in 1997, is a technique of collecting the NTLM/LM hashes for use in authenicating as a user with hash. For full cheatsheets: [[PtH-winexe-Cheatsheet]];




## References

[TryHackMe Room](https://tryhackme.com/room/passwordattacks)
[Wiki Dictionary Attack](https://en.wikipedia.org/wiki/Dictionary_attack) 
[Wiki Brute Force](https://en.wikipedia.org/wiki/Brute-force)
[Wiki Password Cracking](https://en.wikipedia.org/wiki/Password_cracking)
[Wiki Pass-the-hash-Attack](https://en.wikipedia.org/wiki/Pass_the_hash)
[Data Recovery Default Passwords](https://datarecovery.com/rd/default-passwords/)
[Seclists](https://github.com/danielmiessler/SecLists)
[assetnote](https://wordlists.assetnote.io/)
[Raw tools for cracking link here](https://inventory.raw.pm/tools.html#title-tools-cracking)
[Salts](https://en.wikipedia.org/wiki/Salt_(cryptography))
[Slashroot Article](https://www.slashroot.in/how-are-passwords-stored-linux-understanding-hashing-shadow-utils)
[skullsecurity](https://wiki.skullsecurity.org/index.php?title=Passwords)