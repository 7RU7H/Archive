# Shodan

From official python library for [shodan-python](https://github.com/achillean/shodan-python): *"Shodan is a search engine for Internet-connected devices. Google lets you search for websites, Shodan lets you search for devices. This library provides developers easy access to all of the data stored in Shodan in order to automate tasks and integrate into existing tools.* There is also an archived [shodan-ruby](https://github.com/achillean/shodan-ruby) and not active [shodan-perl](https://github.com/achillean/shodan-perl) library for those inclined. I am too poor in various way to be using  `shodan`, one day this page will be full of more cool stuff. Thankfully there are lots of great people out there using it and have. 


**Go here, it is for the best [Official Shodan examples](https://www.shodan.io/search/examples)**

Below is a mirror of Shodan related information mentioned in [[TALK-Discovering-and-Exploiting-N-Days]] - [YouTube - Discovering and Exploiting N-Days w/ Corey Ham](https://www.youtube.com/watch?v=YxEEEOh6pc0)

Shodan important specifics 
- Shodan search terms are wildcards by default (i.e. `http.title:apache` will match anything with "apache" in it, case insensitive)
	- If you don’t specify a field to search, Shodan searches all fields. 
	- This means it’s prone to false positives - There will be many strings that contain the domain in unrelated HTML content, for example.
- The org search operator is based on WHOIS organisation name. These are often different from how companies refer to themselves, or are outdated. 
- Shodan has limited ability to find vulnerabilities
	- If Shodan can find something you need to do something about!
- Beware Scope - Shodan does not manage scope...
	- Check input
	- Query Shodan
	- Validate findings 
	- Check scope

Shodan Caveats
- The list of supported CVEs is relatively small compared to other scanners.
- Shodan’s data generally updates once a week.
- Some organizations might have countermeasures in place to prevent them from being scanned by Shodan.

SSL CN Search [[TALK-Discovering-and-Exploiting-N-Days]] - [YouTube - Discovering and Exploiting N-Days w/ Corey Ham](https://www.youtube.com/watch?v=YxEEEOh6pc0)
```bash
ssl.cert.subject.cn:*.$domain.com
```

Exporting Results from Shodan with CLI - [help.shodan.io/guides/how-to-download-data-with-api](https://help.shodan.io/guides/how-to-download-data-with-api)
```bash
# Add API Key
shodan init <api_key>
# Download Data (SSL CN Query)
shodan download --limit -1 uber-ssl-2024-01-31 "ssl.cert.subject.cn:*.uber.com"
# Download Data (Org Query)
shodan download --limit -1 uber-org-2024-01-31 'org:"Uber Technologies"'
# Download Data (Generic Query)
# Unfortunately, Shodan does not bulk search built-in (as of January 2024). However, we can use command-line scripting to do our own bulk searches.

for i in $(cat ip-list.txt); do shodan download shodan-out/$i $i; done
# Frustratingly, the Shodan CLI will create gzip archives with empty files. We can remove these after the batch finishes:
gunzip *.gz
rm -f -- *(.L0)
# ​List IPs
shodan parse uber-ssl-2024-01-31.json.gz --fields ip_str,hostnames
# Convert to CSV
shodan convert uber-ssl-2024-01-31.json.gz csv
# Look for a Specific CVE
shodan parse -f vulns:CVE-2023-44487 uber-ssl-2024-01-31.json.gz --fields ip_str,hostnames
```




#### Other resources

Recommend Cheatsheet from [Recon Like an Adversary by Jason Haddix at IWCON2023](https://www.youtube.com/watch?v=nGs8pWIj5k4)
![](shodan-cs-Joas-A-Santos-Linkedin.jpeg)
Source: [Joas A Santos Shodan Cheatsheet](https://www.linkedin.com/feed/update/urn:li:activity:7073267561278095361/)

The below are apparently powerful `shodan` queries discuss in the Nahamsec2023 convention talk: [The Power of Shodan: Leveraging Shodan for Critical Vulnerabilities | @GodFatherOrwa](https://www.youtube.com/watch?v=WgMGLlpznao)
```python
# Domains by ssl
ssl."$organisationName"

# by specific hostname
ssl.cert.subject.CN "$hostname"
-> dropdown http title

ssl.cert.subject.CN http.title "Invalid URL"
```

#### Karma v2

[Karma v2](https://github.com/Dheerajmadhukar/karma_v2) *can be used by Infosec Researchers, Penetration Testers, Bug Hunters to find deep information, more assets, WAF/CDN bypassed IPs, Internal/External Infra, Publicly exposed leaks and many more about their target. Shodan Premium API key is required to use this automation. Output from the 𝚔𝚊𝚛𝚖𝚊 𝚟𝟸 is displayed to the screen and saved to files/directories.* It is a automated `shodan` dorking wrapper aropund `shodan` 
- Powerful and flexible results via Shodan Dorks
- SSL SHA1 checksum/fingerprint Search
- Only hit In-Scope IPs
- Verify each IP with SSL/TLS certificate issuer match RegEx
- Provide Out-Of-Scope IPs
- Find out all ports including well known/uncommon/dynamic
- Grab all targets vulnerabilities related to CVEs
- Banner grab for each IP, Product, OS, Services & Org etc.
- Grab favicon Icons
- Generate Favicon Hash using python3 mmh3 Module
- Favicon Technology Detection using nuclei custom template
- ASN Scan
- BGP Neighbour
- IPv4 & IPv6 Profixes for ASN
- **Interesting Leaks like Indexing, NDMP, SMB, Login, SignUp, OAuth, SSO, Status 401/403/500, VPN, Citrix, Jfrog, Dashboards, OpenFire, Control Panels, Wordpress, Laravel, Jetty, S3 Buckets, Cloudfront, Jenkins, Kubernetes, Node Exports, Grafana, RabbitMQ, Containers, GitLab, MongoDB, Elastic, FTP anonymous, Memcached, DNS Recursion, Kibana, Prometheus, Default Passwords, Protected Objects, Moodle, Spring Boot, Django, Jira, Ruby, Secret Key and many more...**

## References

[The Power of Shodan: Leveraging Shodan for Critical Vulnerabilities | @GodFatherOrwa](https://www.youtube.com/watch?v=WgMGLlpznao)
[Joas A Santos Shodan Cheatsheet](https://www.linkedin.com/feed/update/urn:li:activity:7073267561278095361/)
[Recon Like an Adversary by Jason Haddix at IWCON2023](https://www.youtube.com/watch?v=nGs8pWIj5k4)
[GitHub - shodan-python](https://github.com/achillean/shodan-python) 
[GitHub - shodan-ruby](https://github.com/achillean/shodan-ruby) 
[GitHub - shodan-perl](https://github.com/achillean/shodan-perl)
[Karma v2](https://github.com/Dheerajmadhukar/karma_v2) 
[Official Shodan examples](https://www.shodan.io/search/examples)
[YouTube - Discovering and Exploiting N-Days w/ Corey Ham](https://www.youtube.com/watch?v=YxEEEOh6pc0)
[help.shodan.io/guides/how-to-download-data-with-api](https://help.shodan.io/guides/how-to-download-data-with-api)