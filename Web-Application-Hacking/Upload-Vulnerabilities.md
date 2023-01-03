# Upload Vulnerabilities

[PortSwigger File Upload Vulnerabilities](https://portswigger.net/web-security/file-upload): 
*"File upload vulnerabilities are when a web server allows users to upload files to its filesystem without sufficiently validating things like their name, type, contents, or size. Failing to properly enforce restrictions on these could mean that even a basic image upload function can be used to upload arbitrary and potentially dangerous files instead. This could even include server-side script files that enable remote code execution. In some cases, the act of uploading the file is in itself enough to cause damage. Other attacks may involve a follow-up HTTP request for the file, typically to trigger its execution by the server."*

## Tools

1. Content Discovery Tool - feroxbuster, gobuster, dirb, dirbuster, ffuf, wfuzz.. to find where to upload file and where uploaded files will end up
2. Wappalyzer - For some information
3. Burp - Intercept upload requests to configure the request to bypass and/or trick the server.

[[DAVtest]] tests WebDAV enabled servers by uploading test executable files
[[Curl-Cheatsheet]] for:

```bash
curl "http://$IP" -X OPTIONS -I # Get all the options
curl -T '/path/to/local/file.txt' 'https://example.com/test/'  
curl --upload-file <file> http://<IP>/test/<filename>
```

## Considerations

-  How is the web server handing HTTP Headers see [[HTTP-Defined]] - use `curl "http://$IP/page" -X OPTIONS -I`
- How web server handling static files?
	- Executable Or Non-Executable
		- Non-Executable: the server may just send the file's contents to the client in an HTTP response.
		- Executable: server must be configured to executed that file type it will respond to the client
			- Else it is not configured and will respond with an Error
- Get the source code and read it properly

[Portswigger](https://portswigger.net/web-security/file-upload)*"The `Content-Type` response header may provide clues as to what kind of file the server thinks it has served. If this header hasn't been explicitly set by the application code, it normally contains the result of the file extension/MIME type mapping."*

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

When using [[Burpsuite-Helpsheet]], you may need to configure the types Burp intercepts:
`Proxy -> Options -> Intercept Client Requests` section, edit the condition of the first line to remove or add.

1. Extension validation - only want a .specific extension, can append **after** or **before**
	1. Check for .phpX and .phar variations
2. File type filtering 
	1. MIME(**M**ultipurpose **I**nternet **M**ail **E**xtension) validation 
	2. Magic number validation - first bytes of file, `hexedit` to edit in hex.
3. File length filtering -  checks on file length
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

## Bypass File Execution

1. If there is a file upload vulnerablity upload a blank `.htaccess` 
2. If you can create a new directory on upload make new directory 

## Upload functionality specifics

- If .aspx then use a .aspx reverseshell


## Impact and Mitigations

The impact of file upload vulnerabilities:

- What property of the file that is uploaded does not get validated
- What HTTP Method configuration and client-server modelcontext allows for uploading
- What file permissions does the file have once uploaded

PHP Migitations:

- md5sum or shasum the files and store them as the \*-sum string for pseudo random filenames, which remove control over the extension. 
- Disable PHP wrappers, file could be archived as .zip, but then unzipped PHP wrappers with the extension then useable 
​- Complexify the suming as function `md5($data_uploaded, $store_id, $user_id, $filename)`
	- `$data_uploaded`, `$store_id` - like a Salt
	- `$user_id`, `$filename` - prevent collision with other files


## References

[PortSwigger File Upload Vulnerabilities](https://portswigger.net/web-security/file-upload)