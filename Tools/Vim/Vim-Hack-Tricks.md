# Vim Hack Tricks
See [[Vim-Cheatsheet]] for glossary

## Macro Expand Users.txt
From the [Ippsec Sauna Video](https://www.youtube.com/watch?v=uLNpR3AnE-Y)
Have a basic list of the users and need to create a expanded variation of usernames:
Start with `Vim Hack` -> `Vim Hack, Vim.Hack, VHack, V.Hack`
1. `q` + `a` to start macro
2. `yy` to yank line
3. `<number-of-variations` + `p`
4. `0` to move cursor to leftmost index  `/[spacebar]` press `[enter]` + `s` + `.` + `ESC`
5. `[DownArrow]` + `0` + `[RightArrow]` + `d` + `w`
6. `[DownArrow]` + `0` + `[RightArrow]` + `d` + `w` + `i` insert `.`
7. `[DownArrow]` + `ESC` + `q` to exit recording mode
8. `@a` to replay




## References

[Ippsec Sauna Video](https://www.youtube.com/watch?v=uLNpR3AnE-Y)