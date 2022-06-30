## Linux-Concepts
For more specific articles:

[[Linux-File-System]]
[[Linux-Permissions]]
[[Linux-Networking]]
[[Linux-Network-Services]]
[[Linux-Processes]]
[[Linux-Common-File-Extensions]]
[[Core-Linux-Commands]]
[[Useful_Bash]]
[[Linux-Tricks]]

# Useful terminal hotkeys
```
[ALT]+"." 			repeat last argument in bash terminal
[CTRL]+L			quick clear termimal
[CTRL]+u			clear current input line
[CTRL]<left/right-arrowkey>	skip to next spaced delimitered word
[CTRL]+c			ABORT ABORT!
```

# Basic
```bash
var=somedata
alias name='Put your commands here'
./                      to run a bash script program
/dir/dir/file -p        to excute
/etc/bin/file           to execute a bin
```

# Bash Operators 101 
See [[Useful_Bash]]
```bash
& run command in the  background
&& cmd1 && cmd2 !! cmd1 has to be successful for next command to run
> x > y"2" if x(y"1") overwrites the 1st version
>> is the same as the above but appends and does not overwrite
```



# PIPING & STDIN, STDOUT, STDERR
```bash
STDIN(0), STDOUT(1), STDERR(2) 
/proc/self/fd/(0/1/2)
<0>
<1>
<2> 
2>/dev/null

&> == > file 2>&1 # open file in write-only mode oon file descriptor(FD) 1 and duplicate FD1 to the FD2 so that FD1 and FD2(stdout, stderr) point to that open file description
0>&1 == 0<&1 or <&1 # adds 0 stdin to list duplicate FD1 to 0 as well as FD0 is mode to point to the same resourcce
```


# Wildcards 
```bash
*		wildcards
ls -l *a	files beginning with a
ls -l *a* 	files containing a
mv *txt dir	move all .txt files dir
```
