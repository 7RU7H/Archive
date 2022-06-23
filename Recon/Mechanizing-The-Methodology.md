# Mechanizing The Methodology
How to find vulnerabilities while you're doing other things. By [Daniel Miessler](https://danielmiessler.com) [Twitter](https://twitter.com/danielmiessler). This is an incredible talk and very insightful. If you are a beginner to cli-linux or looking into automation or if you need to focus on the larger meta-cognitive connections 

These are my notes of this talk and [article](https://danielmiessler.com/blog/mechanizing-the-methodology/)

## Why Automate
It is not either automated or manual; automation can feed your manual work. You automate so while you are living life so you get to the good bits.

## Turn everything into a question

Using the Unix Philosophy
1. Make each program do one thing well.
2. Expect the output of every program to becom the input to another, as yet unknown, program.

Daniel Miessler's Web related questions:
What are thier subdomains?
What ports are open?
Is this IP running a web server?
Has this site changed?
Is this a sensitive site?
What urls are in their JS?
Which of these share analytics code?
What domains do they own?
Which certs are abouit to expire?
What are all the links on this site?
What are this on this site?
What are this customer's ASN?
What ips are running web servers?
What stack is this running?
Which of these sites is running wordpress? 
Which of these sites is running Drupal?
Who works at this company?
Do they have personal github accounts?
Do those accounts have sensitive content?
Do those accounts have content related to work?
Do they any s3 buckets that are open?
Are they server databases?
Are they open or bruteforceable?

So questions can be combined: 

What are their subdomains? 
+
What ips are running web servers?

Unix philosphy = simple & discrete
1. domains.txt -> check_subdomain.sh 
2. check_subdomain.sh -> subdomains.txt
3. subdomains.txt -> check_webserver.sh

## Use a methodology to build your questions
See the [[Haddix-Methodology]] for Bug Bounty methodology.

## Live hosts

```bash
masscan --rate 100000 -p7,9,13,21-23,25-26,37,53,79-81,88,106,110-111,113,119,135,139,143-144,179,199,389,427,443-445,465,513-515,543-544,548,554,587,631,646,873,990,993,995,1025-29,1110,1433,1720m1723m1755,1900,2000-2001,2049,2121,2717,3000,3128,3306,2289,2986,4899,5000,5009,5051,5060,5101,5190,5357,5432,5631,5666,5800,5900,6000-6001,6646,7070,8000,8008-8009,8080-8081,8443,8888,9100,9999-10000,32768,49152-49157 -L ips.txt | awk '{ print $6 }' | sort -u > live_ips.txt
```

## A Brief word on module philosophy

![Image](recon-mtm-module-philosophy.png)

Daniel Miessler likes the hydrid for thsi unix-y approach without have to rewrite curl.

## Get a Page's HTML

Full HTML is a fundemental seed for many other modules to which you can find potentially sensitive fields, parse links, pull out JS files, etc. `Curl` is denied by alot of pages so:
`live_sites.txt -> get_html.sh -> $site.html`. 

```bash
chromium-browser -headless --user-agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537. 36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36' --dump-dom $site > site.html
```
Now you then have full HTML to parse and inspect.

## Getting the domains that redirect to a domain

Top-level scope for a given company requires pivoting from known TLD to other TLD in various wats by folling redirects to a trust domain.

`domains.txt -> get_redirects.sh -> $site.redirects`

Heavily reliance on ipinfo.io and host.io.
IP ranges and ASN numbers.
```bash
curl -s "https://host.io/api/domains/redirects/$site?&limit=1000" | jq -r '.domains' | jq '.[]' | tr -d \" > $site.redirects"
```
Redirects to further scrutinize to see if they belong to that company.

**Key Point** Unix-y automation is best at low level and non-abstracted as possible that you trust. But recommends `amass` for all-arounder enumeration tool.

## Module Chains
What is the workflow I need to answer a particular question?
`domain.txt -> get_company.sh -> company.txt -> get_domains.sh -> domains.txt -> get_asns.sh -> asns.txt -> get_ranges.sh -> ranges.txt`.

## Modules Chains Site Testing
Taken to the nth degree:
`one output --FEEDS-> ten separate modules`

## Automation and Notifications
Linux Cron, free with Linux to run modules and notifications either email, slack, etc.

## Build and Configurations
Once setup move towards a config management on a seperate linux box. Terraform, Anisble, Git  to deploy boxes to AWS. Axiom by Ben Bidmead is also recommended.

## Continuous Improvement
Follow the work of:
Jason Hadix
Nahsec
Tomnomnom
Codingo
Hakluke
stokfredrik
caffix
nnwaklam
pry0cc
thecybermentor

They are helping the community, they make tools, educate and hunt for bugs!

## How to run an automated testing platofrm on a $10 linux box
1. Break your techniques into questions
2. Create a separate UNIXY module for each step
3. Create intuitive output artifacts that can be used as inputs to other modules
4. chain those modules according to a methodogy that resonates with you
5. continuously those modules using Cron
6. use Amazon SES or Slack for alerting
7. Wire up your full config using Terraform/Ansible/Axiom for easy deployment
8. Follwo the best testers/creator in industry to stay up on new techniques 
9. Come back and hack manually on what your automation finds
10. Profit ( in relaxation,time,money or all the above)

## References

[Redteam Village](https://www.youtube.com/watch?v=URBnM6gGODo)
[Mechanizing The Methodology Article](https://danielmiessler.com/blog/mechanizing-the-methodology/)
[Daniel Miessler](https://danielmiessler.com)