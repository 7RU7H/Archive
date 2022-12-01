# Command Injection

## The power of \*nix ";" or Windows "&"

```
url/ENDPOINT?PARAMETRE=;ls+-la+/' # Linux Host
PARAMETRE=&type  # Windows Host
```

%2F is url encoded forward slash. & and && to make additional commands to the payload that simply an shell one liner injected into a website.  

## Types 

1. Blind - no direct output from the application when testing payloads
2. Verboase - direct output from the aqpplication when testing payloads

## Remediation 

1. Vulnerable functions interacting with OS replaced
2. Sanitise Input - Specify format or types of data a user can submit
3. Filtering Input - Stripping out bad characters

## References
[portswigger](https://portswigger.net/web-security/os-command-injection)
[TryHackMe Room](https://tryhackme.com/room/oscommandinjection)