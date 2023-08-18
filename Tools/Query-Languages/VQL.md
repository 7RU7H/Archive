# Velociraptor Query Language Cheatsheet

Per the official [documentation](https://docs.velociraptor.app/docs/overview/#vql---the-velociraptor-difference), "_Velociraptor’s power and flexibility comes from the Velociraptor Query Language (VQL). VQL is a framework for creating highly customised artifacts, which allow you to collect, query, and monitor almost any aspect of an endpoint, groups of endpoints, or an entire network. It can also be used to create continuous monitoring rules on the endpoint, as well as automate tasks on the server_". It shares similarities to SQL - visit [[MySQL-Cheatsheet]].


1. To execute a simple VQL create a [Notebook](https://docs.velociraptor.app/docs/vql/notebooks) 
	 - Consist of both:
		- VQL
		- [Markdown](https://www.markdownguide.org/getting-started/)
	- Make sure to add collaborators 
2. Click the lower pane to perform queries
3. Eight button will be displayed in this pane: `Cancel`, `Recalculate`, `Stop Calculating`, `Collapse`, `Edit Cell`, `Up Cell`, `Down Cell` and Dropdown `Add Cell`
4. To make queries `Click -> Add Cell (Plus Icon) -> (VQL | Markdown) `
5. Select `Edit (Pencil Icon)`
6. `?` will list possible completions for keywords

It is also possible to run queries from the terminal like `velociraptor.exe -v query "SELECT * FROM info()"`


Syntax specification - [VQL Reference](https://docs.velociraptor.app/vql_reference/) 
```sql
-- VQL does not place any restrictions on the use of whitespace
SELECT COLUMN_SELECTORS FROM VQL_PLUGIN() WHERE FILTER_EXPRESSION
-- There is no HAVING or JOIN
-- There is no `;` statement termination character 
-- Conventions:
-- inner statements on additional lines  
SELECT OS, FROM info() WHERE X="Windows 10"
SELECT * FROM certificates()

```

Get all the unique types and count of signal rules from `Hayabusa` being alerted on. 
```sql
SELECT * , count()  
FROM source(artifact="Windows.EventLogs.Hayabusa/Results")
GROUP BY RuleTitle
```


[Extending VQL](https://docs.velociraptor.app/docs/extending_vql/)
```bash
execve() # powershell plugin
```


## VQL Plugin

[Velociraptor Documentation](https://docs.velociraptor.app/docs/forensic/), *VQL is not useful without a good set of plugins that make DFIR work possible. Velociraptor’s strength lies in the wide array of VQL plugins and functions that are geared towards making DFIR investigations and detections effective"*.

[Searching Filenames](https://docs.velociraptor.app/docs/forensic/filesystem/) - One of the most common operations in DFIR is searching for files based on their file names.
[Searching Content](https://docs.velociraptor.app/docs/forensic/searching/) - A powerful DFIR technique is searching bulk data for patterns. YARA is a powerful keyword scanner that allows to search unstructured binary data based on user provided rules.
[NTFS Analysis](https://docs.velociraptor.app/docs/forensic/ntfs/) - NTFS is the standard Windows filesystem. Velociraptor contains powerful NTFS analysis capabilities.
[Binary parsing](https://docs.velociraptor.app/docs/forensic/binary/) - Parsing binary is very a important capability for forensic analysis and DFIR - we encounter binary data in many contexts, such as file formats, network traffic and more. Velociraptor uses VQL to provide the flexibility for users to be able to craft a VQL query in order to retrieve valuable machine state data. Sometimes we need to parse binary data to answer these questions. While binary parsers written in Golang are typically the best options for speed and memory efficiency, the need to compile a parser into an executable and push it to the endpoint makes it difficult to implement adhoc parsers.
[Evidence Of Execution](https://docs.velociraptor.app/docs/forensic/evidence_of_execution/) - Sometimes we need to find out when (or if) a particular binary was run on the endpoint. This question can come up in a number of contexts, such as running malware by a user, lateral movement from a threat actor etc. Windows has a rich set of forensic artefacts that we can use to infer program execution. This page covers some of the more common evidence of execution artefacts. Prefetch files Prefetch files are used to keep track of executions
[Event Logs](https://docs.velociraptor.app/docs/forensic/event_logs/) - Windows Event Logs The Windows event logs are stored in files with extension of \*.evtx typically stored within `C:\Windows\System32\WinEVT\Logs\*.evtx` Unlike traditional unix style log files that consist of unstructured text, Windows EVTX files are stored in a binary format with several advantages: Rollover - The EVTX file is divided into chunks and new chunks can overwrite older chunks. This allows the file size to be limited, and when the event log fills up, events simply rotate into the start of the file overwriting older events.
[Volatile machine state](https://docs.velociraptor.app/docs/forensic/volatile/) - Traditional forensic analysis relies on filesystem artefacts. However, one of the best advantages of performing live response is the ability to access the live system’s state and uncover volatile indicators that only exist briefly and might change in future. Traditionally volatile evidence was acquired using a full memory dump of the running system, and then using a number of memory analysis frameworks to extract some of the types of forensic artefacts we discuss in this page.

## References

[THM Velociraptor Room](https://tryhackme.com/room/velociraptorhp)
[VQL Fundamentals](https://docs.velociraptor.app/docs/vql/)
[VQL documentation](https://docs.velociraptor.app/docs/overview/#vql---the-velociraptor-difference)
[VQL Reference](https://docs.velociraptor.app/vql_reference/) 
[Extending VQL](https://docs.velociraptor.app/docs/extending_vql/)
[Notebook](https://docs.velociraptor.app/docs/vql/notebooks)
[Markdown](https://www.markdownguide.org/getting-started/)