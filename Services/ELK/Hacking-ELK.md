
See [[ELK-Defined]] for legitimate uses of the Elastix Stack

Default password
```
eLaStIx. :  2oo7
```

## Logstash

[Hacktricks](https://book.hacktricks.xyz/linux-hardening/privilege-escalation/logstash) *"Logstash is used for collecting, transforming and outputting logs. This is realized by using **pipelines**, which conta
in input, filter and output modules. The service gets interesting when having compromised a machine which is running Logstash as a service."*

`adm` a group of [[Linux-Users-And-Groups]] is allowed to read these logs; depending on the context of the file system writablity is is potentially a vector escalation - see [[Privilege-Escalation-Defined]]. 

Some versions of Logstash vulerable to [[Log4J]]

## References

[Hacktricks](https://book.hacktricks.xyz/linux-hardening/privilege-escalation/logstash)