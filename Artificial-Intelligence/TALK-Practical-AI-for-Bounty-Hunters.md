# Practical AI for Bounty Hunters

[Practical AI for Bounty Hunters @jhaddix](https://www.youtube.com/watch?v=DqgterfPHzg), Description:
There's a lot of hype around AI at the moment. Join Jason Haddix ([@jhaddix](https://www.youtube.com/@jhaddix) as he cuts through all the BS to show you 5 practical ways to use AI to supercharge your bounty hunting RIGHT NOW. Jason will cover AI for Recon, JavaScript analysis, Vulnerability Discovery, Payload Generation, and Reporting. From [NahamCon2024](https://www.youtube.com/hashtag/nahamcon2024)

#### AI Methodology:

- Model Choice
	- Model Security will prevent you
	- What is each model is good at
- RAG vs System Prompting
	- Retrieval Augmented Generation (RAG)
	- System Prompting is context specification - prompt before chatting with the Bot
- Agents - Haddix thinks they are not at [NahamCon2024](https://www.youtube.com/hashtag/nahamcon2024) are not there yet
	- Mini-bot: search, grab bots
- Temperature
	- Control spectrum you add to bots to be a specific type or how much creative:
		- Literal vs Creative (general you want low temperature to deal with technical nature of information security)
- Context
#### Gotchas

Trust, but **verify** and know the cut off 

#### Prompting

[[Fabric]] framework - Daniel Miessler - [fabric GitHub](https://github.com/danielmiessler/fabric) *"is an open-source framework for augmenting humans using AI. It provides a modular framework for solving specific problems using a crowdsourced set of AI prompts that can be used anywhere."*

Haddix admits OpenAI people say that Persona does help some academics say that it is does not.
> ### Persona:
> - Be X expert and ADJECTIVE NOUN (TITLE) Bot - You do Y
> ### Sources:
> - You always check A.com, it is your primary source
> - Then you check : a.com, b.com, Google, Wikipedia and then others to find this information
> ### Instructions:
> - Prompt to state the need to follow all instruction in some fake context; reminding it to try your best: There is proof (by academics according the Haddix) that telling the bot to enter particular states like Adderall and a State of Flow helps
> - Instructions about output specification: format
> - Specify goals 
> - Specify requirements like: most up to date data
> ### Related Research terms for your persona and instructions
> - List high value tokens (words, like SEO Keyword terms)
> ###  Mandatory Rules for how you bot reply
> - Always link sources
> - Always be deeply thorough
> - Double check each statement is up-to-date before printing to screen
> - Reply in bulleted sentences

#### Workflow

- Recon
	- Generally you it a process of perform every esoteric ways to find subdomains
		- Subdomain Ninja
- Acquisitions
	Acquisitions Bot Vs Crunchbase
-  Web Analysis
	- Bots:
		- DIY:
			- Generalised conversations for Offensive Security people
			- Defensive Information Security advice that has to be up-to-date
- Exploitation
	- GPT-4 plus can autonomously exploit a web vulnerability - but needs exactly what to do - CVE, route, etc. Needs a lot of information.
#### Questions to ask with your DIY Bot:

- What can you tell me about API calls or Routes in this App?
- Can you attempt to De-obfuscate or unpack any code in the App
- What can you tell me about the authentication methods for the App or API calls?
- Based on the functions you see do all require the authentication token?
- For each function, can you create some minor documentation and curl commands to execute?
- Can you parse all endpoints and routes and build a full list of URLs for me? In a bulleted list please.
- Can you identify any possible sinks XSS, DOM XSS, or DOM Cross Site Scripting vulnerabilities?

#### V2 - Identity statistically relevant areas

Most like parameters that are most like vulnerable to some exploit

#### Reporting

AI Augmented Reporting - BountyPls Bot - Bot that write the report

#### Tooling

[Burp GPT](https://github.com/aress31/burpgpt) *"A Burp Suite extension that integrates OpenAI's GPT to perform an additional passive scan for discovering highly bespoke vulnerabilities, and enables running traffic-based analysis of any type."* - PortSwigger will probably make there own at some point - Haddix

Nuclei Ninja - provide PoC and it will create a YAML template for [[Nuclei]] 

Nessus Ninja - Nessus NASL template generation per vulnerability  

## References

[Practical AI for Bounty Hunters @jhaddix - YouTube](https://www.youtube.com/watch?v=DqgterfPHzg)
[@jhaddix](https://www.youtube.com/@jhaddix)
[NahamCon2024](https://www.youtube.com/hashtag/nahamcon2024)
[Fabric GitHub](https://github.com/danielmiessler/fabric)
[Burp GPT](https://github.com/aress31/burpgpt)