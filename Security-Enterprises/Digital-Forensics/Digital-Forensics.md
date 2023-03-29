
# Digital Forensics

This is a hub and overview page for Digital Forensics related topics. Although Digital Forensics and Incident Response are often combined and share skill sets, DF is the investigative and analytical side of the pairing where experts identify forensic artifacts or evidence of human activity in digital devices. This expertise has application in criminal and defensive investigations. [Digital Forensics is the forensic examination of anything wherever computational data exists.](https://www.youtube.com/watch?v=ehxJZAGUaxY) The author consider the conceptual seperation of [[Security-Enterprises/Incident-Response]] and Digital Forensics a etymological imperative; simply Digital Forensics does not need Incident Response, but Incident Response requires techniques from Digial Forensics to evaluate data. Corporate definitions often coinside with the concatenating of tasks and title to save money.


#### Concepts

- Artifacts - Data as evidence that indicate a definable activity performed on a system
- Evidence Preservation - Any forensics analysis contaminates the evidence therefore:
	- Evidence is first collected and and write protected, and copied to preserve the integrity of evidence and preventing data corruption
- Chain of Custody - Secure custody of evidence at all parts of the linear chain of event of pre and post DF of evidence 
- Order of Volatility - Digital evidence is often volatile - if not captured maybe lost -  preserve RAM
- Timeline Creation - Event timelines are required for efficient and accurate analysis

Dirty Wordlists
- Notetaking while investigating to avoid:
	- Recursive rabbit hole when dealing with [[Persistence]] mechanisms regardless of OS. 
	- Missing Cleanup

#### Tools

[[Kape]]
[[Autopsy]]
[[Volatility]]
[[Redline]]
[[Velociraptor]]

#### OS Specific Cheatsheets:

[[Linux-Forensics]]
[[Windows-Forensics]]


## References

[THM DFIR Room](https://tryhackme.com/room/introductoryroomdfirmodule)
[SANs DFIR - What is Digital Forensics & Incident Response (DFIR)?](https://www.youtube.com/watch?v=ehxJZAGUaxY)