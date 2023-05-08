# Hashcat Cheatsheet

[Hashcat's example hashes](https://hashcat.net/wiki/doku.php?id=example_hashes)


[Hashcat Rule-Based Attack](https://hashcat.net/wiki/doku.php?id=rule_based_attack) documentation states: *"The rule-based attack (-a 0 with one or more -r rules files) is one of the most complicated of all the attack modes. The reason for this is very simple. The rule-based attack is like a **programming language** designed for password candidate generation. It has functions to modify, cut or extend words and has conditional operators to skip some, etc. That makes it the most flexible, accurate and efficient attack."* To avoid simple copy and paste I suggest using the documentation as guide when developing rules, but I will try to cultivate community tricks and tips 

[Ippsec Recommends:](https://www.youtube.com/watch?v=H9FcE_FMZio)
```
-r */InsidePro-Password.rule
```


## References

[Hashcat's example hashes](https://hashcat.net/wiki/doku.php?id=example_hashes)
[Hashcat Rule-Based Attack](https://hashcat.net/wiki/doku.php?id=rule_based_attack) 
[Ippsec Hashcat Rule Recommendation](https://www.youtube.com/watch?v=H9FcE_FMZio)