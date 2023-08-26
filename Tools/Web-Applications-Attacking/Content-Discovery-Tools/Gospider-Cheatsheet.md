# Gospider Cheatsheet

[GoSpider](https://github.com/jaeles-project/gospider) - Fast web spider written in Go

- Features
	- Fast web crawling
	- Brute force and parse sitemap.xml
	- Parse robots.txt
	- Generate and verify link from JavaScript files
	- Link Finder
	- Find AWS-S3 from response source
	- Find subdomains from response source
	- Get URLs from Wayback Machine, Common Crawl, Virus Total, Alien Vault
	- Format output easy to Grep
	- Support Burp input
	- Crawl multiple sites in parallel
	- Random mobile/web User-Agent

[Modified One Liner from KingOfTheBugBounty](https://github.com/KingOfBugbounty/KingOfBugBountyTips)
```bash
gospider -d 0 -s 'http://10.10.10.10' -a -d 5 -c 5 --sitemap --robots --blacklist jpg,jpeg,gif,css,tif,tiff,png,ttf,woff,woff2,ico,pdf,svg,txt  -o gospider
```

## References

[GoSpider](https://github.com/jaeles-project/gospider) 
[KingOfTheBugBounty](https://github.com/KingOfBugbounty/KingOfBugBountyTips)