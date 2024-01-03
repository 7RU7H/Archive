# Generating Likely Passwords


[[Generating-Usernames-And-Emails]] for these passwords follow the link that page.

#### Passwords profiling

Generations [[Wordlists]] for password profiling questions?
- Default Passwords are always there 
	- Have tried the [[Default-Passwords-Data-Recovery-Table]] for a password on by service through the [[Services-Hub]] page.
- Profiling
	- Low Hanging Fruit
		- Parent Company
		- Company 
		- Season + year
		- Technology in use
			- Project
			- Stack
		- `Password123s` - minimum complexity requirements just met
	- Person-based OSINT-able
		- Hobbies
		- Pet names
		- Recent Places in the last password reset 


- Future considerations based off advise from security professionals
	- Regional specific syntax  > 3, < 8 words 
	- Culture 
	- a, the, is, 
	- Predictable white space - one white space or two white space depending on regular use 
	- Tech-Level specific
		- Hedging to clever: `eRrm BLAH.. normal words`
		- Developers 
			- Tab or spaces 
			- Commonly used applications affecting typing behaviours 
	- Application / Hardware
		- Multilingualism in English speaking countries is encouraged with applications - preferable words
	- Account for normal people using l33t speak whether they know it or not 
	- Expletives are easier to remember 
	- Expletives add length - user incentive with long strong password to add more words that are more memorable 


[Kali's MP32 - hashcat/maskprocessor](https://www.kali.org/tools/maskprocessor/)
```bash
mp32 --custom-charset1='!@#$%^' johndoe?d?1 > mp32-passwd.lst
mp32 --custom-charset1='!@#$%^' jdoe?d?1 >> mp32-passwd.lst
mp32 --custom-charset1='!@#$%^' Johndoe?d?1 >> mp32-passwd.lst
mp32 --custom-charset1='!@#$%^' Jdoe?d?1 >> mp32-passwd.lst
mp32 --custom-charset1='!@#$%^' JDoe?d?1 >> mp32-passwd.lst
mp32 --custom-charset1='!@#$%^' JoeDoe?d?1 >> mp32-passwd.lst
cat mp32-passwd.lst | wc -l
```


## References

[Kali's MP32 - hashcat/maskprocessor](https://www.kali.org/tools/maskprocessor/)