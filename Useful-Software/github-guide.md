# Github Security

Password got included in some field or log file and you are already panicing. 
As soon as possible:

[Thanks Antonio Petricca](https://stackoverflow.com/questions/5099333/git-accidental-inclusion-of-password-how-do-i-fix-it#5099338i)
```bash
git log --oneline -S <COMMIT_SEARCH_PATTERN>

# Copy the commit hash

git rebase - i <COMMIT_HASH>~1

# Change the marker to **drop**
# Exit from the editor

git rebase --continue
git push --force
```

