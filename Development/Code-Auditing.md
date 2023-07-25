# Code Auditing

This article concerns Code Auditing/review via the use of Linux based CLI, editors  and tools, although the similiar principles apply using Windows as techniques .  


[[Regular-Expressions]]
[[Vim-Cheatsheet]] and [[Vim-Hack-Tricks]] or Emacs, VScode equivalent

- Regex searching - `grep -e` 
- Cross references multiple files at same time -  `diff`

1. High level overview of how the application works and is supposed to do
	- Who are the users and tieringof privileges
	- Where can input go and how it goes through  the control flow - i.e can you bypass checks
	- Major frameworks and libraries
	- Add-on and plugins used
	- What can go wrong - common vulnerabilities fr your applicaion are.
	- [[OSINT]] the code base - leaks, disclosures
1. Linear parse to understand what it is doing - not its purpose! 
	- Extract functions and describe functionality in one sentence
		 - Grep for vulnerable functions
	- Highlight inline calls, link dependencies
	- Chain testing a hypothetical data test that for significant control flow and data handling - vulnerability basis  
		- This highlights what checks per vulnerabilty 
2.  Error code minor difference make the difference 
3. Consider the known application security issues that are derived from insecure coding practices:
	- Input validation
	- Output encoding
	- Missing access controls
	- Weak regex checks


Use [[Reverse-Engineering-Tools]] 
Interactive shells to test code snippets


## References

[OWASP How to Analyze Code for Vulnerabilities by Vicki Li ](https://www.youtube.com/watch?v=A8CNysN-lOM)