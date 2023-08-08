# Velociraptor Query Language Cheatsheet

Per the official [documentation](https://docs.velociraptor.app/docs/overview/#vql---the-velociraptor-difference), "_Velociraptor’s power and flexibility comes from the Velociraptor Query Language (VQL). VQL is a framework for creating highly customized artifacts, which allow you to collect, query, and monitor almost any aspect of an endpoint, groups of endpoints, or an entire network. It can also be used to create continuous monitoring rules on the endpoint, as well as automate tasks on the server_". It shares similarities to SQL - visit [[MySQL-Cheatsheet]].

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
## References

[THM Velociraptor Room](https://tryhackme.com/room/velociraptorhp)
[VQL Fundamentals](https://docs.velociraptor.app/docs/vql/)
[VQL documentation](https://docs.velociraptor.app/docs/overview/#vql---the-velociraptor-difference)
[VQL Reference](https://docs.velociraptor.app/vql_reference/) 
[Extending VQL](https://docs.velociraptor.app/docs/extending_vql/)
[Notebook](https://docs.velociraptor.app/docs/vql/notebooks)
[Markdown](https://www.markdownguide.org/getting-started/)