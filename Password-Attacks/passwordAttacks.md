# Password Attacks

## (De|En)cryption
Gpg
```bash
gpg -e filetoencrypt

killall gpg-agent

gpg -d filetodecrypt
```
Openssl
```bash
openssl genrsa -aes256 -out private.key 8912
openssl rsa -in private.key -pubout -out public.key
openssl rsautl -encrypt -pubin -inkey public.key -in plaintext.txt -out encrypted.txt
openssl rsautl -decrypt -inkey private.key -in encrypted.txt -out plaintext.txt
```
## Wordlists
Kali, Parrot and Arch wordlists are found  in `/usr/share/wordlist`
[Seclists](https://github.com/danielmiessler/SecLists)
[raw](https://inventory.raw.pm/tools.html#title-tools-cracking)

## Default passwords ##
https://cirt.net/passwords
https://default-password.info/
https://datarecovery.com/rd/default-passwords/

## Weak passwords ##
https://wiki.skullsecurity.org/index.php?title=Passwords 

## Tools ##
TOOL | Description
--- | ---
cewl | crawl a website and extract strings or keywords
crunch | offline wordlist creation !! careful with disk memory usage exponentation
cupp | create custom wordlists
mentalist | gui wordlist generation
Haiti | hash identifier
John | hash cracker
Hashcat | hash ccrackers

# Wordlist generators
https://github.com/sc0tfree/mentalist
https://github.com/digininja/CeWL
https://github.com/tp7309/TTPassGen
https://github.com/therodri2/username_generator.git

# Wordlist fetchers
https://github.com/BlackArch/wordlistctl
https://github.com/initstring/lyricpass 
https://github.com/toxydose/pnwgen # Phone number generator

## Useful commands ##

#### JOHN
```bash
john --list=formats | grep ?
john --rules=RULENAME
john --show --format=? hash # Show the cracked hash, after its been cracked
john --list=rules
# ~/.john/john.pot # contain current sessions cracked hashes
```

#### Wordlistctl
python3 /opt/wordlistctl/wordlistctl.py

#### Cewl
```
cewl -w list.txt -d 5 -m 5 <url> # --depth --morethanorequalto <wordsize>
```

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

## References

[TryHackMe Room](https://tryhackme.com/room/passwordattacks)