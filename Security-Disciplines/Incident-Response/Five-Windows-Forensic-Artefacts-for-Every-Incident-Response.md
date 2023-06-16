
# Part 1-3: Five Windows Forensic Artefacts for Every Incident Response | Jake Williams

Go take the full course - https://www.antisyphontraining.com/advanced-endpoint-investigations

*"Every month it seems there are seemingly more forensic artefacts documented in Windows. This helps us perform more complete investigations, but it also introduces more complexity. Most of us aren't getting more time to conduct investigations, so we need to prioritise what we analyse (or at least what we analyze first). In this webcast, Jake will cover five forensic artefacts that should be used to kickstart your investigations."*

[https://www.blackhillsinfosec.com/wp-...](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbXJDbjh0eV9PQzI5MFo4MUdDN2NCaW1YYlhTQXxBQ3Jtc0trNGJqR0NjUDdxQmRadHdjX3B4Z0ZrNTE0ZkE4emx1bm9jd2UwWFI3YzZNWms1aEJPT045Y3RseHhha3JWdXJfejQ2RkU3VFpMbExWdkwtWDMzNm1Wc2ZDdk96UW9sY3MyVnJxbDlmN09LODJRbFF5OA&q=https%3A%2F%2Fwww.blackhillsinfosec.com%2Fwp-content%2Fuploads%2F2023%2F02%2FSLIDES_Five-Windows-Forensic-Artifacts-williams.pdf&v=itNowx-w7mk)


[Part 1-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=itNowx-w7mk)
[Part 2-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=TggbtBxz2nQ)
[Part 3-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=UhEvcTT2beE)

There are a lot new forensic artefacts, but no additional time budgeting, therefore prioritisation is then a must.

- The handwork is in the analysis, tools just help gather data.
- Start from what are my outcomes supposed to be.
- Tie what Windows did to when, how and what way the user interacted with the OS to deduce intent

- As artefact density increases, forensic analysts are forced to triage and prioritise the data that will provide the best outcomes for their investigation  
	- To the extent that digital forensics was ever about “answering everything” or “analysing all artefacts” it isn’t anymore  
- We must consider the purpose of performing forensics as providing decision support to stakeholders  
	- As such, the types of decisions they need to make should inform the selection of artefacts analysed

## Filesystem Analysis

- Filesystem analysis allows analysts to understand timestamps and reconstruct patterns of activity  
- Each filesystem has its own nuances for how it handles timestamps and updates to those timestamps  
-  On Windows, the primary filesystem is NTFS and has additional files for analysis of timestamps, including: 
	- $LogFile  
	- USN Journal  
	-  $I30 (directory) files

- MACTimestamps and NTFS $STANDARD_INFORMATION and $FILE_NAME
	- The standard for filesystem timeline analysis is to create MACB timestamp output files  
	- For NTFS, the following rules apply M. Content Modification
		- A. File Access Time  
		- C. Metadata Change Time (e.g. file rename, permissions, etc.)  
		- B. Birth Time (file creation time)  
	- Many filesystems lack the B time to show when a file was created (born) 
	- Each file record on an NTFS volume has multiple copies of the MACB timestamps  
	-  $STANDARD_INFORMATION timestamps are the ones you see in  Explorer (aka “the normal timestamps”)  
	- $FILE_NAME timestamps are populated when the file is created and  almost never modified  
		- Bonus: most files have two $FILE_NAME records, one for the regular file name and one for the 8.3 representation  [https://www.blackhillsinfosec.com/wp-...](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbXJDbjh0eV9PQzI5MFo4MUdDN2NCaW1YYlhTQXxBQ3Jtc0trNGJqR0NjUDdxQmRadHdjX3B4Z0ZrNTE0ZkE4emx1bm9jd2UwWFI3YzZNWms1aEJPT045Y3RseHhha3JWdXJfejQ2RkU3VFpMbExWdkwtWDMzNm1Wc2ZDdk96UW9sY3MyVnJxbDlmN09LODJRbFF5OA&q=https%3A%2F%2Fwww.blackhillsinfosec.com%2Fwp-content%2Fuploads%2F2023%2F02%2FSLIDES_Five-Windows-Forensic-Artifacts-williams.pdf&v=itNowx-w7mk)


[Part 1-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=itNowx-w7mk)
[Part 2-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=TggbtBxz2nQ)
[Part 3-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=UhEvcTT2beE)
	-  Because Windows APIs don’t touch $FILE_NAME timestamps, they can be useful in detecting timestamp manipulation


- The tool MFTECmd (by Eric Zimmerman) parses the NTFS central database, the $MFT  
	- MFT is the Master File Table  
- The MFT is typically parsed into a CSV that is then loaded into another tool, such as Excel or Timeline Explorer

- The Timeline Explorer tool (by Eric Zimmerman) displays timeline CSV files in a more convenient format than Excel (and many other tools)

Installers writing files will have there timestamps copied 


## USN Journal Analysis

- While the MFT does track last access timestamps, as we noted, these are disabled by many operating systems  
	- The USN (Update Sequence Number) Journal provides data showing the operations performed on files  
- This provides more than a simple timestamp when the last operation of a given type (create, access, modify, change metadata) was performed  
	-  The USN Journal also captures significantly more operation types than just MACB  
	-  USN journal data may **include references to operations on deleted files**

- [Mens Rea](https://en.wikipedia.org/wiki/Mens_rea)  do you have presence of mind when committing a crime. Did a potential Insider Threats clean up after itself? You had the presence of mind to clean up an malicious act. 

Why Process USN Journal?
- Some use cases for USN Journal analysis:  
	- Knowledge that a file existed on the system  
	- Knowledge of file deletion (and when)  
	- Identifying that Prefetch files have been deleted (and which ones)  
	- Seeing when a user has overwritten a file prior to deletion (often used in secure delete and anti-forensics)  
	- Locating a staging directory where files were collected prior to being archived, exfiltrated and deleted  
	- Identifying when malware has marked files with the hidden or system attribute to limit visibility in Explorer (and unfortunately, other tools)

Processing the USNJournal
- The MFTECmd application from Eric Zimmerman used for MFT processing also processes data from the USN journal  
	- The file name you need to acquire is $Extend\\$UsnJrnl  
	- The data is in a special stream named $J  
	- **This is hugely problematic - if you copying a file off NTFS the data streams go away!**
	- **Some Forensics Tools do not export the Data Streams**
	- Export the stream named $J
- Point to the $J file with the -f parameter, just like when using the tool to parse an MFT

For the example given the key takeaway is convergence of the operation done by Windows and the what, how and when a user acted. 
- File operation RenameNewName implies drag-and-drop creation 
	- Create a new folder and then renamed it
- It is Recent File - GUI not CLI 

## Prefetch Analysis

Prefetch files are not going to exist on Windows Server investigations!

- Some Windows systems log prefetch files, intended to aid in optimally moving drive heads to read files  
	- The principle is that files needed early in execution by an application won’t change substantially in future executions  
- Prefetch files are not enabled on Windows servers and often are not enabled on workstations when Windows detects an SSD during installation  
- Subsequent change to an SSD doesn’t disable Prefetch  
- Prefetch files are located in C:\\windows\\Prefetch and have a .PF extension  
	- One file is created per {appName, path, command line} tuple

- The peCmd tool from Eric Zimmerman is a tool that can parse all known versions of prefetch files
	- Many prefetch parsers cannot handle compressed prefetch files (Win8+)  
- Unlike many other prefetch parsers, peCmd can process an entire directory of prefetch files simultaneously  
	- Most standalone parsers operate on a single file at a time  
- The peCmd tool can also generate a timeline of Prefetch activity  
	- This is useful in understanding the larger context of an investigation, especially when combined with filesystem timeline data

- Opening files from removable media 
	- A file in the open from highest directory on Volume `\Volume{$id}\Filename.ext `
	- `VOLUME{0000000000000000-abcde123}\PRODUCT - OVERVIEW .DOCX`
	- Snapshot is taken 10 seconds into execution

## Event Log Analysis

*This is best of Event Log Analysis* plus see [[]]

-  There are no shortage of tools to process .evtx logs  
	- Including the native Windows Event Viewer - it is also horrible, but still a tool. 
-  The data you see in the Event Viewer is a combination of the data stored in the event logs and maps to label the data.
- When analysing event logs on different systems from where they were generated, you may need to build your own maps to translate data elements appropriately.

- The EvtxECmd (by Eric Zimmerman) can extract Event Logs to be analyzed in a CSV  
- EvtxECmd features:  
	- Include or exclude specific event IDs  
	- Provide custom mappings for event logs  
	- Only extract data from specific date and time ranges  
	- Deduplicate entries from Volume Shadow Copies  
	- Build a histogram of event IDs (EvtxECmd calls this “metrics”)


## Registry Analysis


## References


[SLIDES_Five-Windows-Forensic-Artifacts-williams.pdf](https://www.blackhillsinfosec.com/wp-content/uploads/2023/02/SLIDES_Five-Windows-Forensic-Artifacts-williams.pdf)
[Part 1-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=itNowx-w7mk)
[Part 2-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=TggbtBxz2nQ)
[Part 3-Five Windows Forensic Artifacts for Every Incident Response | Jake Williams](https://www.youtube.com/watch?v=UhEvcTT2beE)