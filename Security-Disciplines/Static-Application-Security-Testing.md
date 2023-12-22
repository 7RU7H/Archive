# Static Application Security Testing

## Introduction

Static Application Security Testing is the practice of source code review that is static - not running to finding bugs, vulnerabilities and misconfigurations. Using a combination of manual analysis and automated tools will yield the best results rather either when performing Static Application Security Testing. Manual enumeration and analysis is time consumer and human-error prone; Automated tooling is only as good as human reading the output, signatures of potential issues in code, the parsing algorithm of the tool and the snippet sandboxing if implemented. For its use in the [[Software-Development-Lifecycle]] ([[SDLC]]) and DevOps related activities along SAST visit the linked page.

## Considerations on "findings"

True Positives - Detected and is vulnerable
True Negatives - Found not to be vulnerable, but detection mechanism enumerated successfully
[False Positives](https://www.cgisecurity.com/questions/falsepositive.shtml) - detected, but not vulnerable
[False Negatives](https://www.cgisecurity.com/questions/falsenegative.shtml) - not detected, but detection mechanism failed

Null Space - 
- What do clues connected together within a hypothesis may indicate theory to be true or false
- Example from @MalwareJake: - Nuking the Log off the Event Logs, but there is still Log on Event and the system has not rebooted or shuck down
	- Find:
		- What is not there, but should be
		- What is there, but should not be
	- Consider how atypical the logic chain of events is a why it may have happened
	- Always collect clues and not opinions - collecting opinion lead nowhere, but clues a pieces of a puzzle leading somewhere

## Manual SAST

Useful Linux Commands
```bash
strings # all the strings of an executable - check encodings
grep # find patterns and strings
cat -n # Print file with line numbers
```

1. Search for insecure functions
	- By specific vulnerability
		- SQli - sending raw queries to database?
	- By general 
		- Language specific vulnerable functions 
1. Tracing user inputs to vulnerable functions
	- By specific vulnerability
	- By general 
		- Is input being sanitised?
			- Is the regular expression completely negating any polyglots 
1. Are Error pages reflected user?

## Automated SAST

SAST Tools perform..:
- Generally:
	- Transform the code into an abstract syntax tree
	- Analyse the abstract model for security issues
- Semantic Analysis - search for flaws by signatures that entail vulnerability 
- Dataflow Analysis - trace how information flows from source to potential sink and whether there is enough sanitisation
	- Sources: data flow inputs
	- Sinks: vulnerable functions
- Control flow analysis - analysis of the order operations to find:
	- Uninitialised variables
	- Resource leaks
	- Race conditions
- Structural Analysis - find 
	- Dead code (non-executing)
	- Incorrect exception handling in `try/catch` blocks
	- Weak cryptographic material
- Configuration Analysis - analyse configuration files


Integrating SAST in for [[VS-Code]]:
- Snyk
- Psalm - [Psalm Documentation](https://psalm.dev/docs/running_psalm/installation/) - [Visual Studio Marketplace Plugin](https://marketplace.visualstudio.com/items?itemName=getpsalm.psalm-vscode-plugin)
- Semgrep -  - [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=Semgrep.semgrep)


## References

[THM SAST Room](https://tryhackme.com/room/sast)
[False Positives](https://www.cgisecurity.com/questions/falsepositive.shtml) 
[False Negatives](https://www.cgisecurity.com/questions/falsenegative.shtml) 
[Psalm Documentation](https://psalm.dev/docs/running_psalm/installation/)
[Psalm Plugin - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=getpsalm.psalm-vscode-plugin)
[Semgrep Plugin - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=Semgrep.semgrep)