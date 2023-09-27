# Command Injection

When a web application makes a call to a function that interacts with the server's console directly.

## The power of \*nix ";" or Windows "&" and...

```powershell
# Linux and Windows Host
&
&&
| 
||
# Linux
;
\n # or 0x0a
# $ or ` to perform inline execution of an injected command
` # injected command is `
$( # injected command is )


url/ENDPOINT?PARAMETRE=;ls+-la+/ 
PARAMETRE=&type  
```

`%2F` is URL encoded forward slash. `&` and `&&` to make additional commands to the payload that simply a one liner injected into a website.  

Is Dos or PowerShell executing the command injection payload?
```powershell
(dir 2>&1 *`|echo CMD);&<# rem #>echo PowerShell
```

## Types 

1. Blind - no direct output from the application when testing payloads
2. Verbose - direct output from the application when testing payloads

Make the remote server sleep for blind PoC  
```bash
sleep 5
```

## Remediation 

1. Vulnerable functions interacting with OS replaced
2. Sanitise and Filtering Input - [Portswigger](https://portswigger.net/web-security/os-command-injection):
	- Validating against a whitelist of permitted values.
	- Validating that the input is a number.
	- Validating that the input contains only alphanumeric characters, no other syntax or whitespace characters.

## References

[Portswigger](https://portswigger.net/web-security/os-command-injection)
[TryHackMe Room](https://tryhackme.com/room/oscommandinjection)
[OWASP](https://owasp.org/www-community/attacks/Command_Injection)
[THM OWASP Top 10 2021 Room](https://tryhackme.com/room/owasptop102021)