# Rabbitholes


This is probably the best explanation I have found other than having to figure out for myself.
>[Rabbitholes Guide from ChrisPritchard - Aquinas's OSCP Guide](https://github.com/ChrisPritchard/ctf-writeups/blob/master/oscp-guide.md):
 >- If you are on a 20 or 25 pt box and it has a website at port 80 with a file named 'creds' in it. Thats pretty obviously a red herring.
> - you get access to something and immediately hit a wall: e.g. a database that you get creds to, but once in, the db has no tables of note, and your account has no privileges
 >- you compromise a website, look it up on exploit db, and it has a exploit-to-root bug on a 20/25 pt box: these boxes require both a local and root flag! Unless you're lucky and the exploit is post the boxes creation, chances are that this exploit wont work; try it, and see if its been blocked
 >- likewise, just a general exploit that is simple and should work but doesnt: they might have explicitly modified the app or service so the exploit fails and you waste time trying to get it to work
> - generally if you spend hours and get nowhere, you are better off doing more enumeration than just beating your head against it. You can always come back later.


- Obvious Stupid - Peak, but do not invest
	- sometimes this is also the stupid you need, be quick and methodical do not emotional invest!
- HitTheSuccesToWallOfNOPENOTHINGHERE- 2 steps forward 3 steps back; Move on, prepare for disappointment like this
	- Access a database, but there is no creds that work (save them anyway), no table, user is guest only - Its nasty - 2 steps forward, 3 steps back rabbithole
- Exploit *all the way to root with this one easy script* - too good to be true, try, but ...yep.
	- Webserver to root vulns on 20-25 point box - Very unlikely, try it, and see if its been blocked
- ExploitDoesNotCompute - Methodically beforehand exploit-dev it properly - read, understand, modify correctly; tried a couple of times, NOPE? -> QUICK move on!
	- Try a couple of times (making sure you trying after reading, modifying and understanding what it is intended to do - IE IT IS CORRECT and SHOULD WORK, but DOES NOT)
- HoursInTheSwampOfProblems - RUN around and Run away to a different problem you can solve.
	- Pivot to something else, time spent elsewhere (if you noted and logged what you did try is) much better use of your time


*"Simplifying"* and adding to this further:
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
- Preparing for the practical part of the exam is understanding what is not possible for them to test and why, the grey area.
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