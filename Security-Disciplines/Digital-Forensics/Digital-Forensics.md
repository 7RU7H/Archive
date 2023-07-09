
# Digital Forensics

This is a hub and overview page for Digital Forensics related topics. Although Digital Forensics and Incident Response are often combined and share skill sets, DF is the investigative and analytical side of the pairing. A field experts where apply forensic analysis and techniques to digital artefacts of human activity in computational devices. This expertise has application in criminal and defensive investigations. [Digital Forensics is the forensic examination of anything wherever computational data exists.](https://www.youtube.com/watch?v=ehxJZAGUaxY) The author consider the conceptual separation of [[Incident-Response 1]] and Digital Forensics a etymological imperative; simply Digital Forensics does not need Incident Response, but Incident Response requires techniques from Digital Forensics to evaluate data. Corporate definitions often coincide with the concatenating of tasks and title to save money.


#### Concepts

- Artefacts - Data as evidence that indicate a definable activity performed on a system
- Evidence Preservation - Any forensics analysis contaminates the evidence therefore:
	- Evidence is first collected and and write protected, and copied to preserve the integrity of evidence and preventing data corruption
- Chain of Custody - Secure custody of evidence at all parts of the linear chain of event of pre and post DF of evidence 
- Order of Volatility - Digital evidence is often volatile - if not captured maybe lost -  preserve RAM
- Timeline Creation - Event timelines are required for efficient and accurate analysis

Dirty Wordlists
- Note taking while investigating to avoid:
	- Recursive rabbit hole when dealing with [[Persistence]] mechanisms regardless of OS. 
	- Missing Cleanup

#### Tools

[[Kape]]
[[Autopsy]]
[[Volatility]]
[[Redline]]
[[Velociraptor]]
[FTK Imager](https://www.exterro.com/ftk-imager)  is a forensics tool that allows forensic specialists to acquire computer data and perform analysis without affecting the original evidence, preserving its authenticity, integrity, and validity for presentation during a trial in a court of law. It is premium software so will not receive coverage due to legal risks regardless if it is for education. 
- UI Features: 
	- Evidence Tree Pane which displays a hierarchical view of the added evidence sources?
	- File List Pane
		- Corrupted file - 0 file size
		- Obfuscated - conflicting file  extension and header information
		- Deleted files marked with an `X`
	- Viewer Pane to show file contents
- Forensic Features:
	- Detect Encryption


#### OS Specific Cheatsheets:

[[Linux-Forensics]]
[[Windows-Forensics]]

#### Forensics Lab Analyst Role

A Forensics Lab Analyst analyses the artefacts from crime scenes or on occasion the law enforcement agency you work for receives "intelligence reports" about different cases.

Ensure the appropriate acquisition of digital artefacts and evidence for examination at the Forensics Lab, potentially used in litigation.

At each stage and concept discuss are rough guidelines that typically followed each case is different, department have unique protocols, laws differ county/province/state to superstate or country wide.

- Search Warrants

- Minimisation evidence tampering
- Accountability 
- Process for Establishing Chain of Custody - Before, During and After a collection and turnover:
	- Ensure proper documentation of any seized materials as evidence (devices/data).
	- Hash and copy obtained files to maintain the integrity of the original.
	- Do not perform an appropriate shutdown of devices. Pull the power plug from suspect devices instead. This is to avoid data alteration as a proper shutdown may trigger anti-forensic measures.
	- Bag, Seal, and Tag the obtained artefacts before sending them to the Forensics Laboratory
	 - Ensure any artefacts and evidence are complete and the Field Operative and Forensics Lab Analyst verifies inventory.
	 - All Chain of Custody forms must be adequately filled-out

DFIR First Responders should *typically* adhere to the following guidelines if any computation device is at the scene of a crime.
- Taking an image of the RAM.
- Checking for drive encryption.
- Taking an image of the drive(s).
- Use of Write-Blocking devices


Forensics Lab Analyst will use a write-blocking device to mount the suspect drive / forensic 
artefact to prevent accidental tampering.

Phases:
- Pre-search
- Search
- Post-search
- Trial

Challenges faced
- Data tampering, corruption and eradication
- Anti-Forensic measures
- Compromise of artefacts prior to investigation
- Minimisation evidence tampering

## References

[THM DFIR Room](https://tryhackme.com/room/introductoryroomdfirmodule)
[SANs DFIR - What is Digital Forensics & Incident Response (DFIR)?](https://www.youtube.com/watch?v=ehxJZAGUaxY)
[FTK Imager](https://www.exterro.com/ftk-imager)  
[THM Digital Forensics Case B4DM755 Room](https://tryhackme.com/room/caseb4dm755)