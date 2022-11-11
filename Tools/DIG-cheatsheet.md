```bash
dig -x $ip @ip
dig $domain @ip $record_type
dig $domain # Query "A" recond
dig $domain +short # Query "A" recond, plus less verbose
dig $domain  MX # Query "MX" reconds
dig $domain SOA # Query "SOA" recond
dig $domain TTL # Query "TTL" recond
dig -x $domain +short  # Perform a DNS reverse look-up recond option short
dig $domain_one ns +noall +answer domain_two txt +noall +answer # Query multiple records
# Store defaults in a .digrc in $HOME
```


## References

[Neverendingsecurity](https://neverendingsecurity.wordpress.com/2015/04/13/dig-commands-cheatsheet/)