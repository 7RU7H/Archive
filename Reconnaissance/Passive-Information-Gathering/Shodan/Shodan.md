# Shodan

From official python library for [shodan-python](https://github.com/achillean/shodan-python): *"Shodan is a search engine for Internet-connected devices. Google lets you search for websites, Shodan lets you search for devices. This library provides developers easy access to all of the data stored in Shodan in order to automate tasks and integrate into existing tools.* There is also an archived [shodan-ruby](https://github.com/achillean/shodan-ruby) and not active [shodan-perl](https://github.com/achillean/shodan-perl) library for those inclined.


I am too poor in various way for using  `shodan`, one day this page will be full of more cool stuff. Thankfully there are lots of great people out there using it and have. 

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