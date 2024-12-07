
[Sigma](https://github.com/SigmaHQ/sigma) *"Sigma is a generic and open signature format that allows you to describe relevant log events in a straightforward manner. The rule format is very flexible, easy to write and applicable to any type of log file. The main purpose of this project is to provide a structured form in which researchers or analysts can describe their once developed detection methods and make them shareable with others...Sigma is for log files what [Snort](https://www.snort.org/) is for network traffic and [YARA](https://github.com/VirusTotal/yara) is for files."*

Both [[Snort]] and [[YARA]] are also present in the Archive.

- Create detection methods and signature alongside IoCs and [[YARA]] rules
- Write [[SIEM-Solutions]] search that avoid vendor lock-in
- Share signatures
- Write Custom Detection rules

`Sigma Format` for generic signature descriptions -> `Sigma Converter` applies predefined and custom field mapping -> To third parties like [[Splunk]] search, [[ELK]] search queries and other [[SIEM-Solutions]] queries.

Sigma allows for standardisation format to share analysis, IoCs, [[YARA]] rules, which may not be available from the in-house collected data.

## Sigma Rule Syntax

[[YAML]] file properties: 
- YAML is case-sensitive.
- Files should have the `.yml` extension.
- Spaces are used for indentation and not tabs.
- Comments are attributed using the `#` character.
- Key-value pairs are denoted using the colon `:` character.
- Array elements are denoted using the dash `-` character.

[ID types](https://github.com/SigmaHQ/sigma-specification/blob/main/Sigma_specification.md#rule-identification): 
- derived: The rule was derived from the referred rule or rules, which may remain active.
- obsoletes: The rule obsoletes the referred rule or rules, which aren't used anymore.
- merged: The rule was merged from the referred rules. The rules may be still existing and in use.
- renamed: The rule had previously the referred identifier or identifiers but was renamed for whatever reason, e.g. from a private naming scheme to UUIDs, to resolve collisions etc. It's not expected that a rule with this id exists anymore.
- similar: Use to relate similar rules to each other (e.g. same detection content applied to different log sources, rule that is a modified version of another rule with a different level)

[Status types](https://github.com/SigmaHQ/sigma-specification/blob/main/Sigma_specification.md#rule-identification):
- stable: the rule didn't produce any obvious false positives in multiple environments over a long period of time
- test: the rule doesn't show any obvious false positives on a limited set of test systems
- experimental: a new rule that hasn't been tested outside of lab environments and could lead to many false positives
- deprecated: the rule is to replace or cover another one. The link between both rules is made via the `related` field.
- unsupported: the rule can not be used in its current state (special correlation log, home-made fields...etc.)

[Log types](https://github.com/SigmaHQ/sigma-specification/blob/main/Sigma_specification.md#rule-identification):
- product: Selects all log outputs of a particular product.
- category: Selects the log files written by the selected product. 
- service: Selects only a subset of the logs from the selected product.
- definition: Describes the log source and any applied configurations.

- Transformation modifiers: 
	- These change the values provided into different values and can modify the logical operations between values. They include:
	    - `contains`: The value would be matched anywhere in the field.
	    - `all`: This changes the OR operation of lists into an AND operation. This means that the search conditions has to match all listed values.
	    - `base64`: This looks at values encoded with Base64.
	    - `endswith`: With this modifier, the value is expected to be at the end of the field. For example, this is representative of `*\cmd.exe`.
	    - `startswith`: This modifier will match the value at the beginning of the field. For example, `power*`.
- Type modifiers:
	- These change the type of the value or sometimes even the value itself. Currently, the only usable type modifier is `re`, which is supported by Elasticsearch queries to handle the value as a regular expression.

Level: `Informational -> Low -> Medium -> High -> Critical`

Search-Identifier data structures:
- [Lists](https://github.com/SigmaHQ/sigma-specification/blob/main/Sigma_specification.md#lists) contain strings or maps logically linked with `OR`
- [Maps](https://github.com/SigmaHQ/sigma-specification/blob/main/Sigma_specification.md#maps) - dictionaries of Key-Value pairs

[Predefined Tags list](https://github.com/SigmaHQ/sigma/wiki/Tags):
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
    Image|endswith: # Search identify 'Image', tranformation modifiers: endswith, contains..
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

For Event IDs and Sysmon - see [[Sysmon-Events]], [[Windows-Events-To-Monitor]], also this awesome site [Ultimatewindowssecurity](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/default.aspx?i=j) , which has a encyclopedia of Windows audit, Sharepoint audit, SQL point audit, Exchange audit, Sysmon all listed and `[Ctrl + F]` to success.

[[MITRE-ATT&CK]] official site: [Link](https://attack.mitre.org/)

## Tooling

Be aware the translation from Sigma to other platforms may require further treatment of escaping characters that may not be compatible.

[Sigmac is deprecated to be replace by pySigma](https://github.com/SigmaHQ/sigma/blob/master/tools/README.md)
[pySigma](https://github.com/SigmaHQ/pySigma) - more stable python library than Sigma

[Unicoder.io](https://uncoder.io/) - is an open-source web Sigma converter for numerous [[SIEM-Solutions]] and [[EDR]] platforms.

## References

[THM AoC4](https://tryhackme.com/room/adventofcyber4#)
[Predefined Tags list](https://github.com/SigmaHQ/sigma/wiki/Tags)
[Mitre Attack](https://attack.mitre.org/)
[Sigmac](https://github.com/SigmaHQ/sigma/blob/master/tools/README.md)
[pySigma](https://github.com/SigmaHQ/pySigma) 
[Unicoder.io](https://uncoder.io/)
[Ultimate Windows Security](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/default.aspx?i=j)
[Sigma Specification](https://github.com/SigmaHQ/sigma-specification/blob/main/Sigma_specification.md#rule-identification)