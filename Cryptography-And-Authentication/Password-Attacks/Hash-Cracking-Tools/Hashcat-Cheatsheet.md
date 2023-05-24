# Hashcat Cheatsheet

[Hashcat's example hashes](https://hashcat.net/wiki/doku.php?id=example_hashes)


[Hashcat Rule-Based Attack](https://hashcat.net/wiki/doku.php?id=rule_based_attack) documentation states: *"The rule-based attack (-a 0 with one or more -r rules files) is one of the most complicated of all the attack modes. The reason for this is very simple. The rule-based attack is like a **programming language** designed for password candidate generation. It has functions to modify, cut or extend words and has conditional operators to skip some, etc. That makes it the most flexible, accurate and efficient attack."* To avoid simple copy and paste I suggest using the documentation as guide when developing rules, but I will try to cultivate community tricks and tips 

[Ippsec Recommends:](https://www.youtube.com/watch?v=H9FcE_FMZio)
```bash
# Use a wordlist along side cracking
-r */InsidePro-Password.rule
```

[Wordlist creation](https://infinitelogins.com/2020/11/16/using-hashcat-rules-to-create-custom-wordlists/)
```bash
# Example download one the OneRuleToRuleThemAll a powerful rule
curl -L https://raw.githubusercontent.com/NotSoSecure/password_cracking_rules/master/OneRuleToRuleThemAll.rule -o OneRuleToRuleThemAll.rule 
# Remove the case insensitive duplicates to save on attempts later
cat password_base_list.txt | uniq -i > better_base_password_list.txt
# Create wordlist with hashcat 
hashcat --force better_base_password_list.txt -r OneRuleToRuleThemAll.rule  --stdout > Bpbl-ORTRTA.txt 
# Reduce again just because 
cat Bpbl-ORTRTA.txt | uniq > Bpbl-ORTRTA.txt
```

[infinitelogins](https://infinitelogins.com/2020/11/16/using-hashcat-rules-to-create-custom-wordlists/) favourite masking attacks
```bash
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?s?d?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?l?s?d?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?l?s?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?s?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt -1 ?u?l ?1?1?1?s?d?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt -1 ?u?l ?1?1?1?1?s?d?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?l?d?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?l?l?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?d?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?l?d?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?l?l?d?d
hashcat -m 1000 -a 3 hashes\users.txt ?u?l?l?l?l?l?l?d
hashcat -m 1000 -a 3 -1 ?u?l hashes\users.txt ?1?1?1?1?1?1?d?s
hashcat -m 1000 -a 3 -1 ?u?l hashes\users.txt ?1?1?1?l?d?d?d?d
hashcat -m 1000 -a 3 -1 ?u?l hashes\users.txt ?1?1?1?d?d?d?d?s
hashcat -m 1000 -a 3 -1 ?u?l hashes\users.txt ?1?1?1?d?d?d?d?s
hashcat -m 1000 -a 3 -1 ?u?l hashes\users.txt ?1?1?1?l?d?d?d?d?s
hashcat -m 1000 -a 3 -1 ?u?l hashes\users.txt ?1?1?1?l?d?d?s?s
hashcat -m 1000 -a 3 -1 ?u?l hashes\users.txt ?1?1?1?1?d?d?d?s
```


## References

[Hashcat's example hashes](https://hashcat.net/wiki/doku.php?id=example_hashes)
[Hashcat Rule-Based Attack](https://hashcat.net/wiki/doku.php?id=rule_based_attack) 
[Ippsec Hashcat Rule Recommendation](https://www.youtube.com/watch?v=H9FcE_FMZio)
[infinitelogins](https://infinitelogins.com/2020/11/16/using-hashcat-rules-to-create-custom-wordlists/)