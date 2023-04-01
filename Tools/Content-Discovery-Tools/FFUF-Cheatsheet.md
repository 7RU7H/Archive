# FFUF

## Introduction 

[fuff](https://github.com/ffuf/ffuf). is a fast web fuzzer written in Go. Examples of usage [Content discovery](https://github.com/ffuf/ffuf#typical-directory-discovery), [Vhost discovery](https://github.com/ffuf/ffuf#virtual-host-discovery-without-dns-records), [Parameter fuzzing](https://github.com/ffuf/ffuf#get-parameter-fuzzing), [POST data fuzzing](https://github.com/ffuf/ffuf#post-data-fuzzing), [Using external mutator](https://github.com/ffuf/ffuf#using-external-mutator-to-produce-test-cases), [Configuration files](https://github.com/ffuf/ffuf#configuration-files). Already included on BlackArch, Pentoo, Kali and Parrot.

## Basics

We choose a wordlist assign the :FUZZ keyword to denote that will then at the point /FUZZ; this can also be embedded in file path
```
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u $URL/FUZZ
```
The `-t` flag can control the amount threads on ffuf, careful of causing an negligent DoS attack through sending too many requests. Filters and Matcher option help reduce output - very important. Filter code `-fc 403` or match by code  `-mc 200` and filter size `-fs 0` display only the most relevant to find the what *maybe* there.

You can use two wordlists using FUZZ_1 FUZZ_2
```bash
where has this gone?
woops - will update soon
```

#### Wordlists and Use

Consult [[Wordlists]], [[Wordlist-Library]] and [[Wordlists-Considerations]]

**File extensions**
/seclists/Discovery/Web-Content/web-extensions.txt
/seclists/Discovery/Web-Content/raft-medium-words-lowercase.txt
/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt

**Directory/Page Wordlist**
/seclists/Discovery/Web-Content/directory-list-2.3-small.txt

**Domain Wordlist**
/seclists/Discovery/DNS/subdomains-top1million-5000.txt

**Parameters**
/seclists/Discovery/Web-Content/burp-parameter-names.txt
/seclists/Discovery/Web-Content/burp-parameter-names.txt

#### Fuzz with special Header

```bash
# IP spoof
ffuf -H 'X-Forwarded-For: 10.10.10.10'
```

#### Fuzzing for.. Bruteforce attacks

Use ffuf like hydra using file size filter to check responses, -X flag to set request type, -d  to send data and -H custom header similar to `curl`.
```bash
ffuf -u http://$IP/Login -c -w /usr/share/wordlists/rockyou.txt -X POST -d 'username=admin&password=FUZZ&submit=Submit' -fs 1435 -H 'Content-Type: application/x-www-form-urlencoded'
```

##### Fuzzing for Extension

Need to figure out what the server is running:
```bash
ffuf -w /usr/share/seclists/Discovery/Web-Content/web-extensions.txt:FUZZ -u http://$IP/index.FUZZ 
```

#### Fuzzing for Pages

```bash
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://$IP/blog/FUZZ.php
```

#### Fuzzing for Values

```bash
ffuf -w ids.txt:FUZZ -u http://$IP/admin/admin.php -X POST -d 'id=FUZZ' -H 'Content-Type: application/x-www-form-urlencoded' -fs $xxx
```

#### Fuzzing for Parameters

[It might be better to use](https://github.com/nsonaniya2010/SubDomainizer)
```bash
ffuf -u 'http://$IP/path/?FUZZ=1' -c -w /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt -fw 39  
ffuf -u 'http://$IP/path/?FUZZ=1' -c -w /usr/share/seclists/Discovery/Web-Content/raft-medium-words-lowercase.txt -fw 39
```
If the parameter accepts integers we can use `-w -` to read from STDOUT.
```bash
for i in {0..255}; do echo $i; done | ffuf -u 'http://IP/path/?id=FUZZ' -c -w -mc all -fw 33
```
POST
```bash
ffuf -w wordlist.txt:FUZZ -u http://$IP/admin/admin.php -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded' -fs $xxx
```

#### Fuzz.. Recursively
```bash
ffuf -w wordlist.txt:FUZZ -u http://$IP/FUZZ -recursion -recursion-depth 1 -e .php -v
```

#### Fuzzing for VHosts

[To match the output of wfuzz at 5:20](https://www.youtube.com/watch?v=U-2nI6wSPOE&t=46s) at  
```bash
ffuf -u http://mydomain.com -H "Host: FUZZ.mydomain.com" -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ  -fl $checkToFilter --mc all
```

#### Fuzzing for Subdomains
```bash
ffuf -u http://mydomain.com -c -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -H 'Host: FUZZ.mydomain.com' -fs 0
```

#### Fuzz a field in a captured request 

Reminder to edit the request.req and add FUZZ Field
```bash
# Consider editing size of request to speed up fuzzing
ffuf -request request.req -request-proto http
```

## References

[ffuf](https://github.com/ffuf/ffuf)
[cybersecnerds](https://cybersecnerds.com/ffuf-everything-you-need-to-know/)
[thmRoom](https://tryhackme.com/room/ffuf)
[HTB academy ffuf module](https://academy.hackthebox.com/modules)
[medium quiknapp](https://medium.com/quiknapp/fuzz-faster-with-ffuf-c18c031fc480)

## Appendix 

Usage
```bash
Fuzz Faster U Fool - v1.3.0-dev

HTTP OPTIONS:
  -H                  Header `"Name: Value"`, separated by colon. Multiple -H flags are accepted.
  -X                  HTTP method to use
  -b                  Cookie data `"NAME1=VALUE1; NAME2=VALUE2"` for copy as curl functionality.
  -d                  POST data
  -ignore-body        Do not fetch the response content. (default: false)
  -r                  Follow redirects (default: false)
  -recursion          Scan recursively. Only FUZZ keyword is supported, and URL (-u) has to end in it. (default: false)
  -recursion-depth    Maximum recursion depth. (default: 0)
  -recursion-strategy Recursion strategy: "default" for a redirect based, and "greedy" to recurse on all matches (default: default)
  -replay-proxy       Replay matched requests using this proxy.
  -timeout            HTTP request timeout in seconds. (default: 10)
  -u                  Target URL
  -x                  Proxy URL (SOCKS5 or HTTP). For example: http://127.0.0.1:8080 or socks5://127.0.0.1:8080

GENERAL OPTIONS:
  -V                  Show version information. (default: false)
  -ac                 Automatically calibrate filtering options (default: false)
  -acc                Custom auto-calibration string. Can be used multiple times. Implies -ac
  -c                  Colorize output. (default: false)
  -config             Load configuration from a file
  -maxtime            Maximum running time in seconds for entire process. (default: 0)
  -maxtime-job        Maximum running time in seconds per job. (default: 0)
  -p                  Seconds of `delay` between requests, or a range of random delay. For example "0.1" or "0.1-2.0"
  -rate               Rate of requests per second (default: 0)
  -s                  Do not print additional information (silent mode) (default: false)
  -sa                 Stop on all error cases. Implies -sf and -se. (default: false)
  -se                 Stop on spurious errors (default: false)
  -sf                 Stop when > 95% of responses return 403 Forbidden (default: false)
  -t                  Number of concurrent threads. (default: 40)
  -v                  Verbose output, printing full URL and redirect location (if any) with the results. (default: false)

MATCHER OPTIONS:
  -mc                 Match HTTP status codes, or "all" for everything. (default: 200,204,301,302,307,401,403,405)
  -ml                 Match amount of lines in response
  -mr                 Match regexp
  -ms                 Match HTTP response size
  -mw                 Match amount of words in response

FILTER OPTIONS:
  -fc                 Filter HTTP status codes from response. Comma separated list of codes and ranges
  -fl                 Filter by amount of lines in response. Comma separated list of line counts and ranges
  -fr                 Filter regexp
  -fs                 Filter HTTP response size. Comma separated list of sizes and ranges
  -fw                 Filter by amount of words in response. Comma separated list of word counts and ranges

INPUT OPTIONS:
  -D                  DirSearch wordlist compatibility mode. Used in conjunction with -e flag. (default: false)
  -e                  Comma separated list of extensions. Extends FUZZ keyword.
  -ic                 Ignore wordlist comments (default: false)
  -input-cmd          Command producing the input. --input-num is required when using this input method. Overrides -w.
  -input-num          Number of inputs to test. Used in conjunction with --input-cmd. (default: 100)
  -input-shell        Shell to be used for running command
  -mode               Multi-wordlist operation mode. Available modes: clusterbomb, pitchfork (default: clusterbomb)
  -request            File containing the raw http request
  -request-proto      Protocol to use along with raw request (default: https)
  -w                  Wordlist file path and (optional) keyword separated by colon. eg. '/path/to/wordlist:KEYWORD'

OUTPUT OPTIONS:
  -debug-log          Write all of the internal logging to the specified file.
  -o                  Write output to file
  -od                 Directory path to store matched results to.
  -of                 Output file format. Available formats: json, ejson, html, md, csv, ecsv (or, 'all' for all formats) (default: json)
  -or                 Don't create the output file if we don't have results (default: false)
```