# Question Based Web-Application Hacking Methodology

- Are the people on the network [[OSINT]]able?  [[Question-Based-OSINT-Methodology]]?
	- Is it in-scope and most professional way [[OSINT-People]]
	- Who to [[OSINT]]? 
		- Roles and social-contact-adjacent?
	- By technique? 
	- Do they accept documents for [[Phishing]]? 
	- Can we do [[Social-Engineering]] on a phone?
	- Pretext to do any of the above
		- Is a pretext form-able?
			- Is the enough information and correlation?
				- What is expected call or document format?
					- What do we need to forge a forgery? 
				- Can you pull it off?
					- Is something that you can actually do - [do not try to pretend to be a old women combining something unfitting to meta-context, which your audience would perceive as less than normal](https://www.youtube.com/watch?v=9_OIs49m56E)
			- ...then is the pretext fitting?
- Is infrastructure [[OSINT]]able? - [[Question-Based-OSINT-Methodology]]?
	- Externally exposed identification
		- Formatting for email and users?
	- What externally exposed infrastructure exists - Ports, Websites, DNS servers -> Subdomains? Email servers?
	- Domain Names
	- CIDR ranges 
	- Cloud providers
- External Network
	- Strange/Custom ports?
		- What do common extractions with CLI tools suggest about this ports use? -  `curl`, `telnet`, `nc`
- External Source storage?


- Web
	- Is recon in the background and you manually hacking in the foreground?
		- Are contextualising you content discovery bruteforce; understand the asset pick a contextually specific wordlist per stack?
		- Have walked through the applicataion as a ordinary user?
		- Have you pressed `[CTRL + F12]` yet? - Browser `Inspect` does not show HTML encoded characters
		- Is it at static web page check extension that make pages dynamic index.html -> index.php,etc
	- Does the site provide text to scrap into wordlist?
	- Virtual hosting? 
		- Fuzzable - rate limits?
		- Potential OSINTable VHOST from merging or referenced? 
		- What does the VHOSTing indicate about the technological stack: Subdomains, Containerisation, Cloud?
			- How is then stacked - bottom up from entry point?
	- WAF? - [[Bypassing-WAFs]]
		- `If-None-Match` 
		- `X-Forwarded-For`
	- Web server and Website Language
		- Clarify host OS version from Web Server version? - Measure twice cut once!
		- Vulnerable Language?
		- JavaScript? - modern browsers can debug especially useful blind exploit development
			-  XSS?
				- What Input Validation?
					- Which characters?
						- URL encoded IP address in XSS payloads?
				- Have you tried multiple payloads to verify (non-)existence of XSS, then tools? 
			- Deserialization Attacks?
		- Vulnerable webserver version?
		- Webserver generic issues by type
			- [[Apache-Tomcat]]
		- Vulnerable versioning? 
	- Have you caused and dorked ([[Search-Engine-Dorking]]) the error messages? 
	- What request methods and can you get different results from changing them?
		 - Can you bypass with additional Headers? 
			 - Use `curl` with  `--proxy ` flag to prevent forget `Content-*` Headers that are required, which [[BurpSuite]] Community does not automatic update when you change the request type manually. 
	- Endpoints?
		- Fuzzed with Special characters on all end points - [[FFUF-Cheatsheet]]?
	- CMS
		- Is the version or plugin version vulnerable? 
	- Does the website use a database for storage?
	- Web server default Admin Login panels?
		- Default credentials?
		- Reused credentials?
		- Insecure credentials?
	- Where can input be provided?
		- What input?
		- Where does the input go?
		- How is it processed?
		- Is there evidence of filtering and sanitization of input? 
	 - API?
		 - Is it mappable? 
		 - Disclosure API Token?
	- Do any parameters call non-local resources?
		- Does the non local request have it only parameters
		- `ffuf -request search.req -request-proto http -w special-chars.txt -mc all` - which characters cause what issue that indicate what about the context? 
		- What data returns from the testing the parameter?
			- LFI? Can `include()` files from disk/memory
			- Path Traversal? Can you read disk/memory?
			- RFI? Can you get remote resources? - Internal && External
			- SSRF? Can you request known resources - ports, files, web pages?
			- XSS? Can you execute JavaScript scripting?
			- SSTI? Can you exploit the template engines access to system?
			- (no)SQLI? Can you create error code enough to PoC interaction with database?  
			- CMDi? Can you execute with `& CMD` - windows  or `; CMD` - Linux?
			- IDOR? Can you deserialize or decoded data; or modify data to change your object context?  
			- Error text 
				- What does the error mean? Just google it! 
			- How is data reflected back?
				- Did you fuzz for special bad characters?
				- XSS, SSTI, etc?
... 
- SQLI? - [[SQL-Injection]]
	- Do you have time to do this? - [[SQLmap-CheatSheet]]
	- Always play guess the SQL query 
		-  you may not need added logic or quotes 
	- Are you starting small, being methodological building queries not from rabbit hole inbound?
	- What is the website doing functionally with components on the same network or server or external dependencies?
	- Are raw queries being made if any? 
		- Can you create an Error and fix it?
		- Union statements of the legitimate queries must be mirror numbers of outputs (columns,rows) in our SQL injection
		- Is the data returned a Boolean directly or indirectly?
			- Are Headers used in the back to store SQL data?
				- PHP: `X-Forward-For: 10.10.10.0.` to log IP addresses
	- What are the bad characters have you fuzzed them?
	- Identified application using an SQL query? - beware the non-linear branching
		- Concatenate (Version, SQL Language and business logic of Application language specifics) - what does this entail?
		- Hypotheses and test (if no source code) how application makes an SQL query or multiple queries 
		- Can you break it to create error messages?
			- Did you read and proper [[Search-Engine-Dorking]]? 
				- Can we SQLi and return output in the error message?
				- Can we break it to enumerate insights as how application works not the database?
		 - How many fields, double this number for number of quotes of the query 
			- For each field what is the data-type
		 - By Response Typology:
			- By **In-Band** SQL injections:
				- Is the result of the query is displayed along with the application-returned value?
					- Go Union-based SQLi!
						- How many columns?
							- Column number must be the same as original query
							- ID column exists!
						- Data type of each column?
							- Data type must be the same as original query
								- Conversion functions exist for each SQL language fret not
						 - Is what you querying for `LIKE "something"`?   
			- By **Blind** SQL injections:
				- Time-based Blind - `sleep` database `sleep
				- Boolean-based Blind -  `IF`
			- By **Out-of-Band** SQL injections: 
		- Where is the data coming from?
			- Which database(s) and table(s)?
		- Did the developer put a query inside a query?
			- Map out each query and sub-query like a `tree` to avoid *confused operator concatenation injection nullifying gibber*-the-SQL-injection-process phenomena
		- If nothing has returned can you query the database to sleep()?
		- If there are multiple fields is there second order injection with `'\''` and `'"'` to generate a error, have do so for each? 
		- Can you write a webshell to the filesystem through injection?
- File uploads?
	- Are we be diligent in get feedback from our actions with proxying tools?
	- Can we get the source code and read it properly?
	- What languages does the server or connected systems like parsers for xml, JavaScript use?
	- Can we just use `PUT`? 
		- BurpSuite: `Proxy -> Options -> Intercept Client Requests`
	- How does the web servers handle requests for static files?
	- How is the web server handing HTTP Headers see [[HTTP]] 
		- use `curl "http://$IP/page" -X OPTIONS -I`
	- How is the web server handling static files?
		- Executable Or Non-Executable
			- Non-Executable: the server may just send the file's contents to the client in an HTTP response.
			- Executable: server must be configured to executed that file type it will respond to the client
				- Else it is not configured and will respond with an Error
			- Is the file type executable or modifiable to be executable after upload or during?
	- Do we have file execution?
		1. Accessible directory 
		2. Vulnerable parameter with the uploaded file are argument
		3. [[Server-Side-Request-Forgery]] or [[Path-Traversal]] to force execution 
		4. Injection attack to force execution
		5. Download?
	- Where is the filtering occurring client or server side?
		-  Bypassing Client-Side filtering
			1.  Turn off JavaScript in your browser
			2.  Intercept and modify the incoming page
			3.  Intercept and modify the file upload
				1. Change:
					1. Content-Type 
						- [Portswigger](https://portswigger.net/web-security/file-upload) states: *"The `Content-Type` response header may provide clues as to what kind of file the server thinks it has served. If this header hasn't been explicitly set by the application code, it normally contains the result of the file extension/MIME type mapping."*
					1. *filename=*-like-parametres argument to acceptable
			4.  Send the file directly to the upload destination
		- Bypassing Server-Side filtering
			1. Change or embedded the file extension within accepted extension
			2. Change magic number
			3. Change name with encoding or multiples of encoding 
			4. Change the content, length of file
				1. encoding
				2. compression
	- What could be being validated? 
		0. Is the directory where stored writable?
		1. What blacklisting or filtering could be implemented?
			2. Extension validation - only want a .specific extension, can append **after** or **before**
				1. Check for `.phpX` and `.phar` variations for relevant language some have lots
				2. Can be obfuscate file extensions like .aSpx on windows (as windows is case insensitive) be parsed as .aspx
				3. Can we stack file extensions - `exploit.php.jpg`?
					1. With encodings?
						1. URL? Double URL?
						2. multibyte unicode characters:
							- *Sequences like `xC0 x2E`, `xC4 xAE` or `xC0 xAE` may be translated to `x2E` if the filename parsed as a UTF-8 string, but then converted to ASCII characters before being used in a path.* [PortSwigger](https://portswigger.net/web-security/file-upload#how-do-web-servers-handle-requests-for-static-files)
					2. With `;` or `%00` - `exploit.asp;.jpg` or `exploit.asp%00.jpg` - because the server process is C/C++ and these being line/string termination characters
			3. File type validation? 
				0. `Content-Type` Header
				1. MIME (Multipurpose Internet Mail Extension) validation 
				2. Magic number validation - first bytes of file, `hexedit` to edit in hex.
			5. File length validation - checks on file length
			6. File name validation - bad chars like control chars, slashes, null bytes
				5. Is the server storing files in a way that is guessable (storing files by naming with an MD5 hash)?
			7. File content validation? 
				- [Wikipedia File Signatures](https://en.wikipedia.org/wiki/List_of_file_signatures) - Files types have signature set of bytes to make them unique amongst other types
		1. Is the directory were files store user-accessible? 
		1. Is there potentially a race condition?
			1. Is there a custom file validation mechanisms instead of or used in parallel to a framework with temporary/sandboxing destination to which validation checks are performed before storage (hopeful with unguessable file name)?
			2. URL-based file uploads with custom file validation mechanisms
	- Can be bypass File Execution prevention - can we treat the file upload as just *write* not write and be executed by?
		- If there is a file upload vulnerability upload a blank `.htaccess`? 
		- If you can create a new directory on upload make new directory?
		- Is there another page that execute a file that can reach the uploaded file?
			- Is there an File inclusion vulnerability?
		- Do we need to privilege escalated on the web application to execute a file?  
	- Do need top upload malicious client-side scripts like an XSS payload, because we can't have execution over the server? 
	- Is the parser of `.doc` or `.xls` files vulnerable to XXE injection attacks from our uploaded malicious file?
- LFI?
	-  Add a `.` between `filename` and `.ext` for invalid file checks
	- Adding a `/` in the middle of `filename.ext` to check characters

- Web PrivEsc
- Have you performed scanning or manual enumeration authenticated?
- How is authenticated user data reflected on the page?
	- Framework? 
	- Database?
	- Session-related?