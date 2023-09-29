# JQ

Both introduced to `jq` and as a continuation of techniques in [Ippsec's: Manually Parse Bloodhound Data with JQ to Create Lists of Potentially Vulnerable Users and Computers](https://www.youtube.com/watch?v=o3W4H0UfDmQ) where Ippsec: *"Think like a list instead of a graph"*
```bash
# Convert Integers
(.DotSomethingThatIsAnINT|tostring)
# Display all json nicely
cat *_users.json | jq .
# Put query at the end of the syntax
# Show the Keys 
cat *_users.json | jq '. | keys'
# Show all the data key
cat *_users.json | jq '.data'
# Show all the data key as a list - removes the external data{ ..json..}
cat *_users.json | jq '.data[]'
# Dump all names
cat *_users.json | jq '.data[].Properties | .name'
# All enabled accounts
cat *_users.json | jq '.data[].Properties | select( .enabled == true) | .name'
# All disabled accounts
cat *_users.json | jq '.data[].Properties | select( .enabled == false) | .name'
# All enabled accounts with descriptions may contain passwords
cat *_users.json | jq '.data[].Properties | select( .enabled == true) | select( .description != null) | .name + " " + .description'
# To a file; add if only enabled accounts
# select( .enabled == true) |
cat *_users.json | jq '.data[].Properties | .name' | tr -d '\"' | awk -F@ '{print $1}' > usernames.txt
# Get all account with SPNS then printing them 
# I argued with ChatGPT for atleast 30 minutes till I got this:
cat *_users.json | jq -r '.data[].Properties | {name: .name, SPNs: .serviceprincipalnames[]?}'

# Enumerating accounts approximate logons and pwdlastset 
# Beware lastlogon is not replicate between DC
# lastlogontimestamp is replicated every two weeks
# Avoid honeypots are never logged in!
# Bruteforce accounts?
cat *_users.json | jq '.data[].Properties | select( .enabled == true) | .name + " " + (.lastlogontimestamp|tostring)'
# Output where pwdlastset is greater 
cat *_users.json | jq '.data[].Properties | select( .enabled == true) | select(.pwdlastset > .lastlogontimestamp)| .name + " " + (.lastlogontimestamp|tostring) '
3
# Get all Kerberoastable accounts
cat *_users.json | jq '.data[].Properties | select( .serviceprinciplenames != []) | .name'

# Show all machines annd there OSes
cat *_computers.json | jq '.data[].Properties | .name +  ":" + .operatingsystem'
# Find all non Windows 10 pro
cat *_computers.json | jq '.data[].Properties | select( . operatingsystem != "Windows 10 Pro") |  .name +  ":" + .operatingsystem'

# Get all the hostnames and remove the ""
cat *_computers.json | jq '.data[].Properties | .name' | tr -d '\"' > $file.txt

# lastlogontimestamp for machine is the last time that machine was powered on
cat *_computers.json | jq '.data[].Properties | .name + ":" + (.lastlogintimestamp|tostring)'
# use EpochConverter too convert
# Check which machine have been on compared to a epoch
cat *_computers.json | jq '.data[].Properties | select( .lastlogintimestamp > $EPOCH) | .name'
```

## References

[Ippsec: Manually Parse Bloodhound Data with JQ to Create Lists of Potentially Vulnerable Users and Computers](https://www.youtube.com/watch?v=o3W4H0UfDmQ))