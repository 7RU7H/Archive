# Password Attacks
## Introduction 
We can use a [Dictionary Attack](https://en.wikipedia.org/wiki/Dictionary_attack) using a wordlist or we can [Brute Force](https://en.wikipedia.org/wiki/Brute-force_attack) all possible character combination. If hashes are leaked misconfiguration or another exploit or from a [Pass-the-hash-Attack](https://en.wikipedia.org/wiki/Pass_the_hash), the attacker can then perform [Password Cracking](https://en.wikipedia.org/wiki/Password_cracking). 

## Wordlists
Kali, Parrot and Arch wordlists generally found  in `/usr/share/wordlists/`. These can be built, mutated and generated with various tools covered with links to cheatsheet in this article. For growing list of great wordlists see [[Wordlist-Library]] contain familiar lists like: [assetnote](https://wordlists.assetnote.io/) or [seclists](https://github.com/danielmiessler/SecLists)


## Default passwords
[[Default-Passwords-Data-Recovery-Table]] or by going to [the source](https://datarecovery.com/rd/default-passwords/)
https://cirt.net/passwords
https://default-password.info/


## Weak passwords ##
https://wiki.skullsecurity.org/index.php?title=Passwords 

## Tools ##

[Raw tools for cracking link here](https://inventory.raw.pm/tools.html#title-tools-cracking)

Tool | Description | Local CS
--- | --- | ---
cewl | crawl a website and extract strings or keywords  | [[Cewl-Cheatsheet]]
crunch | offline wordlist creation | [[Crunch-Cheatsheet]]
cupp | create custom wordlists | 
mentalist | gui wordlist generation | 
Haiti | hash identifier | 
John | hash cracker |  [[John-The-Ripper-Cheatsheet]]
Hashcat | hash cracker | [[Hashcat-Cheatsheet]]
Hydra | guess/crack valid login/password pairs | [[Hydra-Cheatsheet]]

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



## Train of thought and methodology guide
1. This all about trial and error
1. Hardware configuration matters
2. Pick good wordlists
3.  Combinations:
        Capital leter at the start
        Symbol at the end
        all small

## Concepts with some John-The-Ripper-Custom-Rules
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

##  Mutation typology
Mutation | Description
--- | ---
Repetition mutation | the same group of characters are repeated several times
Vowels mutation | vowels are omitted or capitalized
Strip mutation | one or several characters are removed
Swap mutation |  some characters are swapped and change places
Duplicate mutation | some characters are duplicated
Delimiter mutation | delimiters are added between characters

## Password Spray Attacks

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