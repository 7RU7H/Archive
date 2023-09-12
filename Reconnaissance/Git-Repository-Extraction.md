# Git Repository Extraction

Until I find a professional use good name this article will called *Git Repository Extraction*.

For regular use of GitHub visit [[Github-guide]]
#### Github Dorks

[Security Trail Github Dorks](https://securitytrails.com/blog/github-dorks)
#### Dumping Tools

Dumping tools  dump a Repository from a URL

[git-dumper](https://github.com/arthaud/git-dumper)

#### Change Comparison 

```bash
mkdir open-src-repo exfiled-repo; cd open-src-repo
git clone $repo

wget -r $url/.git -o exfiled-repo/
diff exfiled-repo/.git/ open-src-repo/.git
```

[truffleHog](https://github.com/dxa4481/truffleHog)
#### Content Visibility Tools

[gitraken](https://www.gitkraken.com/)

[git-money](https://github.com/dnoiz1/git-money)
[DVCS-pillage](https://github.com/evilpacket/DVCS-Pillage)
[GitTools](https://github.com/internetwache/GitTools)

For sensitive information [gitrob](https://github.com/michenriksen/gitrob)
#### Vulnerabilities

[[Snyk]]
[git-vuln-finder](https://github.com/cve-search/git-vuln-finder)


## References

[HackTricks - git](https://book.hacktricks.xyz/network-services-pentesting/pentesting-web/git)