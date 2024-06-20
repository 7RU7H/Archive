# Digital Forensics

This is a hub and overview page for Digital Forensics related topics. Although Digital Forensics and Incident Response are often combined and share skill sets, DF is the investigative and analytical side of the pairing. A field experts where apply forensic analysis and techniques to digital artefacts of human activity in computational devices. This expertise has application in criminal and defensive investigations. [Digital Forensics is the forensic examination of anything wherever computational data exists.](https://www.youtube.com/watch?v=ehxJZAGUaxY) The author consider the conceptual separation of [[Incident-Response]] and Digital Forensics a etymological imperative; simply Digital Forensics does not need Incident Response, but Incident Response requires techniques from Digital Forensics to evaluate data. Corporate definitions often coincide with the concatenating of tasks and title to save money.


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

Image Acquisition types from [THM AoC 2023](https://tryhackme.com/room/adventofcyber2023): 
- Static acquisition: A **bit-by-bit image** of the disk is created while the device is turned off.
- Live acquisition: A **bit-by-bit image** of the disk is created while the device is turned on.
- Logical acquisition: A **select list of files** is copied from the seized device.
- Sparse acquisition: Select **fragments of unallocated data** are copied. The unallocated areas of the disk might contain deleted data; however, this approach is limited compared to static and live acquisition because it doesn’t cover the whole disk.

####  [Defcon 21 - Forensic Fails - Shift + Delete Won't Help You Here](https://www.youtube.com/watch?v=NG9Cg_vBKOg)

Inspired initially by the [Defcon 21 - Forensic Fails - Shift + Delete Won't Help You Here](https://www.youtube.com/watch?v=NG9Cg_vBKOg), Eric Robi & Michael Perklin whom discuss:
- Approaches thinking Forensically 
	- Indicators of evidence
	- Dealing with problems easy to miss or convoluted
	- Understanding humans involved
	- Understanding the environment and how to be observant with asking questions 
- How and why people fail to maliciously and or criminally interact with computer systems 

These are my key takeaways from this talk:
- Everything is subject to the digital [Locard's exchange principle (Wikipedia)](https://en.wikipedia.org/wiki/Locard%27s_exchange_principle)
	- What traces are left from downloading something - [Locard's exchange principle (Wikipedia)](https://en.wikipedia.org/wiki/Locard%27s_exchange_principle)?
	- What traces are left from uploading something - [Locard's exchange principle (Wikipedia)](https://en.wikipedia.org/wiki/Locard%27s_exchange_principle)?
- Are you basing your conclusion on actual evidence?
	- Evidence connected to the person not a machine
- Are there and where the Deleted files on drives?
	- Check unallocated space 
	- Journal Files 
	- Link files - shows open files
	- BagMRU - [[Windows-Registry]] Key  shows user folder activity
	- Jump lists - shows open files on Windows 7+
	- IE/Edge - records a lot of information like: accessed files!
- Data destruction leaves patterns and traces of its use and is indicative of:
	- capability - to what level?
	- [(Wikipedia) mens rea](https://en.wikipedia.org/wiki/Mens_rea) - do to what?
- Use File system analysis tools to ask questions about obfuscation of file types and discrepancies? - Good tools we make these discrepancies more obvious, but use your brain
	- What roughly a file size of a specific type should be?
	- What is the entropy of the file expected to be?
	- Original Metadata from specific file type not stripped or modified  
- Logs are good, what is timeline of events and the connections between them? 
	- Audit Logs for [[Database-Security]]?
	- [[Windows-Logging]]
	- [[Linux-Logging]]
- Who *evidentially* is the person that you are investigating?
	- The contents of a desktop directory is indicative of person that uses that machine. 
	- Sometimes people do not even try to hide there activities
- What services were used? 
	- Know the services used by user better than they do:
		- RDP maps your local printer to a remote machine, unless change the settings of RDP
- Recovery of old deleted Outlook emails is easy:
	1. `hexedit` the `$file.pst` and change the 7th to 13th bytes to `00`
	2. Use a Outlook repair tool on `$file.pst`

#### Tools

[[KAPE]]
[[Autopsy]]
[[Volatility3]]
[[Redline]]
[[Velociraptor]]
[[FTK-Imager]]


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
[THM AoC 2023](https://tryhackme.com/room/adventofcyber2023)
[(Wikipedia) mens rea](https://en.wikipedia.org/wiki/Mens_rea)
[Defcon 21 - Forensic Fails - Shift + Delete Won't Help You Here](https://www.youtube.com/watch?v=NG9Cg_vBKOg)
[Locard's exchange principle (Wikipedia)](https://en.wikipedia.org/wiki/Locard%27s_exchange_principle)