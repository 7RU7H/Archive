
# Secure Coding


## Input Validation

Insufficient input validation is a security concern for web applications. [OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html) states that secure input validation: *"is performed to ensure only properly formed data is entering the workflow in an information system, preventing malformed data from persisting in the database and triggering malfunction of various downstream components."*

- Input validation should happen as early as possible in the data flow, preferably as soon as the data is received from the external party
- Data from all potentially untrusted sources should be subject to input validation, including not only Internet-facing web clients but also backend feeds over extranets, from [suppliers, partners, vendors or regulators](https://badcyber.com/several-polish-banks-hacked-information-stolen-by-unknown-attackers/), each of which may be compromised on their own 
- Input Validation should not be used as the _primary_ method of preventing [XSS](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html), [SQL Injection](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html) and other attacks

It should occur at the:
- Syntactic level
	- Enforce correct syntax of structure fields
- Semantic level
	- Enforce correct of value in specific business context 

Implemented:
- Data type validators
- JSON and XML validation of formattings
- Min and Max Range checks - length
- Array of allowed values to check parametre content
- [[Regular-Expressions]] for any other structured data covering the whole input string and not using "any character" wildcard (such as  `.` or `\s`)


#### File uploads

- Secure directory usage
- File Size Validation
- File Extension Validation
- File Content Validation
- Mime Type Validation
- Content Type Validation
- Request type Validation 
- File renaming
- Malware Scanning


## References

[THM AoC 4](https://tryhackme.com/room/adventofcyber4)
[OWASP Input Validation Cheetsheat](https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html)