# Github

For hacking Github Repositories see [[Git-Repository-Extraction]]

## AAARGH.. breath just use the correct git commands

```bash
# Check local repo status to its remote hosted on github
git status -uno
git branch # display branches

# Are you really sure the local is ahead of the remote?
# Push once, measure twice - DOUBLE CHECK!
git push --all -f
```

## Git not recording pushes?
[StackOverflow - Johnathan Chad Faling](https://stackoverflow.com/questions/15289768/github-commits-arent-recorded-in-the-your-contributions-calendar#19384175)
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
Beware it will amend. No jokes. [Primeagen](https://www.youtube.com/c/ThePrimeagen)
```bash
git commit --amend --no-edit
```

## Pull requests with Snovvcrash

Syncing a forked repository:
```bash
# Add remote upstream
$ git remote add upstream https://github.com/original/repository.git
$ git fetch upstream
$ git rebase upstream/master (or git merge upstream/master)

# Update fork from original repo
$ git pull upstream master

# Push the updates to fork
$ git push -f origin master
```

Working with a repository during a pull request:
```bash
$ git remote add upstream https://github.com/original/repository.git
$ git fetch upstream
$ git rebase upstream/master
$ git checkout upstream/master
$ git checkout -b new-feature
...Make changes...
$ gc -am "Add a new feature"
$ git push -u origin new-feature
```

Signing Git Commit from - [Nick Janetakis - GPG key pair](https://www.youtube.com/watch?v=1vVIpIvboSg) and [Nick Janetakis - Signing and Verifying Git Commits on the command line and Github](https://www.youtube.com/watch?v=4166ExAnxmo)
```bash
# Cache passphrase in gpg agent (dirty):
$ cd /tmp && touch aaa && gpg --sign aaa && rm aaa aaa.gpg && cd -
```

## References


[SnovvCrash's Pentester's Promiscuous Notebook](https://ppn.snovvcrash.rocks/admin/git)
[Nick Janetakis - GPG key pair](https://www.youtube.com/watch?v=1vVIpIvboSg)
[Nick Janetakis - Signing and Verifying Git Commits on the command line and Github](https://www.youtube.com/watch?v=4166ExAnxmo)
[Primeagen](https://www.youtube.com/c/ThePrimeagen)
[StackOverflow - Antonio Petricca](https://stackoverflow.com/questions/5099333/git-accidental-inclusion-of-password-how-do-i-fix-it#5099338i)
[StackOverflow - Johnathan Chad Faling](https://stackoverflow.com/questions/15289768/github-commits-arent-recorded-in-the-your-contributions-calendar#19384175)
[Github Documentation](https://docs.github.com/en)