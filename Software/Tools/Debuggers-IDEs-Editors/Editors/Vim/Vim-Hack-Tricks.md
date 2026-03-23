# Vim Hack Tricks

See [[Vim-Cheatsheet]] for glossary

## (Un)Comment a line

From [gist Hemrajbhattarai comment to (un) comment multiple lines vim](https://gist.github.com/ultim8k/d8326a0cd7646356acf0dc3baf8e78ff) - [Hemrajbhattarai](https://gist.github.com/Hemrajbhattarai)
1. Get the first and last line number to affect
2. `:1,10s/^/\/\/` or what comment symbol required
3. Press enter


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
[gist Hemrajbhattarai comment to (un) comment multiple lines vim](https://gist.github.com/ultim8k/d8326a0cd7646356acf0dc3baf8e78ff)