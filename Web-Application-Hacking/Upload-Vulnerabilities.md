# Upload Vulnerabilities


## Tools
1. Content Discovery Tool - feroxbuster, gobuster, dirb, dirbuster, ffuf, wfuzz.. to find where to upload file and where uploaded files will end up
2. 1. Wappalyzer - For some information
3. Burp - Intercept upload requests to configure the request to bypass and/or trick the server.

## Methods 
Beware the some methods are damaging to data, a shell is potential damaging. PoC should be least harmful to the server.

Upload - Beware of Filtering and Validation checking
1. User upload buttons
2. Injection attack to force download a shell

Execution - Beware of Filtering and Sanitization checking
1. Accessiable directory 
2. Vulnerable parametre with the uploaded file are argument
3. SSRF to force execution 
4. Injection attack to force execution

## Overwriting existing files on a server
If file permission on the server are lacks, location of file path found and information disclosure as to of file name. 
 
##  Filtering types
1. Extension validation - only want a .specific extension
2. File type filtering 
	1. MIME(**M**ultipurpose **I**nternet **M**ail **E**xtension) validation 
	2. Magic number validation - first bytes of file, `hexedit` to edit in hex.
3. File length filtering - 
4. File name filtering - bad chars like control chars, slashes, null bytes
5. File content filtering - checks file content
 
##  Bypassing Client-Side filtering
1.  Turn off Javascript in your browser
2.  Intercept and modify the incoming page
3.  Intercept and modify the file upload
	1. Change:
		1. Content-Type
		2. *filename=*-like-parametres argument to acceptable
4.  Send the file directly to the upload destination

## Bypassing Server-Side filtering
1. Change or embedded the file extension within accepted extension
2. Change magic number
3. Change name with encoding or multiples of encoding 
4. Change the content, length of file
	1. encoding
	2. compression
	3. 
## Upload functionality specifics
- If .aspx then use a .aspx reverseshell
