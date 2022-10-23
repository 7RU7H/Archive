
# iptables and ip6tables


Commands:
```bash
iptables # IPv4
ip6tables # IPv6

--line-numbers 	# retrieve line numbers

-L chain # lists the rules in the chain use with the `-n` option to diable name resolution
-N chain # creates a new chain
-X chain # deletes an empty and unused chain
# Rules are processed linear precedence! 
-A chain rule # adds a rule at the end of a chain
-I chain rule_num # rule inserts a rule before the rule number _rule_num_  

-D chain rule_num # (or `-D chain rule`) deletes a rule in a chain, either number or contents
-F chain # a flushes a chain (deletes all its rules)
-P chain action # defines the default action - "policy" for a given chain only standard chains can have policies. 
```

Rules are expressed as `conditions -j action action_options`, where several conditions are described in the same rule, then the criterion is the conjunction (logical _AND_) of the conditions, which is at least as restrictive as each individual condition.

Negating conditions by prefixing a condition with `!`
Conditions:
```bash
-p # matches any packet  
-s $($address | $network_mask) # matches source address
-i $interface # matches interface
--state $state # matches state of packet; requires the "ipt_conntrack" kernel module
	NEW # state describing packets starting a new conection
	ESTABLISHED # matches packets already existing
	RELATED # mactch packets initating a new connection to pre-existing connection

```