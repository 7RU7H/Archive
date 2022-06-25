# Passive Recon

## Method Generics

OSINT or Passive Information Gathering is continually cyclical and recursive process with goal of obtaining information that clarifies or expands an attack surface. The *passive* part of information gathering denotes a process that *generally*  is without interaction with the target. Use of third party data that interact would have interacted is still considered passive. This information can then be used in active methods of recon, phishing, enumeration through bruteforcing.

Note taking or data management for recursive manual or automated lookup and usage is vital.

## Specialized Search Engines

[ViewDNS.info](https://viewdns.info/) prvoide a reverse IP lookup service.

The [Threat Intelligence Platform](https://threatintelligenceplatform.com/) performs malware checks, port scanning, ssl certificate checks, whois request, mail server checks, DNS configuration checks, reverse IP lookup.

Netcraft's [searchdns](https://searchdns.netcraft.com) view site reports that provides information about the site technology.

## Trial / Open source code 
GitHub, GitLab and SourceForge.

Use gitleaks
```bash
gitleaks                                                                                                                                      
Gitleaks scans code, past or present, for secrets

Usage:
  gitleaks [command]

Available Commands:
  completion  Generate the autocompletion script for the specified shell
  detect      detect secrets in code
  help        Help about any command
  protect     protect secrets in code
  version     display gitleaks version

Flags:
  -c, --config string          config file path
                               order of precedence: 
                               1. --config/-c 
                               2. env var GITLEAKS_CONFIG
                               3. (--source/-s)/.gitleaks.toml
                               If none of the three options are used, then gitleaks will use the default config
      --exit-code int          exit code when leaks have been encountered (default 1)
  -h, --help                   help for gitleaks
  -l, --log-level string       log level (debug, info, warn, error, fatal) (default "info")
      --redact                 redact secrets from logs and stdout
  -f, --report-format string   output format (json, csv, sarif) (default "json")
  -r, --report-path string     report file
  -s, --source string          path to source (default: $PWD) (default ".")
  -v, --verbose                show verbose output from scan

Use "gitleaks [command] --help" for more information about a command.
```

## Security Headers Scanner
[Scan site](https://securityheaders.com/)

## SSL Server Test
[Qualys SSL Labs](https://www.ssllabs.com/ssltest/)

## User information
Use [theHarvester](Recon/Passive-Information-Gathering/theHarvester/theHarvester) for email address harvesting. See [[theHarvester]] for Cheatsheet.

Check [haveibeenpwned](https://haveibeenpwned.com/PwnedWebsites) or [Pastebin](https://pastebin.com), checking them with [haveibeenpwned](https://haveibeenpwned.com/PwnedWebsites) can be used in credential stuffing attacks.

## Social Media Tools
[Social-Searcher](https://www.social-searcher.com/)
[Sherlock](https://github.com/sherlock-project/sherlock)
[Twofi for twitter](https://digi.ninja/projects/twofi.php)
[linkedin2username for linkedin data](https://github.com/initstring/linkedin2username)

[Sometimes on Stackover user leak stuff they should not](https://stackoverflow.com/)

## Frameworks

[OSINT Framework](https://osintframework.com/)
[Maltego](https://www.paterva.com/buy/maltego-clients.php)
[[Recon-ng]]
## References

[THM Room](https://tryhackme.com/room/redteamrecon)