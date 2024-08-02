# Web Application Authentication Attacks


- Have you tried the Default Credentials?
	- [[Default-Credentials]]
		- [[Default-Passwords-Data-Recovery-Table]]
		- [[Pfsense-Default-Credentials]]
		- [[netbiosX-Default-Credentials]]
		- ...
- Have you use [[OSINT]] on the company to find for Data breaches?
- If in scope can [[OSINT-People]] to start [[Generating-Likely-Passwords]]?
- What of the `What you have` , `What you know`, `What you are` used and if so what combination of the former is used  Authentication?
	- `What you have`  
	- `What you know`
	- `What you are` 
- What mechanisms are used for Authentication?
	- Have you enumerated the Registration Pages and Mechanism?
		- Account availability then leads to enumeration of valid usernames or emails already in use 
		- [HackTricks - Registration Vulnerabilities](https://book.hacktricks.xyz/pentesting-web/registration-vulnerabilities)
	- Have you enumerated the Password reset Pages and Mechanism?
		- Timing can be used to determine valid users as more code is executed on the control of the reset process
		- [HackTricks - Registration Vulnerabilities#password-reset-takeover](https://book.hacktricks.xyz/pentesting-web/registration-vulnerabilities#password-reset-takeover)
- What policies are in use can be enumerated in aid of generating quality wordlists?
	- Can a non-technical user find a way that they would circumvent this to make it easier to remember
- What is the password policy? 
- What potential valid Usernames or Emails?
	- [[Generating-Usernames-And-Emails]]
- Are there Verbose Error messages?
	- These can reveal potential...
		- Formatting of valid usernames or emails
		- Software versions for Databases, Web Servers, APIs, etc.
		- Internal Paths: file Paths, Directory structures that lead to configuration files and secret files
		- User information: 
			- If you can get regular user information what about Administrative?
		- Password Policy 
	- Invalid Login Attempts can be used to blind enumerate valid users
	- [[SQL-Injection]]?
	- [[Path-Traversal]]?
	- [[File-Inclusion]]?
	- Form-Manipulation? - [THM Enumeration Bruteforce Room](https://tryhackme.com/r/room/enumerationbruteforce) States as: *"Tweaking form fields or parameters can trick the application into displaying errors that disclose backend logic or sensitive user information. For example, altering hidden form fields to trigger validation errors might reveal insights into the expected data format or structure."*- But No PortSwigger, HackTricks or PayloadAllTheThings
	- [[Application-Fuzzing]] - send weird inputs to parts of the application to find weak points

## References

[THM Enumeration Bruteforce Room](https://tryhackme.com/r/room/enumerationbruteforce)
[csrc.nist.gov Glossary MFA](https://csrc.nist.gov/glossary/term/multi_factor_authentication)
[HackTricks - Registration Vulnerabilities](https://book.hacktricks.xyz/pentesting-web/registration-vulnerabilities)