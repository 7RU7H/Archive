# Vim Cheatsheet 

```bash
q+a [record macro] + esc [to end recording then exec with] @a
```

# Source: vim.rtorr.com
[Reference](vim.rtorr.com)
Exiting
```vim
:w 	write (save) the file, but don't exit
:wq 	write (save) and quit
:x 	write (save) and quit
:q 	quit (fails if there are unsaved changes)
:q! 	quit and throw away unsaved changes
:qa 	quit all buffers and windows
ZZ 	write (save) current file, if modified, and quit
ZQ 	quit without checking for changes
```
Cursor Movement
```vim
h 	move cursor left
j 	move cursor down
k 	move cursor up
l 	move cursor right
w 	jump forwards to the start of a word
W 	jump forwards to the start of a word (words can contain punctuation)
e 	jump forwards to the end of a word
E 	jump forwards to the end of a word (words can contain punctuation)
b 	jump backwards to the start of a word
B 	jump backwards to the start of a word (words can contain punctuation)
0 	jump to the start of the line
^ 	jump to the first non-blank character of the line
$ 	jump to the end of the line
G 	go to the last line of the document
nG 	go to line number n
:n 	go to line number n
'' 	To the position before the latest jump, / where the last "m'" / "m`" command was given.
fx 	jump to next occurrence of character x
tx 	jump to one character before the character x
} 	jump to next paragraph
{ 	jump to previous paragraph
H 	jump to home (top) of screen
L 	jump to last line of screen
M 	jump to middle of screen
3, f, x 	jump to 3rd instance of character x forward from cursor on current line.
3, F, x 	jump to 3rd instance of character x back from cursor on current line.
``` 
Screen Movement
```vim
Ctrl u 	move screen up by half page
Ctrl b 	move screen up by one page
Ctrl d 	move screen down by half page
Ctrl f 	move screen down by one page
zz 	center screen on cursor
zt 	align top of screen with cursor
zb 	align bottom of screen with cursor
``` 
Insert Mode - Inserting/Appending Text
```vim
i 	insert before the cursor
I 	insert at the beginning of the line
a 	insert (append) after the cursor
A 	insert (append) at the end of the line
o 	append (open) a new line below the current line
O 	append (open) a new line above the current line
ea 	insert (append) at the end of the word
Esc 	exit insert mode
``` 
Editing
```vim
r 	replace a single character
J 	join line below to the current one
cc 	change (replace) entire line
cw 	change (replace) to the end of the word
c$ 	change (replace) to the end of the line
s 	delete character and substitute text
S 	delete line and substitute text (same as cc)
xp 	transpose two letters (delete and paste)
u 	undo
Ctrl r 	redo
. 	repeat last command
``` 
Cut and Paste
```vim
yy 	yank (copy) a line
2yy 	yank (copy) 2 lines
:n,Ny 	yank lines n through N
yw 	yank (copy) word
y$ 	yank (copy) to end of line
p 	put (paste) the clipboard after cursor
P 	put (paste) before cursor
dd 	delete (cut) a line
2dd 	delete (cut) 2 lines
:n,Nd 	delete lines n through N
dw 	delete (cut) word
D 	delete (cut) to the end of the line
d$ 	delete (cut) to the end of the line
x 	delete (cut) character
``` 
Search and Replace
```vim
* 	search for word under cursor
/pattern 	search for pattern
?pattern 	search backward for pattern
n 	repeat search in same direction
N 	repeat search in opposite direction
:%s/old/new/g 	replace all old with new throughout file
:%s/old/new/gc 	replace all old with new throughout file with confirmations
``` 
Marking Text (Visual Mode)
```vim
v 	start visual mode, mark lines, then do a command (like y-yank)
V 	start linewise visual mode
vo 	move to other end of marked area
Ctrl v 	start visual block mode
vO 	move to other corner of block
vaw 	mark a word
vab 	mark a block with ()
vaB 	mark a block with {}
vib 	mark inner block with ()
viB 	mark inner block with {}
Esc 	exit visual mode
``` 
Visual Commands
```vim
> 	shift text right
< 	shift text left
== 	auto-indent current line
<< 	shift current line left by shiftwidth
>> 	shift current line right by shiftwidth
y 	yank (copy) marked text
d 	delete marked text
~ 	switch case
``` 
Working with Multiple Files
```vim
:e filename 	edit a file in a new buffer
:ene 	open a blank file for editing
:bnext / :bn 	go to the next buffer
:bprev / :bp 	go to the previous buffer
:bd 	delete a buffer (close a file)
:sp filename 	open a file in a new buffer and split window
:vs filename 	open a file in a new buffer and vertically split window
Ctrl w, s 	split window
Ctrl w, w 	switch windows
Ctrl w, q 	quit a window
Ctrl w, v 	split window vertically
Ctrl w, h 	move cursor to window left
Ctrl w, l 	move cursor to window right
Ctrl w, k 	move cursor to window above
Ctrl w, j 	move cursor to window below
Ctrl w, r 	rotate windows clockwise
Ctrl w, T 	move current window to a new tab
:on 	close all windows except current window
Ctrl w, | 	maximize width of active window
Ctrl w, 1, | 	minimize width of active window
Ctrl w, _ 	maximize height of active window
Ctrl w, 1, _ 	minimize height of active window
Ctrl w, = 	equalize size of windows
``` 
Tabs
```vim
#gt 	move to tab number #
Ctrl w, t 	move the current split window into its own tab
:tabmove # 	move current tab to the #th position (indexed from 0)
:tabnew filename / :tabn filename 	open a file in a new tab
:tabclose / :tabc 	close the current tab and all its windows
:tabonly / :tabo 	close all tabs except for the current one
gt / :tabnext / :tabn 	move to the next tab
gT / :tabprev / :tabp 	move to the previous tab
Registers
:reg / :registers 	view all current registers
echo @r 	access register `r` as a variable
"/ 	last search pattern register
"_ 	the black hole register
"0 	last yank register
"1 	last big delete register
"2-"9 	big delete register stack
"+ 	system clipboard
"- 	small delete register
"a-"z 	named registers
"A-"Z 	append registers
qr 	record into register `r`
``` 
Additional Ex Commands
```vim
:mak / :make 	run a compiler and enter quickfix mode
:! 	execute external shell command
:r / :read 	read external program output into current file
:x,ymz 	move lines x through y to z (delete + put)
:x,ytz 	yank lines x through y and put to z (yank + put)
:. 	current line (cursor location)
:$ 	last line (bottom of file)
:0 	first line (top of file)
:ls 	list all open files
:%TOhtml 	create html representation of current working buffer
``` 
Basic Configuration
```vim
:set nu 	show line numbers
:set hid 	lets you switch buffers without saving
:set hls 	highlight search matches
:set sc 	show commands as you type them
:set ru 	show line and column number of the cursor
Folding Commands
zf#j 	creates a fold from the cursor down # lines
zf/ 	string creates a fold from the cursor to string
zj 	moves the cursor to the next fold
zk 	moves the cursor to the previous fold
za 	toggle a fold under cursor
zo 	opens a fold at the cursor
zO 	opens all folds at the cursor
zc 	closes a fold under cursor
zm 	increases the foldlevel by one
zM 	closes all open folds
zr 	decreases the foldlevel by one
zR 	decreases the foldlevel to zero -- all folds will be open
zd 	deletes the fold at the cursor
zE 	deletes all folds
[z 	move to start of open fold
]z 	move to end of open fold
``` 
