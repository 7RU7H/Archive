
[Sigma](https://github.com/SigmaHQ/sigma) *"Sigma is a generic and open signature format that allows you to describe relevant log events in a straightforward manner. The rule format is very flexible, easy to write and applicable to any type of log file. The main purpose of this project is to provide a structured form in which researchers or analysts can describe their once developed detection methods and make them shareable with others...Sigma is for log files what [Snort](https://www.snort.org/) is for network traffic and [YARA](https://github.com/VirusTotal/yara) is for files."*

Both [[Snort]] and [[Yara]] are also present in th Archive.

- Create detection methods and signature alongside IOCs and Yara rules
- Write [[SIEM-Solutions]] search that avoid vendor lock-in
- Share signatures
- Write Custom Detection rules


`Sigma Format` for genric signature descriptions -> `Sigma Converter` applies predefined and custom field mapping -> To third parties like [[Tools/Splunk]] search, [[Elastic]] search queries and other [[SIEM-Solutions]] queries.

Sigma allows for standardization format to share analysis, IOCs, [[Yara]] rules, which may not be avaliable from the in-house collected data.

## Sigma Rule Syntax

[Status types](https://tryhackme.com/room/adventofcyber4#):
-   _Stable_: The rule may be used in production environments and dashboards.
-   _Test_: Trials are being done to the rule and could require fine-tuning.
-   _Experimental_: The rule is very generic and is being tested. It could lead to false results, be noisy, and identify exciting events.
-   _Deprecated_: The rule has been replaced and would no longer yield accurate results. 
-   _Unsupported_: The rule is not usable in its current state (unique correlation log, homemade fields).

[Predefined Tags list](https://github.com/SigmaHQ/sigma/wiki/Tags)

```yaml
title: # Rule name
id: # Global unique id - UUID format
status: # stable, test, experimental, deprecated, unsupported
description: # Help others understand briefly what this rule is for
logsource: # Describes log data
  product: windows 
  category: firewall # category of product of the log source
  service: security # subset of logs of the product!
  definition: # describes logsource and its applied configurations 
detection: # the rule, key value pairs with operators and keywords
  selection: # search identifiers
    EventID: # search identifier value 
      - 4750 # search's list value indexed with - $list_value  
    Image|endswith:
      - '\svchost.exe'
   CommandLine|contains|all:
      - cmd
      - /c
  condition: selection 
falsepostives: # ideally a list of known or expected false-positives
	- unknown
level: low # value of severity for the security team should take action over on alert: information -> low -> medium -> high -> critical 
tags:
   - attack.persistence # Points to the MITRE tactic
```

For EventIDs and Sysmon - see [[Sysmon-Events]], [[Windows-Events-To-Monitor]], also this awesome site [Ultimatewindowssecurity](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/default.aspx?i=j) , which has a encyclopedia of Windows audit, Sharepoint audit, SQL point audit, Exchangfe audit, Sysmon all listed and `[Ctrl + F]` to success

[[MITRE-ATT&CK]] official site: [Link](https://attack.mitre.org/)

## Tooling

[Sigmac is deprecated to be replace by pySigma](https://github.com/SigmaHQ/sigma/blob/master/tools/README.md)
[pySigma](https://github.com/SigmaHQ/pySigma) - more stable python library than Sigmac

[Unicoder.io](https://uncoder.io/) - is an open-source web Sigma converter for numerous SIEM and EDR platforms.

## References

[THM AoC4](https://tryhackme.com/room/adventofcyber4#)
[Predefined Tags list](https://github.com/SigmaHQ/sigma/wiki/Tags)
[Mitre Attack](https://attack.mitre.org/)
[Sigmac](https://github.com/SigmaHQ/sigma/blob/master/tools/README.md)
[pySigma](https://github.com/SigmaHQ/pySigma) 
[Unicoder.io](https://uncoder.io/)
[Ultimatewindowssecurity](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/default.aspx?i=j)