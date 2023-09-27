# Git Repository Hacking


For regular use of GitHub visit [[Github-guide]]

[ESTEBAN BORGES](https://securitytrails.com/blog/_author/estebanborges) article on [securitytrails.com about Github Dorks](https://securitytrails.com/blog/github-dorks) is referenced and used frequently it importantly mentioned on  [HackTricks - git](https://book.hacktricks.xyz/network-services-pentesting/pentesting-web/git) - recommended read as it scratches a surface of which is a very deep and rewarding topic. DevOps in AWS -[[AWS-Defined]]  and in [[Azure-DevOps]] have Github integration, there has been numerous vulnerabilities with Github as a service such [cryptomining github actions](https://techbeacon.com/security/cryptominers-flooding-github-other-cloudy-dev-services) . Development is complex, security is complex and managing people sharing complex projects will always lead to problems of implementation. 
#### Github Dorks

[Security Trails Github Dorks](https://securitytrails.com/blog/github-dorks)

Keywords to try - worth considering
```bash
password
dbpassword
dbuser
access_key
secret_access_key
bucket_password
redis_password
root_password
```

Actual Github Dorks - [github-dork.py](https://github.com/techgaun/github-dorks) is recommended in this article (it use github search to automate similar queries below)
```bash
filename:.npmrc _auth
filename:.dockercfg auth
extension:pem private
extension:ppk private
filename:id_rsa or filename:id_dsa
extension:sql mysql dump
extension:sql mysql dump password
filename:credentials aws_access_key_id
filename:.s3cfg
filename:wp-config.php
filename:.htpasswd
filename:.env DB_USERNAME NOT homestead
filename:.env MAIL_HOST=smtp.gmail.com
filename:.git-credentials
```

#### Mitigation and Prevention Tools

[Security Trail Github Dorks](https://securitytrails.com/blog/github-dorks) recommends:
- [Git-secrets](https://github.com/awslabs/git-secrets/blob/master/README.rst) , written by a team at AWS to prevent developers from publicly sharing confidential keys
	- [official documentation](https://github.com/awslabs/git-secrets/blob/master/README.rst%23installing-git-secrets) 
- [Git-Hound](https://github.com/ezekg/git-hound) is an alternative to Git-secrets.

#### Dumping Tools

Dumping tools  dump a Repository from a URL

[git-dumper](https://github.com/arthaud/git-dumper)

#### Manual Enumeration

```bash
mkdir open-src-repo exfiled-repo; cd open-src-repo
git clone $repo

wget -r $url/.git -o exfiled-repo/
diff exfiled-repo/.git/ open-src-repo/.git


cd exfiled-repo/

git status
# For missing blobs :`git fsck` - possible corruption

# Print comit history
git log
# Difference between commits
git show
```

`md5sum` hash a `$file.js` or any other library then look up the hash on opensource repositories on Github code to fingerprint the version - From [Ippsec.Rocks](https://ippsec.rocks) Get all md5sum for every version of test.js from repository sorted by commit hash:
```bash
fingerprint=test.js
for in $(git log $fingerprint|grep ^commit|awk '{print $2}'); do git checkout -- $fingerprint; echo -n "$i md5sum $fingerprint; done
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


#### Git GTFOBin

Misconfigurations of binaries can be used to escalation privileges for:
Linux - [GTFOBins - git](https://gtfobins.github.io/gtfobins/git/)

## References

[HackTricks - git](https://book.hacktricks.xyz/network-services-pentesting/pentesting-web/git)
[GTFOBins - git](https://gtfobins.github.io/gtfobins/git/)
[Security Trails Github Dorks](https://securitytrails.com/blog/github-dorks)
[techbeacon.com - cryptomining github actions](https://techbeacon.com/security/cryptominers-flooding-github-other-cloudy-dev-services) 
[Ippsec.Rocks](https://ippsec.rocks) 
[truffleHog](https://github.com/dxa4481/truffleHog)
[gitraken](https://www.gitkraken.com/)
[git-money](https://github.com/dnoiz1/git-money)
[DVCS-pillage](https://github.com/evilpacket/DVCS-Pillage)
[GitTools](https://github.com/internetwache/GitTools)
[gitrob](https://github.com/michenriksen/gitrob)
[git-vuln-finder](https://github.com/cve-search/git-vuln-finder)
[Git-secrets](https://github.com/awslabs/git-secrets/blob/master/README.rst) and its [official documentation](https://github.com/awslabs/git-secrets/blob/master/README.rst%23installing-git-secrets) 
[Git-Hound](https://github.com/ezekg/git-hound) is an alternative to Git-secrets.
[git-dumper](https://github.com/arthaud/git-dumper)