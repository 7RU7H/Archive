# Git-filtration

For more regular usage of of `git` see [[Github-guide]], some of the same command will be listed here to aid in potential data exfiltration, but also privilege escalation method. For the [[Data-Exfiltration-Defined]] requires a method to Exfiltrate, is also capable of resending back to Infiltrate; for the [[Linux-Privilege-Escalation]] or [[Windows-Privilege-Escalation-Vectors]] methods to work requires both Infiltration method and an execution vector in the context of the laterial or elevated privilege. 

## Exfiltration

```bash
# ssh
GIT_SSH_COMMAND='ssh -i /path/id_rsa' git clone git@$ip:/path/to/vulnGit
```

## Infiltration & Backdooring

```bash
cd vulnGit/
# insert backdooring method here
# Consider impersonation attacking the user and email
git log
git config --global user.name ""
git config --global user.email "user@Nomail.(none)" # Without email
# Don't forget to revert, if required
git add -A 
git commit -m "A message in a git repo that aligns with objectives"
# 
GIT_SSH_COMMAND='ssh -i /path/id_rsa' git push origin master
```