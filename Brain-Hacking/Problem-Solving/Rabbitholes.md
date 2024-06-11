# Rabbitholes


Due to Rabbitholes being a concept tied *personally* to OSCP. This page is about dealing with them. Unlike many detractor of Offensive Security's  fame or infamy regarding OSCP specifically -  **authorial opinion**: think that approach is probably the best and only way to measure some problem solving skills. That those that detract do not move beyond to understand why someone would cause you this much pain for something that you want so much hurts. It hurts everyone. These thinking skills that are probably required for those that want to go much further than OSCP, which I do, but I understand why other don't. For some it is a milestone and endpoint not midpoint or starting point probably more because of where they are in life and how much effort it represent to them relatively. I spent a long time investing the why to actually to be good. It was and still is very painful. I think the problem is clarity of how to approach understanding this subject matter. I also think that the raw pain and struggle  is something I would one day need to teach my children. Without charging them X amount of money for the privilege and escalating the act of problem solving to be fun, cross-domain and applicable to their personal development. Without being puzzles are fun with Pavlovs dog treats are flag.txt for cleaning your room. With just the truest distilled understanding, knowledge and practice without the degree of suffering like the OSCP.  

- Investing in the correct amount of noting for the job:
	- Labs are not exams, boxes are not labs, a box is not the exam
	- You can have too much in some areas 
	- And not enough in others
- Do Proving Ground Machines that are OSCP level, by being old exam machines then:
1. Make or theorise (graph out each step) a boxes as if you were making the exam 
	- Find your weaknesses
		- Can you port forward in various ways and receive shells?
		- Do you understand OWASP top 10 in context of OSCP like exam machine
		- Do understand the difference in ahcking AD and boot2root
		- Do you understand why multiple ultimately failing paths are failing path before or during and why the way you approach a machine is not going to get you flags 
	- Understand how to troll educationally from a:
		- Are those doing my OSCP like box doing noting, understand when to pivot to another box or route to a flag not fixating on a path or piece information
- Is your current methodology a question based methodology 
	- Do not be a tool, Tool do x for a problem; Reframe everything as questions - not tools
	- Interrogatives are like requests and response - no response entails something, just a actual response or just the facial expression change
- Understand the systems mindset
	- If not do not Sys-Admin X = how can you tell Sys-Admin A to do something else
	- If you do not take a step back and understand what system is within different contexts = how are you going to hack this, btw - Bruteforcing passwords and phishing examiners?
- Understand a security mindset - start from lines on blueprints to examples, build patterns and models and judgemental understanding (it takes time)
	1. Get or make a blueprint for a hypothetical safe then like child draw how with all the superpowers of fiction how you could get inside that safe
	2. Limit in conceptual scope what you can do and what the "safe" is i.e a mysql database:
		- Ask questions that define how it exists and is interactable on a network, host OS, etc
- Understand the OFFSEC student mindset
	- Try Harder
	- Try Smarter (but do not cheat, or cheat yourself)
	- WiRE:
		- Write, Isitarabbithole, Read, Execute - combine exploits, by think it does X + Y -> something that is part of chain to do some objective 
- Understand relevance to OFFSEC course material
	- Compress it all down, but understand the irrelevance for the exam of some the material 
		- reduce all non relevant to phase - XSS only would matter in a context where no user interaction and we could reflect in back on the page and the page or service read that page and executes it - not your browser
- Understand the OFFSEC examiner mindset (exam machine engineers)
	- If your job was machine engineer how would make similar boxes:
		- Have you made a rabbithole?
		- Why is something not or is OSCP relevant?

This is probably the best explanation I have found other than having to figure out for myself.
>[Rabbitholes Guide from ChrisPritchard - Aquinas's OSCP Guide](https://github.com/ChrisPritchard/ctf-writeups/blob/master/oscp-guide.md):
 >- If you are on a 20 or 25 pt box and it has a website at port 80 with a file named 'creds' in it. Thats pretty obviously a red herring.
> - you get access to something and immediately hit a wall: e.g. a database that you get creds to, but once in, the db has no tables of note, and your account has no privileges
 >- you compromise a website, look it up on exploit db, and it has a exploit-to-root bug on a 20/25 pt box: these boxes require both a local and root flag! Unless you're lucky and the exploit is post the boxes creation, chances are that this exploit wont work; try it, and see if its been blocked
 >- likewise, just a general exploit that is simple and should work but doesnt: they might have explicitly modified the app or service so the exploit fails and you waste time trying to get it to work
> - generally if you spend hours and get nowhere, you are better off doing more enumeration than just beating your head against it. You can always come back later.



**Authorial Note**: I will return to this to make some Rabbithole memetic that is funny (therefore memorable) and importantly useful. Also more work for both
- PWK200
- PWK300 and any other I will end up doing

*Simplifying* and adding to this further:
- Spin plates and time is just a number...
	- by noting well and keeping time without stressing you can move on to something else and come back later
- If its too good to be true, always check it but its a troll to test your thing
	- Recognise that Offensive Security are their to test methodology and thinking (even if passwords.txt in the real world finding)
	- Its an exam two flags with one exploit and no privilege escalation are the examiner even trying? If you were a exam machine maker how would you let that get close the pool of possible machines? Try it, but do not invest in a path
- If all is good then you hit a wall, the wall is there to make a maze 
	- Problem solving pivoting and psychological attrition are factors that determine the 80+ points on the exam people from those that get 70 or fail.
- Invest in the paths and methodology, not one path (exploit, misconfiguration, finding)
- Offensive Security may harden services against exploits, so...
	- If it does not work, check, because it is still valid for report - examiner want you to prove you are doing a job
	- Be tacticool with your resets
- Preparing for the practical part of the exam is understanding what is not possible for them to test and why, the grey area.accronyms
	- No NTLMRelaying, because tooling
	- No Automated Users
	- No exploits that *require* some Auto-Exploit tool to brute force till 
	- They are not there to test your GPU or CPU, your brain
- Default Image + Customisation for OSCP is actually Default Image + Customisation + Rabbitholes 
	- The idea being that for penetration testing you have the default ISO, default service, default configurations and then an Sys-Admin and Users will:
		- add customisation on the top of the default
		- may neglect to configure beyond the default
	- Then add the very Rabbitholing on top of that and really the solution to rabbitholes is:
		- Psychological
			- Its just a test - this should be like every other time you did a day of hacking multiple boxes in a day with or without writeups; beware this is why the Labs and Proving Ground help - Box style awareness helps   
			- Do not invest in one path, be open to tactical pivoting 
		- Method
			- Are you keeping *good* notes: 
			- Are you asking questions of yourself, the time, the boxes, etc
		- Judgement over your noting and situation
			- Its is a test: are you judging the situation for what it is - you hit a wall with some path (exploits, misconfigurations, findings)
## References

[Rabbitholes Guide from ChrisPritchard - Aquinas's OSCP Guide](https://github.com/ChrisPritchard/ctf-writeups/blob/master/oscp-guide.md)