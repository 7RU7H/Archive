# Github

## Git not recording pushes?
[Stackoveranswer](https://stackoverflow.com/questions/15289768/github-commits-arent-recorded-in-the-your-contributions-calendar#19384175)
```bash
git config --global user.email youremail@email.com 
```


## Github Security
Password got included in some field or log file and you are already panicing. As soon as possible:

[Thanks Antonio Petricca](https://stackoverflow.com/questions/5099333/git-accidental-inclusion-of-password-how-do-i-fix-it#5099338i)
```bash
git log --oneline -S <COMMIT_SEARCH_PATTERN>

# Copy the commit hash

git rebase -i <COMMIT_HASH>~1

# Change the marker to **drop**
# Exit from the editor

git rebase --continue
git push --force
```

## Forget to add something to the commit 
Beware it will amend. No jokes.
Primegen](https://www.youtube.com/c/ThePrimeagen)
```bash
git commit --amend --no-edit
```