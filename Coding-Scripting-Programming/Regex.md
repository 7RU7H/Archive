# Regex


[This THM room that I learnt  about regexes in cli from](https://tryhackme.com/room/catregex). Still very sad.

## Regex101
 https://regex101.com/


For  >= 8 character containing atleast one of each: uppercase letter, lowercase letter and digits

```
(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/)
```

