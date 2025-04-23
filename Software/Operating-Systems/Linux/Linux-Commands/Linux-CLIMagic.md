Original found this from https://github.com/muckitymuck/OSCP-Study-Guide/blob/master/os/useful_commands.md. These are just incredible.

# Useful commands By [@climagic](https://twitter.com/climagic)

- See who's on the Starbucks...

```bash
❯❯  tshark -ni en0 -Y "bootp.option.type == 53" -T fields -e bootp.option.hostname -e eth.src_resolved
```

- Stop the execution of pid 5149. Same as if you pressed Ctrl-Z in the shell. Resume execution with kill -CONT 5149

```bash
❯❯ kill -STOP 5149
```

- Find world readable files under CWD that have "password=" in them

```bash
❯❯ find . -type f -perm /o=r -print0 | xargs -0 grep -l password=
```

- Random curses

```bash
#!/usr/bin/python
import curses as c
import random as r
s = c.initscr()
w = c.newwin(3,7,9,9)
w.border()
while 1:
    c = s.getch()
    if (c == 32): # Press Spacebar
        w.mvwin(r.randint(2,25),r.randint(2,70))
    w.addstr(1,1,"F@*K!")
    w.refresh()
```

- Next time your publishing friends say they can't use the command line, let them know about

```bash
❯❯ https://t.co/XrfO5M9MbY
```

- The ? matches any one character in that place, * matches 0 or more of any character

```bash
❯❯ ls -l 091?17*.jpg
```

- sshfs is a util that uses FUSE and SSH to mount a remote directory as a local one.

```bash
Deb: ❯❯ apt-get install sshfs
Mac OSX: ❯❯ brew install sshfs
Red Hat: ❯❯ yum install fuse-sshfs
Yes Arch too: ❯❯ pacman -S sshfs

❯❯ sshfs user@remotehost: /remotedir localdir
```

- Sort data.csv by the 5th column's numeric values in descending order

```bash
❯❯ sort -t, -k5nr data.csv | less
```

- Count how many times per second the word love is used on Twitter in real time.

```bash
❯❯ t stream search -l love |pv -l  >/dev/null
```

- Forgot your pres. remote ? use your phone

```bash
❯❯ ssh machine "while read -r; do DISPLAY=:0 xdotool getactivewindow key space; done
```

- Math properties of 0 and unset variables

(disclaimer: I received $0 for this tweet and have not "sold out")

```bash
❯❯ echo $((you**IBM))
```

- Edit binary files in a vi like editor

```bash
❯❯ bvi GANDALF.CHA
```

- Setup vim so that scrolling within a file will provide 5 lines of preceding context before the cursor

```bash
❯❯ :set scrolloff=5
```

- Make your own spooky noises with sox

```bash
❯❯ play -n synth sin 900 bend 0.3,800,1 bend 1.2,-150,1 trim 0 3.5 reverb -w
```

- Get the creation date of a domain. Happy anniversary Slashdot

```bash
❯❯ whois slashdot.org | awk '/Creation Date/{print $NF}'
```

- Print the first 5 log lines from each day in syslog

```bash
❯❯ awk 'a[$1 $2]++ < 5' /var/log/system.log
```

- Please watch my recent presentation on using awk to analyze logs from the @Bro_IDS

```bash
❯❯ https://t.co/eAOg5uEehJ
```

- Print the longest line in quotes.txt

```bash
❯❯ awk 'length > max { max=length;maxline=$0 } END { print maxline; }' quotes.txt
```

- Can't wait for the next paycheck? I made 100MB in 5 seconds working from the comfort of my own home

```bash
❯❯ yum makecache fast
```

- Posting this just because it's so awesome. :-)

```bash
❯❯ https://t.co/5NFbDt1gmF
```

- Generate line stats of a problem over time in old logs. FIXED

```bash
❯❯ for i in log.{48..1}.gz ; do printf "$i\\t" ; zgrep problem $i | wc -l ; done
```

- Alt. way you can exclude items from a glob match is to expand the glob with Ctrl-x * and then just remove the items you don't want

```bash
❯❯ [C-x] *
```

- Measure the disk space used by directories starting with a-m, skip exports dir

```bash
❯❯ du -sh [a-m]*/ --exclude=export/
```

- Measure the disk space used by directories AND FILES starting with a-m, skip export dir

```bash
❯❯ du -sh -I export [a-m]*
```

- Decode a hex encoded string

```bash
❯❯ echo %42%65%20%63%61%72%65%66%75%6c%20%77%68%61%74%2f%68%6f%77%20%79%6f%75%20%64%65%63%6f%64%65%0a | xxd -p -r
```

- Show a list of the other candidates for an open source SMB service. Happy 25 Years Samba!

```bash
❯❯ look . | egrep "^s.*m.*b" | egrep "^.{4,9}$
```

- Stats for most common DOW for these wav files between May and Sept

```bash
❯❯ ls 2017-0[5-9]-??.wav |cut -c 1-11 |date -f- +%A |sort|uniq -c|sort -nr
```

- Base conversion: calculate binary 1101 ...

```bash
❯❯ printf '%x\\n' $((2#1101))
```

- Please raise your bar for what you consider proof of pwn

```bash
❯❯ clear ; printf "root@www.equifax.com # "; sleep 1 ; scrot -bu CanBeFaked.png
```

- This is an easy way to join a file into one line if you're in a hurry. Be careful with large data though, might truncate

```bash
❯❯ xargs < file.txt
```

- compare folder contents and show the difference @climagic

```bash
❯❯  diff -rq dir1 dir2
```

- This will load your key into the ssh-agent session so that you can login to hosts without requiring your passphrase each time

```bash
❯❯ ssh-add
```

- Have more than one tmux sessions running? Start tmux first and this keystroke lets you choose other tmux sessions easily

```bash
❯❯ [Ctrl-b] s
```

- Fixed headline for a @zackwhittaker article

```bash
❯❯ elinks https://t.co/TOoyPwWBsx |sed -e 's/Apache Struts security flaw/the fact that/' |less
```

- Sometimes error text scrolls by too fast and you can't read it. Try sending STDOUT to /dev/null to see STDERR

```bash
❯❯ column -t log > /dev/null
```

- Did you know that if your output from 'less' is a pipe, it behaves like cat

```bash
❯❯ less log log.2 log.3 | grep " 404 " | more
```

- Sometimes in cases where columns are truncated, you can make them visible by passing output through cat

```bash
❯❯ dpkg -l '*4.10.0*' | cat
```

- Run sudo on the last command in your history. Be careful though. `<Up Arrow > & [Ctrl-a]` sudo can be fast too and perhaps safer

```bash
❯❯ sudo !!
```

- Infinite "music"

```bash
❯❯ perl -e \'use bytes; for($t=0;;$t++){ print chr($t*(($t > >13|$t > >8)&30&$t > >4)); }\' | play -t raw -b8 -r8k -e un - vol 0.5
```

- "Infinite" data breach

```bash
❯❯ while :;do rig |head -1 |tr \'\\n\' ,;echo $RANDOM{,,,,} |tr -d \' \' ;done |sed -r -e \'s/,(...)(..)(....).*/,\\1-\\2-\\3/\'
```

- 39 character infinite ASCII maze generator

```bash
❯❯ grep -ao "[/\\\\]" /dev/urandom|tr -d \\\\n
```

- Pretend you are on a starship (Uses sox)

```bash
❯❯ play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +30 fade h 1 86400 1
```

- Rename all non-hidden files under current directory by replacing spaces with underscores. Uses Larry Wall's 'rename

```bash
❯❯ rename 's/ /_/g' *
```

- Create an alias for awk that includes your own custom awk functions

```bash
❯❯ alias ohmyawk='awk -i ~/.awk/myfunctions'
```

- Show the most recent 20 lines of dmesg with the times converted to local human readable times

```bash
❯❯ dmesg -T | tail -n20
```

- Bro_IDS cols by name in awk

```bash
❯❯ awk -F\\\\t \'/^#fields/{for (i=2;i&lt;=NF;i++){bro[$i]=i-1}} {print $bro["=ts"] FS $bro["id.resp_h"]}\' http.log
```

- Remove all the exif metadata tags from photo.jpg to improve privacy before uploading. Thanks @dmpop

```bash
❯❯ exiftool -all= photo.jpg
```

- If you can't make it to watch totality

```bash
❯❯ stellarium --sky-date 20170821 --sky-time 14:27:00 --longitude 87.342581W --latitude 36.782564N
```

- Solve the basic arithmetic CAPTCHA

```bash
❯❯ elinks -dump https://t.co/FfH8nmk7pB | awk -F: '/Math question:/{print $2}' | bc
```

- Get a list of 10/8 internal IPs showing up in col 3 or 4

```bash
❯❯ awk '$3~/^src:10\\./{print $3};$4~/^dest:10\\./{print $4}' network.log |sort |uniq
```

- Poly synth. Press asdfghj. Uses sox

```bash
❯❯ n=CDEFGAB;l=asdfghj;while read -n1 k;do x=$(tr $l $n < $k);play -qn synth pl ${x}3 fade 0 .7 & done
```

- Asked 5 years ago this month

```bash
❯❯ elinks https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor | grep viewed
```

- Maybe this is the problem. The vi man page doesn't even mention how to quit

```bash
❯❯ man vi | grep -i quit
```

- Breakup large log by syslog month/day and recompress

```bash
❯❯ zcat month.log.gz | awk \'{print $0 | "gzip -v9c > brokenup.log-"$1"_"$2".gz"}\'
```

- What speakers are not on the attendees list

```bash
❯❯ comm -23 <(sort speaker.emails |tr A-Z a-z |uniq) <(sort attendee.emails |tr A-Z a-z |uniq)
```

- GNU

```bash
❯❯ Geez, it sure does take a while for sort to print its help information." (Hint: It\'s --help)
```

- Format a list of emails so that when you paste them into Outlook (ugh!), it breaks them up into individual addrs

```bash
❯❯ tr $'\\n' \\; < email-list
```

- Produce stats on how many images you took on each day, regardless of strange filenaming schemes

```bash
❯❯ stat -c %y *.jpg | cut -c1-10 | uniq -c
```

- Produce stats on how many photos you took on each day to help find the ones in large batches

```bash
❯❯ ls -1 20170*.JPG| cut -c1-8 | uniq -c
```

- Print out the total local disk space you are using. Thanks @inc002

```bash
❯❯ df -lk | awk \'/^\\//{ SUM += $3 } END { print SUM/2**20 " GiB" }\'
```

- Get a list of instructors from a webpage

```bash
❯❯ elinks -dump-width 1000 -dump https://t.co/Jd20vFLeRk | awk -F: '/Instructor/{print $2}'
```

- You can put this in your shell rc to *help* protect yourself *specifically* from :(){ :|:& };:

```bash
❯❯ :(){ true; };readonly -f :
```

- Generate a list of the emails($3) of speakers($8) in an attendee file

```bash
❯❯ awk -F\\\\t -v IGNORECASE=1 '$8~/speaker/{print $3}' attendees.tsv
```

- Use -D to create a SOCKS5 tunnel inside your SSH connection. Some programs (like a web browser) can use these

```bash
❯❯ ssh -D 1917 you@remoteho.st
```

- Using a \\ before a command also turns off programmable auto tab completion when the extension is not recognized

```bash
❯❯ \\mpg123 audio<TAB >
```

- cd with no arguments will return you to $HOME

```bash
❯❯ cd
```

- Watch the Unix clock in style as it approaches 1.5 billion seconds.  >10 hours to go

```bash
❯❯ while date +%s | figlet ; do sleep 1 ; clear ; done
```

- Backup pictures while on travel, but exclude larger RAW images for now

```bash
❯❯ rsync -zav -e ssh . user@remote:europe-backup/ --exclude='*.CR2'
```

- Render #markdown in the shell.

```bash
❯❯ function mdr() { pandoc $1 | lynx -stdin -dump }
```

- Kill process if its not updating files (5 min)

```bash
❯❯ [[ $( find $HOME/output -type f -mmin -5 | wc -l ) -eq 0 ]] && pkill -f '/usr/bin/whatever'
```

- Using your group privilege, mount (removable drive) /dev/sdc1 as if it automounted with its name

```bash
❯❯ udisksctl mount -b /dev/sdc1
```

- Check the weather for the next few days in Alexandria

```bash
❯❯ curl http://wttr.in/Alexandria
```

- A "rainbow" in your shell

```bash
❯❯ yes "$(seq 231 -1 16)" | while read i; do printf "\\x1b[48;5;${i}m\\n"; sleep .02; done
```

- Get YT autogen subtitles

```bash
❯❯ youtube-dl --write-auto-sub -f 139 -o subtitles CUdwDEKlDrw; grep '<c.color' subtitles.en.vtt|sed 's/<[^ >]\\+ >//g'
```

- Print a list of all the classes defined in a #Java jar

```bash
❯❯ jar tvf path/to/some.jar | awk '{print $NF}
```

- If your Linux device names are long enough that it wraps lines, try using -hP and pipe to column for nicer output

```bash
❯❯ df -hP | column -t
```

- Randomware

```bash
❯❯ dd if=/dev/random of=dont-run-this.bin bs=128 count=$RANDOM ; chmod a+x dont-run-this.bin
```

- Show how many emails are distinctly on the CTSC sw vuln list for @TrustedCI

```bash
❯❯ comm -13 <(sort announce-inf-l) <(sort announce-sw-l) | wc -l
```

- Sed explained with examples

```bash
❯❯ https://t.co/7ZyB9d2d2K
```

- Print the number and column name to help write awk expressions

```bash
❯❯ head -1 data.csv | tr , $'\\n' | nl
```

- Use rlwrap to add readline functionality to nc (or other cmds). Thx rk[ghost] on

```bash
❯❯ rlwrap nc smtp.example 25
```

- Pause execution of any process called render. As if you pressed Ctrl-Z in shell. Resume with 'killall -CONT render

```bash
❯❯ killall -STOP render
```

- Finish a download started by a previous instance of wget, or even by another program. 56K respect

```bash
❯❯ wget -c https://t.co/dEZYMEPAH5
```

- Tell the Linux kernel that there have been partition table changes. Great when running live after fdisk

```bash
❯❯ sudo partprobe
```

- Find out what country/state/city an IP is probably "located" in. No browser required (geoip-bin dpkg)

```bash
❯❯ geoiplookup 73.250.181.107
```

- How to "make" /dev/one (377 in octal is 0xFF hex or all 8 bits on, but you knew that :)

```bash
❯❯ tr \'\\000\' \'\\377\' < /dev/zero
```

- For maps in your terminal from OpenStreetMap. Yes really. https://t.co/FckeNVD5Nm

```bash
❯❯ telnet mapscii.me
```

- Another TUI program providing network statistics in the terminal. Thx @maxmeranda @hholst80 for reminding me about this cool command

```bash
❯❯ bmon
```

- iptraf is a nice standalone real time network monitoring and stats utility for Linux that runs in the terminal

```bash
❯❯ iptraf
```

- Force each dd command in the process table to output its current status (blocks written, etc). The USR1 signal does this

```bash
❯❯ killall -USR1 dd
```

- Recover deleted files from /dev/sdc1. Right now I'm listening to "deleted" mp3s of Sigur Rós from a reused thumb drive

```bash
❯❯ photorec /dev/sdc1
```

- Show a 3 month view (last month, current month, next month) in the Linux and FreeBSD versions of cal

```bash
❯❯ cal -3
```

- Change less' binary view format to not use reverse video on 8-bit chars. Used this for a screenshot

```bash
❯❯ LESSBINFMT="*n<%02X >" less /bin/ls
```

- Duo from two geolocations on the same date. k1=dateuser k2=geolocation

```bash
❯❯ The last one prints cases where a user tries to authenticate to
```

- Print lines in log where epoch time (col 1) is before 8am or after 5pm EDT

```bash
❯❯ awk '($1 % 86400 < 43200 || $1 % 86400 > 75600) {print}' log
```

- Change to /pub and then change back to the dir you were in before. Thanks for the drinks @jed & @laufers

```bash
❯❯ cd /pub ; cd -
```

- World maps from OpenStreetMap right in your terminal w/ mouse support. Arrow keys & a/z to zoom, or mouse. Thx @adman_X

```bash
❯❯ telnet mapscii\\.me
```

- There is something kinda fun about using your mouse scroll wheel in elinks from anywhere

```bash
❯❯ elinks https://t.co/yBh9vXFUPq
```

- Print the Unicode emoticons block codes and symbols

```bash
❯❯ for i in 1F6{0..4}{{0..9},{A..F}} ; do printf "\\\\\\\\U$i \\U$i\\n" ; done
```

- Some commands send their help output to STDERR, Using |& in BASH 4+ sends STDERR to STDIN of next command

```bash
❯❯ snmpwalk -h |& grep OID
```

- TheUnixWay

```bash
❯❯ If you happen to use @HipChat (like at work), did you know you can use s/find/replace/ in it just like in sed?
```

- 2 commands, 1 grep

```bash
❯❯ { dig +short AAAA towel.blinkenlights\\.nl ; dig +short A towel.blinkenlights\\.nl; } | grep --color=always 42
```

- StarWars in ASCII. Also, towel!

```bash
❯❯ telnet towel.blinkenlights\\.nl
```

- infosec https://t.co/V6ubXhDywL

```bash
❯❯ [ Attacks Subtitle Parser ]
```

- Generate list of all authors in git repos under repos/

```bash
❯❯ for repo in repos/* ; do git -C "$repo" log | grep ^Author: ; done | sort | uniq
```

- Function to shorten this commonly used command line pattern & allow for options for final sort

```bash
❯❯ topuniq(){ sort|uniq -c|sort "${@:--rn}"; }
```

- Check fails from non-workplace

```bash
❯❯ awk -F, \'$6=="FAILURE" && $10 == "US" && $12 !~ /(Walla Walla|Crystal Lake)/\' duo-authentication-report.csv
```

- ImageMagick's command 'animate' allows you to view animated gifs direct from the URL

```bash
❯❯ animate http://climagic\\.org/images/rice-spinner.gif
```

- Add image to anim gif

```bash
❯❯ convert spin.gif -coalesce -gravity NorthEast -draw \'image over 0,0 0,0 "credit.png"\' -layers Optimize spin2.gif
```

- Set the search jump target to 10 lines down so that you see 9 previous lines of context on searches within less

```bash
❯❯ less -j10 /var/log/syslog
```

- You can use a bracketed command to pipe two find outputs into one tar

```bash
❯❯ { find /one; find /two; } | tar zcvf one-and-two.tar.gz -T -
```

- 7zip can also list the contents of iso images and extract them too. No need to mount the image

```bash
❯❯ 7z l philip-glass-linux-0.8-minimal.iso
```

- Use stat to display numerical values for file permissions

```bash
❯❯ stat -c '%a %n' * https://t.c...
```

- Check physical host for vuln. CVE-2017-5689

```bash
❯❯ lspci | grep -q -e MEI -e HECI && echo "Check your firmware for Intel AMT vulnerability"
```

- I Vound Ze Force

```bash
❯❯ man zforce
```

- Know your limits

```bash
❯❯ getconf -a | sort -k2nr | grep MAX
```

- Print the line before a line containing 'password' in the file 'config'

```bash
❯❯ sed -n '/password/{x;p};h' config
```

- List the filenames that contain the IP address 19.19.32.62 (-F = fixed string only for faster search)

```bash
❯❯ grep -F -l 19.19.32.62 *.log
```

- UndocumentedFeatures

```bash
❯❯ I've been using SSH for decades and I didn't even know this was possible. https://t.co/WubSNKshF5
```

- See what the word inconceivable really means. dict also shows thesaurus entries, which is quick and useful

```bash
❯❯ dict inconceivable
```

- SSH version change

```bash
❯❯ bro-cut -Cd ts host host_p unparsed_version <software.log|awk -F\\\\t \'$2=="10.2.3.4" && $3=="22"{if(l!=$4){print;l=$4}}\'
```

- :D I guess they broke with the default info page format for this special info page. This cracked me up

```bash
❯❯ info man
```

- GNU grep has not well documented options --no-group-separator and --group-seprator="\xe2\x96\xac\xe2\x96\xac\xe2\x96\xac\xe2\x96\xac\xe2\x96\xac\xe2\x96\xac"

```bash
❯❯ grep -h --no-group-separator 404 *.log
```

- Play a video file recent.mp4 at 8x speed, looping it seamlessly forever

```bash
❯❯ mplayer recent.mp4 -loop 0 -speed 8
```

- The authbind program allows a non-root user to listen on ports below 1024. Needs to be configured first though

```bash
❯❯ authbind nc -v -l 80
```

- WorldPenguinDay. Here is a video of me making Tux out of play-doh. https://t.co/jf3PaMopzn

```bash
❯❯ Its
```

- Dump information from a CDP frame received on eth0

```bash
❯❯ tcpdump -nn -v -i eth0 -s 1500 -c 1 'ether[20:2] == 0x2000'
```

- You can reverse a set of "records" using tac with the -s option and a record separator. Used to make globe spin backwards

```bash
❯❯ tac -s "^[[H
```

- One world, no pv version

```bash
❯❯ o=$(curl -Ls bit\\.ly/globe_vt);yes "$o"|perl -ne \'$/="\\e[H";$\\=$/;print "$_";select(undef,undef,undef,1/24);\'
```

- ASCII globe animation

```bash
❯❯ oneworld=$( curl -Ls http://bit\\.ly/globe_vt );while sleep .1;do pv -L4220 -q  < "$oneworld";done
```

- List traffic from inside to outside

```bash
❯❯ awk \'$3~/^172\\.16\\./ && $5!~/^172\\.16\\./{printf("%s %s\\n",strftime("%Y-%m-%d_%T", $1),$0)}\' conn.log
```

- (remote: base64 -d > file) On short files over complex transfer paths between hosts, try copy/paste the base64 output

```bash
❯❯ base64 -w4095 file
```

- Get the entries with 4+ null fields and sort the entries by IPv4 (-V) in the 3rd column

```bash
❯❯ egrep -- "\\t-\\t-\\t-\\t-\\t" entries.txt |sort -k3V
```

- CheckYourPrivilege @climagic

```bash
❯❯  sudo -l
```

- You can use -e multiple times for multiple expressions. Nice when you have multiple complex items

```bash
❯❯ grep -e foo -e bar -e baz file
```

- Starts a WebSocket server and prints all requests to stdout @climagic

```bash
❯❯  nc -k -l 4444
```

- Generate list of installed RPM names(left align) and their packager in formated columns

```bash
❯❯ rpm -qa --queryformat "%-47{NAME} %{PACKAGER}\\n
```

- Insert all the possible command line completions into the command line you are editing. Life, the Universe and Everything

```bash
❯❯ <Meta-* >
```

- Operate and get next line. This executes the current line from your history and on return gives you the next history line

```bash
❯❯ <Ctrl-o >
```

- This indicates to the program that there is no more input. In the shell, this usually closes the shell

```bash
❯❯ <Ctrl-d >
```

- Delete everything from the cursor to the beginning of the line. This can also be used to clear a password attempt and start over

```bash
❯❯ <Ctrl-u >
```

- Delete the previous word on the command line (before the cursor). This is highly useful when reusing old commands

```bash
❯❯ <Ctrl-w >
```

- This is usually equivalent to running 'clear'.  Its usually quicker and doesn't leave the command in your command line history

```bash
❯❯ <Ctrl-l >
```

- Incremental undo of command line edits

```bash
❯❯ <Ctrl-_ >
```

-  >

```bash
❯❯ <Meta-
```

- Insert the last argument from the previous line in the command history into the current line. Different from !$

```bash
❯❯ <Meta-. >
```

- Move your cursor to the end of the line. Faster than holding down right arrow

```bash
❯❯ <Ctrl-e >
```

- Move your cursor to the beginning of the line. Faster than holding down left arrow. In screen, you need to press `<Ctrl-a a >`

```bash
❯❯ <Ctrl-a >
```

- Reverse search through your command history for 'string'. Press Ctrl-r again to continue searching backwards. ESC when done

```bash
❯❯ <Ctrl-r >string
```

```bash
❯❯ alias find='sleep $((RANDOM%60+5))
```

- Make the flag of Japan with ImageMagick

```bash
❯❯ convert -size 150x100 xc:white -fill red -draw 'circle 75,50 75,75' flagofjapan.png
```

- Pipe text from Wikipedia into sed, print regex+6 lines

```bash
❯❯ elinks https://t.co/3MFZmCM3PA |sed -n '/Article 12/,+6p'
```

- The pee command can run head and tail on same input. sponge waits for all the data first

```bash
❯❯ ping -c100 4.2.2.2 | sponge | pee head tail
```

- Poor man's hacker typer in the terminal

```bash
❯❯ locate --regex '\\.c$' | shuf | head -1 | xargs pv -q -L 20
```

- Jeez, how far back do these lastlogs go?

```bash
❯❯ last -da|cut -c27-30|uniq|awk -v y=$(date +%Y) \'{if(/Jan/){print $0;print "-- " y--}else{print}}\'
```

- Show directory size and sort by human readable amount (MB, GB, etc.). Requires GNU sort for -h option

```bash
❯❯ du -sh */ | sort -h
```

- Copy files (cp) and preserve their timestamps and permissions (-a) while showing what is happening (-v)

```bash
❯❯ cp -av /olddisk /newdisk
```

- Clear your copy buffer 10-20 seconds. OSX version

```bash
❯❯ while :; do [ ! -z "$a" ] && { a=""; pbcopy  < "$a"; } || a=$(pbpaste); sleep 10; done
```

- Clear your copy buffer after 10-20 seconds

```bash
❯❯ while :; do [ ! -z "$a" ] && { a=""; xsel  < "$a"; } || a=$(xsel); sleep 10; done
```

- A unique really-realtime\xe2\x84\xa2 chat experience on older Unix that maybe Randall never got to use

```bash
❯❯ talk
```

- Convert Mac OS icon file into a set of images to edit. I just used that for custom firefox profiles

```bash
❯❯ iconutil -c iconset firefox.icns
```

- Auto type next $n on click

```bash
❯❯ n=1;while :;do xinput --query-state 8|grep \'button\\[1\\]=d\' &&{ xdotool type "$n"; n=$[n+1]; };sleep 0.3;done
```

- Check the last modified date of a file over HTTP

```bash
❯❯ curl -sI https://t.co/DAQGsQi6wQ | grep Last-Modified
```

- !/bin/bash\\necho My cksum is 918329835' > magic

```bash
❯❯ echo -e '
```

- Tron lightcycles in the terminal or Etch-a-sketch. Or make a snake game

```bash
❯❯ https://t.co/Kvo0jd2eTK
```

- Meta

```bash
❯❯ at 3pm  < \'t update "Post an update at a later time to twitter. Like this one."\'
```

- Print the extended ASCII table. For @drscriptt

```bash
❯❯ for x in {8,9,{A..F}}{{0..9},{A..F}} ; do printf "$x %c\\n" $( xxd -r  < "0 $x" ) ; done
```

- When lexical sorting messes up numeric ordering, use brace expansion to put file args in correct numeric order

```bash
❯❯ mplayer movie-p{1..27}.m4v
```

- Do an strace of evince and write all syscalls to logfiles even if it forks

```bash
❯❯ strace -s8192 -o evincetrace -ff evince file.pdf
```

- Print lines from columns.txt where the first column is the same as the second column

```bash
❯❯ awk '$1==$2' columns.txt
```

- Fill a file with a range of IPs from 10.0.1.1 - 10.0.4.254, one IP per line

```bash
❯❯ printf "%s\\n" 10.0.{1..4}.{1..254} > network-ips.txt
```

- For lines with a specific IP in them, convert the epoch times to dates

```bash
❯❯ grep 10.50.60.70 logs.txt | cut -f1 | sed 's/^/@/' | date -f -
```

- CLI clients for other popular services like Spotify, Tunein, IHeartRadio, etc. A quick search should find them

```bash
❯❯ There are also
```

- Pandora music client for the command line. You may have to dl from github and compile. https://t.co/HBv7MZjR7A

```bash
❯❯ pianobar
```

- NameCollisions

```bash
❯❯ Co-worker: Do you use Slack?\rMe: Yeah I've been using Slack since 1994 when it came on like 70 floppies.\rCo-worker: Huh?\r
```

- Perform arbitrarily large math, while disabling bc's \\ + newline output "feature"

```bash
❯❯ BC_LINE_LENGTH=0 bc  < "2^4096
```

- Show the full last modified epoch time including nanoseconds of /etc/passwd (GNU version)

```bash
❯❯ date -d "$(stat -c %y /etc/passwd)" +%s.%N
```

- This is some of the best #UNIX humour I've even read. Warning: for geeks only.

```bash
❯❯ https://t.co/f75QV47eSd
```

- list all files (-a) in PWD with details (l) and order them by size (S) ascending (-r), make sizes human readable (-h)

```bash
❯❯ ls -lShra
```

- Lookup allocation/"ownership" information for an IP address. Apparently a lot of IT folk still don't know this

```bash
❯❯ whois 66.163.186.42
```

- Backup IMDb board pages in cache

```bash
❯❯ mkdir ~/imdb/ ; egrep -lr 'imdb\\.com/.*/board/' ~/.cache/mozilla/firefox | xargs -I{} cp -va {} ~/imdb/
```

- When you have 2+ tmux clients on the same session and another one is on a smaller window

```bash
❯❯ tmux list-clients ; tmux detach-client -t pts/22
```

- Because you shouldn't have to constantly be bombarded with ads for underwear when reading programming documentation

```bash
❯❯ elinks
```

- Read the BIOS on PC hardware. Thanks @Fr33Wor1d, better late than never

```bash
❯❯ dd if=/dev/mem bs=1k skip=768 count=256 2 >/dev/null | strings -n 8
```

- Count the number of commas (,) in a text file

```bash
❯❯ tr -cd , < file.txt | wc -m
```

- Make a bunch of mount point directories all at once. All combos of sdb1 through sde9 inclusive

```bash
❯❯ sudo mkdir /mnt/sd{b..e}{1..9}
```

- Getting rid of query string in filename by surrounding it with {,}

```bash
❯❯ mv image-file-with-query-string.jpg{?query-string=Z29vZCBqb2IK,}
```

- Look for email data on a hard drive, even if it was "deleted". Encrypt your FS!

```bash
❯❯ sudo strings /dev/sdc | grep -C200 "Received:
```

- % US pop. murdered 1960-2015

```bash
❯❯ elinks -dump bit\\.ly/qutWZK|tr -d ,|sed -e \'/^2015/q\'|awk \'/^[12]/{p=$6/$2*100; printf "%d %0.4f%%\\n",$1,p}\'
```

- Change the hue of an image by -90 degrees. 50 = ( -90 * 100/180 ) + 100

```bash
❯❯ convert bluethumb.png -modulate 100,100,50 greenthumb.png
```

- Right-align text on 80 columns

```bash
❯❯ sed -E ':a /.{80}/!{s/^/ /;ba}' file
```

- CLIMagic video: Epic demo of how I watched Superbowl 46 over a netcat stream

```bash
❯❯ https://t.co/iXz161lDEg
```

- Print the decimal encoded value of a ). The ' before the character tells printf to interpret the character this way

```bash
❯❯ printf "%d\\n" )
```

- Make URLs from data before foo

```bash
❯❯ grep -B3 "foo" multilinedata.txt |egrep "^Id:" |while read x x id; do echo "https://hostname/${id}"; done
```

- Get a sample of 10 lines from a large log file, 100,000 lines from the end of the file

```bash
❯❯ tail -n100000 large.log | head
```

- An interactive command line game challenge. Allows various solutions. And yes, each of them are solvable in 140

```bash
❯❯ https://t.co/KCC08mJCX8
```

- unixsongs thread happening on right now. We did a while back with Unix band names

```bash
❯❯ Check out the
```

- Filename with colons giving you problems with scp or rsync? Use the ./ path prefix B4 filename

```bash
❯❯ scp ./file:with:colons.txt user@otherhost:
```

- Happy 80th Philip Glass

```bash
❯❯ cd /etc;n=CAGBFDEC;stat -c%a *|while read -n1 k;do x=${n:$k:1};sleep .2;play -qn synth tri ${x}4 fade 0 .1937&done
```

- Full screen seamless play your mp4 videos without borders. No window switching

```bash
❯❯ mplayer -fs -noborder -fixed-vo *.mp4
```

- Move mouse in spiral

```bash
❯❯ x=0;y=0;while [[ $y -lt 500 ]] ; do xdotool mousemove --polar $x $y ; x=$(($x+4));y=$(($y+1)); sleep 0.01; done
```

- Today is day

```bash
❯❯ date -d"2009-12-15 +2600 days"||date -v2009y -v12m -v15d -v+2600d; play -n synth sin 2600 trim 0 1 vol .05
```

- infosec is in Firefox and Chrome's developers tools, both have a "Copy as curl command" function in their network tab

```bash
❯❯ A useful tool for
```

- Catch a snooper

```bash
❯❯ inotifywait -e open juicy.dat && w | awk \'$5~/\\.00s/\' | mailx -s "Someone accessed juicy.dat" you@example.com
```

- Analyze your whole lastlog to see the different remote hosts for each user

```bash
❯❯ last -da | awk \'{print $1 " " $NF}\' | sort | uniq -c
```

- See what the POTUS "probably" tweeted

```bash
❯❯ t timeline -l realDonaldTrump|egrep ^[0-9]|while read -r f u; do t status -l $f;done |grep Android
```

- Show top count for col3, 2016-07 - 2017-01

```bash
❯❯ sed -n '/^2017-01/,/^2016-06/p' logs.csv |sed '$d' |awk -F, '{print $3}' |sort|uniq -c|sort -rn
```

- Ex "acronym FBI" Thx @Sh1bumi

```bash
❯❯ acronym(){ elinks -no-numbering -dump "https://t.co/uKT3MTb9Ap${1:-RTFM}.html"|sed -n \'/Rank Abbr/,/^$/p\'; }
```

- grep gziped log files from .gz files in dirs starting with 2017-01-1 & 1 wild character

```bash
❯❯ zgrep SSH::Password_Guessing 2017-01-1?/notice.*gz
```

- That program you try to run when your network is laggy

```bash
❯❯ lessssssssssssssssssssssssssssss
```

- Open all your JS source files in vim tabs. Then use :tabn and :tabp to switch between them. :tabe newfile to open new tab

```bash
❯❯ vim -p *.js
```

- Swirly plasma background. Uses ImageMagick

```bash
❯❯ convert -size 2420x1580 plasma:fractal -blur 2x2 -swirl 270 -crop 1920x1080+250+250 swirlbg.png
```

- Print the dates for all the following Saturdays in 2017 for use in a document

```bash
❯❯ printf "2017-01-14 + %d weeks\\n" {1..50} |date -f- +"%B %_d
```

- For MacOS X users. Aphex Twin fans may recognize this as the beginning of "Cow Cud is a Twin"

```bash
❯❯ say -v hysterical aphex twin
```

- Read man page BUGS in style. saybugs bash

```bash
❯❯ saybugs(){ man $1|col -b|sed -n '/^BUGS/,/^[A-Z]/p' |tail -n+2 |{ say --voice=Bad||espeak; }; }
```

- Without opening up the man page viewer, search for instances of '!' and display with surrounding context

```bash
❯❯ man procmailrc | grep -C10 '!'
```

- Prefix each line with the local time based on epoch time in 1st column

```bash
❯❯ |gawk \'{printf("%s %s\\n",strftime("%Y-%m-%d_%T", $1),$0)}\'
```

- Use the 't' client to list in real time people using the word 'speaker' in their tweet. https://t.co/OVdxgYRKNF

```bash
❯❯ t stream search -l speaker
```

- Find email addresses with 2 letter TLDs in them. \\ > matches empty string at end of a word

```bash
❯❯ egrep -i "@[a-z\\.-]+\\.[a-z]{2}\\ >" emails.txt
```

- Sometimes, there are files that find can't find no matter how many options you try

```bash
❯❯ find / -please-find-the-file-i-want
```

- IToldYouSo

```bash
❯❯ Its been 10 years since the iPhone and see, we still use desktops and laptops. New devices just fill in the gaps in our lives.
```

- While within

```bash
❯❯ [Ctrl-X] [Ctrl-F]
```

- A color show in your shell

```bash
❯❯ yes "$(seq 16 231)" | while read i; do printf "\\x1b[48;5;${i}m\\n"; sleep .02; done
```

- restore a

```bash
❯❯ pv bigdump.sql.gz | gunzip | mysql
```

- Find files under /var/log that are readable by the current user. Takes groups and ACLs into account

```bash
❯❯ find /var/log -readable -ls
```

- Fix image aspect ratios for Instagram. Thx @fulldecent

```bash
❯❯ mogrify -resize 1080x1350 -gravity center -extent 1080 *.jpg
```

- Your laptop says ESSID names while you drive around

```bash
❯❯ while true;do iwlist wlan0 scan |awk -F\\" \'/ESSID/{print $2}\' |espeak;done
```

- CommandLineForever https://t.co/iPYmYo7kTb

```bash
❯❯ More popular than ever in 2017.
```

- Search the file system, but don't descend into the /sys or /proc directories

```bash
❯❯ find / \\( -path /proc -o -path /sys \\) -prune -o -print
```

- $u))%230))m\\u$u\\033[0m"; done

```bash
❯❯ printf "%x\\n" {1..65535} | while read -r u ; do printf "\\033[38;5;$((16+$((16
```

- Use the -w option in diff to ignore differences in whitespace (tabs instead of spaces, etc.)

```bash
❯❯ diff -w index.html bookexample/index.html
```

- curl supports numeric ranges. This is the full 14 days of unix-mas from 2012

```bash
❯❯ curl -Ns http://www.climagic\\.org/uxmas/[1-14]
```

- Quickly find the largest 5 files in the CWD tree without crossing filesystem boundaries

```bash
❯❯ find . -xdev -ls | sort -n -k 7 | tail -5
```

- Start a web server on port 8000 that uses CWD. See https://t.co/Lbnvv0CjmA for other language examples

```bash
❯❯ python -m SimpleHTTPServer
```

- Play local microphone on remote machine's speakers. Fun for pranks. Uses sox package

```bash
❯❯ rec -t wav - | ssh user@remotehost play -t wav -
```

- Encapsulate UDP packets in a TCP stream so it can be tunneled through an SSH tunnel, etc

```bash
❯❯ socat -v UDP-LISTEN:8161,fork TCP:localhost:8161
```

- Make it snow in your terminal. In case you don't have pv or perl. Also, explains the last command

```bash
❯❯ https://t.co/mPoGSm9FTn
```

- Go directly to the crontab man page that is in chapter 5 of the unix manual pages. Some topics have multiple man pages

```bash
❯❯ man 5 crontab
```

- Automatically installs your public key to the remote host (this is included in the openssh package)

```bash
❯❯ ssh-copy-id 'user@remotehost'
```

- Scan your internal network for hosts listening on TCP port 22 (SSH protocol)

```bash
❯❯ nmap --open -p T:22 192.168.1.0/24
```

- Make box around text. By @bartonski

```bash
❯❯ function box() { t="$1xxxx";c=${2:-=}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }
```

- Delete messages from Dec 11th in the postfix queue

```bash
❯❯ mailq | awk '/^[0-9A-F]+ .+ Dec 11 /{print $1}' | xargs -n 1 postsuper -d
```

- Display top bandwidth hogs on website

```bash
❯❯ awk \'{a[$1] += $10} END {for (h in a) print h " " a[h]}\' access_log | sort -k 2 -nr | head -10
```

- CABB1E' -draw "polygon 35,140 115,130 150,55 310,55 350,130 460,150 460,210 35,210" cabbie.png

```bash
❯❯ convert -size 500x300 xc:white -fill xc:\'
```

- C0FFEE

```bash
❯❯ display -size 300x400 -negate xc:'
```

- List files in current directory with a .php extension that DO NOT contain a PHP open code block tag

```bash
❯❯ grep -L '<?php' *.php
```

- Use rev twice to get around cut not being able to relatively remove 3 letters from the end of lines

```bash
❯❯ cat uuoc.txt | rev | cut -c 3- | rev
```

- Find which Debian package the notify-send program is included with - > libnotify-bin

```bash
❯❯ dpkg -S $( which notify-send )
```

- Pass the output of which (showing path to lspci) into rpm's -qf, which tells you the pkg

```bash
❯❯ rpm -qf $( which lspci )
```

- CABB1E is a cool one too since its actual color matches the word. Also,

```bash
❯❯ @gumnos @keithpjolley Nice.
```

- Do an rsync and limit the bandwidth used to about 200 KBytes/sec. Useful on shared or slow links

```bash
❯❯ rsync --bwlimit=200 src dest
```

- Determine what lines two different files have in common. The comm program requires sorted files

```bash
❯❯ comm -12 <(sort names1) <(sort names2)
```

- Make thumbnails of images IMG_3000.JPG - IMG_3499.JPG

```bash
❯❯ for i in IMG_3[0-4]*.JPG ; do convert -quality 60 -geometry 300 $i thumbs/$i ; done
```

- Join the splits back together

```bash
❯❯ cat split-xaa split-xab split-xac > rejoinedlargefile
```

- Split a file called largefile into 1 gigabyte pieces called split-xaa, split-xab, split-xac

```bash
❯❯ split -b 1G verylargefile split
```

- List the 20 largest files or folders under the current working directory

```bash
❯❯ du -ma | sort -nr | head -n 20
```

- /

```bash
❯❯ grep '^[a-fois]\\{6\\}$' /usr/share/dict/words|sed 'h;y/ois/015/;x;G;s/\\n/- >
```

- AdaLovelace

```bash
❯❯ Ada: I think computers may one day process text, music and pictures.\rCharles: [Bollocks!]\rDon't let the bastards grind you down
```

- Print the running average of the last 3 temp values in front

```bash
❯❯ awk \'{sum+=$1;n++;if (n==3){print sum/3 "\\t" $0;n=0;sum=0}}\' garage-temp.log
```

- Temperature log from JSON

```bash
❯❯ while sleep 1m; do date +%F_%T |tr $\'\\n\' " "; curl -s 192.168.2.50 |jq .[2].temperatureF ;done | tee -a temp.log
```

- Count unique colors in an image. From @lorddrachenblut (2014)

```bash
❯❯ identify -format %k https://t.co/Aqy4qFfay7
```

- Backslashing the * glob instead of quoting the expression. From @lorddrachenblut (2014)

```bash
❯❯ find ./music  -name \\*.mp3 -exec cp {} ./new \\;
```

- Build a private mirror of the public mirror. Thx LordD

```bash
❯❯ rsync -aqzH (public mirror that supports rsync).???::CentOS /path/to/locate/mirror
```

- Use FXP to transfer files between 2 ftp servers. By @lorddrachenblut

```bash
❯❯ lftp > mirror -R ftp://from.j.com/directory1 ftp://to.j.net/directory2
```

- tag all mp3 in PWD as genre podcast. By @lorddrachenblut (2011)

```bash
❯❯ find . -maxdepth 1 -iname '*.mp3' -exec eyeD3 -G podcast \\{} \\;
```

- This will run ls without using any alias called ls that might be in place. You can do this with any command

```bash
❯❯ \\ls
```

- Add this to .vimrc and all searches in vim will use "very magic" mode which acts like egrep. Thx @nickmorrott L3viathan2142

```bash
❯❯ nnoremap / /\\v
```

- Long list (-l) only the directories in the current directory. .*/ and */ are utilizing your shell's glob matching ability

```bash
❯❯ ls -ld .*/ */
```

- Show only the processes matching httpd, ignoring the line of the grep process itself (regex trick)

```bash
❯❯ ps auxww | grep "[h]ttpd
```

- Type 3 CSV cols to Google docs table

```bash
❯❯ sleep 5;while IFS=, read {a..z};do for col in a c d;do xdotool type ${!col} $'\\t';sleep 0.3;done;done
```

- Log!

```bash
❯❯ base64 -d < TVRoZAAAAAYAAQABAYBNVHJrAAAAOgD/UQOAAAAAkEV/CIBFfwCQRX8IgEV/AJBKfwiASn8AkEx/CIBMfwqQSX8IgEl/AJBKfwiASn//LwA=|timidity -
```

- Show photo filenames where no flash was used. Req. Imagemagick

```bash
❯❯ identify -format "%f F:%[EXIF:Flash]\\n" *.jpg | egrep " F:(0|16|24|32)$
```

- strace is a sysadmin godsend. This will follow pid 927 and its children, writing to smtpd.<pid >

```bash
❯❯ strace -p 927 -o smtpd -ff -tt
```

- While in

```bash
❯❯ [Ctrl-R] %
```

- In

```bash
❯❯ gv
```

- In vim, this will left shift indentation of selected lines by one tab. > for right

```bash
❯❯ v (select text with cursor movement) <
```

- MakeAFilmFeelUncertain

```bash
❯❯ .* Wars
```

- KnowVIMber

```bash
❯❯ Before this poll, were you aware that vim and less stored your search histories in .viminfo and .lesshst respectively?
```

- This vim command will turn off the current search highlighting until the next search. Use :set hlsearch to turn on

```bash
❯❯ :noh
```

- Help compare sizes

```bash
❯❯ curl -L bit\\.ly/moonbox |convert - -fill none -stroke red -strokewidth 2 -draw "rectangle 76,97,1360,352" - |display -
```

- 4BitComputing4Ever

```bash
❯❯ Today is the 45th anniversary of the Intel's first commercially available processor, the 4004 microprocessor.
```

- ] [Esc]

```bash
❯❯ [Ctrl-V] (move cursor down across beginning of lines) [I] [
```

- Check net before slow scan

```bash
❯❯ for d in {1..254};do ping -c3 10.3.0.5 > /dev/null ||{ echo "VPN is down";break; }; nmap -T1 10.3.0.$d ; done
```

- In vim insert mode, use this to use the digraph feature to make an \xc3\xa4. Use :digraphs show available characters

```bash
❯❯ [Ctrl-k] a:
```

- Professional development: Learn vim while playing an adventure game

```bash
❯❯ https://t.co/wGMlnbflmZ
```

- You can use the -n option with make to preview what it will do first before actually doing it

```bash
❯❯ make -n install
```

- Who can see your 8.8.8.8 requests?

```bash
❯❯ traceroute 8.8.8.8|awk -F[\\(\\)] '$2~/[0-9]/{print $2}'|while read i;do echo $i;geoiplookup $i;done
```

- UnixAMovie Read The Fucking Subtitles

```bash
❯❯
```

- Two year cal display using diff side-by-side mode (-y)

```bash
❯❯ diff -y <(cal -y 2016) <(cal -y 2017)
```

- Record a macro called 'a' that moves down two lines (jj) and then deletes 1 line (dd). Run w/ @a, run 100 times 100@a

```bash
❯❯ vim macro: qajjddq
```

- KnowVimber

```bash
❯❯ @cdevers Possibly. I think @robotterror came up with a good one:
```

- YesVimber

```bash
❯❯ Happy 25th Anniversary vim! Nov 2nd, 1991 - Nov 2nd, 2016
```

- In vim, depending on your term color scheme, these can help you w/ syntax highlighting

```bash
❯❯ :set bg=dark or :set bg=light
```

- Did they really only change what they say they did?

```bash
❯❯ diff <(docx2txt < agreement.docx) <(docx2txt < newagreement.docx)
```

- Decode message embedded in redirect

```bash
❯❯ curl -sI bit\\.ly/gevpxbegerng |awk -F/ '/^Location:/{print $NF}' |(base64 -di||base64 -Di)
```

- Try to handle the case where a space is in 2nd column data

```bash
❯❯ awk \'{if(NF==8){print $2}else if(NF==9){print $2 " " $3}}\' names.txt
```

- The hidden meaning of

```bash
❯❯ printf "%s\\n" {A..Z} | nl | grep "[XKCD]" | awk \'{sum+=$1} END {print sum}\'
```

- mping nic.uz

```bash
❯❯ mping(){ ping $@|awk -F[=\\ ] \'/time=/{t=$(NF-1);f=2000-14*log(t^18);c="play -q -n synth 1 pl "f"&";print $0;system(c)}\';}
```

- Fire alarm will now lock your screen

```bash
❯❯ rec -n stat trim |& awk '/Max.*amp/{if ($NF < 0.99){exit 1}}' && xscreensaver-command -lock
```

- The t client doesn't allow streaming of mentions so

```bash
❯❯ while :;do t mentions -rl;sleep 1m;done |awk '{if(a[$1]++<1){print}}'
```

- ParanoidGeekTips

```bash
❯❯ No matter how much the fire alarm may hurt your ears, make sure you press that screen lock button before you leave.
```

- AWKtober

```bash
❯❯ For the last one, makes your cursor bounce around. On Mac, quote the yes args together. When done, press Ctrl-Z and kill %1.
```

- Find incomplete years in data

```bash
❯❯ awk -F, '/USC00120784/{print substr($6,0,4)}' weather.csv |uniq -c |awk '$2%4==0&&$1<366||$2%4!=0&&$1<365'
```

- Show only up to the first 10 packets by each source IP

```bash
❯❯ tcpdump -nn ip | awk \'{s=$3;sub(/\\.[0-9]+$/,"",s);if(a[s]++<10){print}}\'
```

- Prefix the epoch time in column 1 with the local time

```bash
❯❯ tail -f udp.log|gawk \'{printf("%s %s\\n",strftime("%Y-%m-%d_%T", $1),$0)}\'
```

- AWKtober

```bash
❯❯ Find your new Raspberry Pi on the network with nmap and awk https://t.co/jSWsUZNQvB By @theurbanpenguin
```

- Display sudo's insults. Thx @KosGD

```bash
❯❯ strings /usr/lib/sudo/sudoers.so |grep Dave -B0 -A50
```

- List top 20 404's URLs in descending order by reqs

```bash
❯❯ awk \'$9 == "404" {print $7}\' access.log |sort|uniq -c|sort -rn| head -n 20
```

- AWKtober with your own awk/sed "Together We Can Change Anything" sticker from https://t.co/FP7f4LUULT

```bash
❯❯ Celebrate
```

- Sort the output of df while keeping the header at the top

```bash
❯❯ df -hP | awk \'NR==1;NR >1{print|"sort -k5rn"}\'
```

- Print the longest line in quotes.txt

```bash
❯❯ awk 'length > max { max=length;maxline=$0 } END { print maxline; }' quotes.txt
```

- Print lines of file without printing ones already seen. $0 means whole line in awk. 'a' is an array

```bash
❯❯ awk '!a[$0]++' file
```

- Print dupes where the 3rd column changed

```bash
❯❯ sort gkwzFruP.txt | awk \'{if(l1==$1 && l3!=$3){print ll "\\n" $0}; ll=$0;l1=$1;l3=$3}\'
```

- Histo gen by @dez_blanchfield

```bash
❯❯ awk -F\':\' \'!max{max=$2;}{r="";i=s=.025*$2/max;while(i-- >0)r=r"-";printf "%40s | %4d | %s %s",$1,$2,r,"\\n";}\'
```

- Sum numbers in the third column of data.txt

```bash
❯❯ awk '{s+=$3} END {print s}' data.txt
```

- I find it amusing that the pulseaudio --kill option has a shortened option (-k) but the --start option does not

```bash
❯❯ pulseaudio -k
```

- /)' conn.log

```bash
❯❯ awk \'($3 == "64.39.106.131") || ($1 ~ /^
```

- Breakup compressed log by syslog date and recompress

```bash
❯❯ zcat large.log.gz |awk \'{print $0 | "gzip -v9c > large.log-"$1"_"$2".gz"}\'
```

- Simple lunch location decider

```bash
❯❯ echo "Tacos,Burgers,Pizza,Sushi,Salad,Noodles,Veggie wraps" | awk -F, \'{print $1}\'
```

- Print only the first From: line in each mail message file. Thx @gumnos

```bash
❯❯ awk '/^From:/{print;nextfile}' *
```

- Display top 100 files accessed on website

```bash
❯❯ awk '{print $7}' access_log | sort | uniq -c | sort -rn | head -100
```

- Print out just the first column (whitespace separated) of data.txt

```bash
❯❯ awk '{print $1}' data.txt
```

- UninstallFlashFriday

```bash
❯❯
```

- SEDtember

```bash
❯❯ Sometimes regular expressions can get messy....that's what she sed.\rWell that was awkward.\r
```

- Censor email addresses in report.txt

```bash
❯❯ sed -r -i 's/\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[a-z]{2,30}\\b/xxx@yyy.zzz/' report.txt
```

- Compress consecutive blank lines down to just 2 in the file notes.txt

```bash
❯❯ sed -i '/^$/N;/\\n$/N;//D' notes.txt
```

- Does the account leak affect people who ping Yahoo?

```bash
❯❯ ping https://t.co/fBotT8rfVV
```

- Generate output similar to 'tree' without using tree

```bash
❯❯ find . -print | sort | sed 's;[^/]*/;|---;g;s;---|; |;g'
```

- Print the high CPU process's family tree

```bash
❯❯ ps auxwwf | sed -n -r -e '/^.{64} \\//h;/\\\\/H' -e '/^.{14} [8-9][0-9]\\.[0-9]/{x;p}'
```

- List files that confuse Git on Windows by differing only by...

```bash
❯❯  git ls-tree -r --name-only HEAD | tr A-Z a-z | sort | uniq -d
```

- Every time a WARN: line is encountered, print the previous Path: line seen along with it

```bash
❯❯ sed -n '/Path:/h;/WARN:/{x;p;x;p}'
```

- PeopleLikeMeBecause I post barely readable messages that when run carelessly can obliterate all your data and compromise your employment

```bash
❯❯
```

- AWKtober is coming. https://t.co/WFy5rfMKvc

```bash
❯❯ { } yourselves,
```

- Joins multiple lines and separates them with the string "<br / >"

```bash
❯❯ sed \':a;N;$!ba;s/\\n/<br \\/ >/g\'
```

- AWKtober is coming!

```bash
❯❯ @surryhill
```

- ItCanWait Please stop using your phone while driving. On average, 1180 people are injured each day just in the US from distracted driving

```bash
❯❯
```

- Swap each line of input with the next line of input

```bash
❯❯ sed -n '$p;h;n;p;g;p'
```

- Setting the LANG=C variable will often fix unexpected problems with sort ignoring symbol characters like +, - and *

```bash
❯❯ LANG=C sort
```

- Evidence that Linux was released Sept 17th 1991

```bash
❯❯ wget -O- ftp://ftp.funet\\.fi/pub/linux/kernel/Historic/linux-0.01.tar.gz|tar ztv|sort -k4
```

- Quickly print line 9417 of a large file without processing the whole file

```bash
❯❯ sed '9417q;d' dbdump.sql
```

- BroCon2016 https://t.co/46JhUEbduN

```bash
❯❯ How Texas personalizes supercomputing. @TACC
```

- AWKtober

```bash
❯❯ @ExaGridDba
```

- Search irc.log for lines containing Alice and Bob regardless of their order in the line

```bash
❯❯ sed '/Alice/!d; /Bob/!d' irc.log
```

- Use jq to pretty print some json data with ANSI color coded syntax and use -R in less to process the color

```bash
❯❯ jq -C '.' data.json | less -R
```

- BroCon2016 (network security monitor) in Austin, TX this week

```bash
❯❯ I'm at
```

- Joins multiple lines and separates them with the string "<br >"

```bash
❯❯ sed \':a;N;$!ba;s/\\n/<br >/g\'
```

- Show only the directories in the current directory. The / at the end of the wildcards make this work

```bash
❯❯ ls -d .*/ */
```

- Pretend you are on a starship. Req. sox package

```bash
❯❯ play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +30 fade h 1 86400 1
```

- Web request chart

```bash
❯❯ cat access_log-*|awk \'{print substr($4,5,8)}\'|uniq -c|gnuplot -e "set terminal dumb;plot \'-\' using 1:xtic(2) with boxes
```

- or --shift

```bash
❯❯ @andrewgilmartin 'less' will let you scroll left to right. Default is by half the screen width, you can change this with -
```

- Aperl ? I'll consider it. Thanks

```bash
❯❯ @jhparkerb Well, I don't think someone is a fool for using perl, so how about just making it all of
```

- In the find man page, show whole paragraphs containing the word modified

```bash
❯❯ man find |sed -e '/./{H;$!d;}' -e 'x;/modified/!d;i=='
```

- Add separator commas to long numbers

```bash
❯❯ printf "10^%d\\n" {0..20} | bc | sed -e :a -e \'s/\\(.*[0-9]\\)\\([0-9]\\{3\\}\\)/\\1,\\2/;ta\'
```

- Unwrap lines that end with a backslash in script.sh

```bash
❯❯ sed -i -e :a -e '/\\\\$/N; s/\\\\\\n//; ta' script.sh
```

- Live dmesg output in human readable format (colors, timing) @climagic

```bash
❯❯ RT @jreybert: dmesg -wH
```

- sed allows you to use other characters to demarcate sections. Same as running: sed s/a/emen/ < dated

```bash
❯❯ sed statement < dated
```

- /!s/$val\\ >/$pid/g' getproc.pl

```bash
❯❯ sed -i -e '/^\\s*
```

- Print config.cfg tab indented to fix a bad console not letting you to see first few columns

```bash
❯❯ sed 's/^/\\t/' config.cfg | less
```

- Find files you haven't accessed so far this year in a directory. Requires atime attributes. Thx @fs111

```bash
❯❯ find . -atime -$(date +%j) -type f
```

- SEDtember and

```bash
❯❯ Get ready for
```

- Find file duplicates in 'Pictures' recursively based on size and mdsum and log them to dupes.txt

```bash
❯❯ fdupes -r Pictures > dupes.txt
```

- extract all unique hex color codes from a CSS file

```bash
❯❯ egrep -oi '#[a-f0-9]{6}' file.css | sort | uniq
```

- Listen to the radio from the command line. Try ./iheart-mplayer $((RANDOM%2000))

```bash
❯❯ https://t.co/pd9i05UD1W
```

- Wait for the friendly Googlebot to pay your site a visit. Brought to you by Carl's Jr

```bash
❯❯ tail -f access_log | awk \'$1~"googlebot"\'
```

- Gen 20 random users/passwords

```bash
❯❯ for i in {1..20} ; do rig|head -1 |tr A-Z a-z;done |while read f l;do echo ${f:0:1}${l}:$(pwgen 12 1);done
```

- Total bytes used by 5+ year old directories in CWD

```bash
❯❯ find . -mtime +$((365*5)) -maxdepth 1 -exec du -sb {} \\; |awk '{s+=$1}END{print s}'
```

- nixDreams https://t.co/3ELuMoZDZR

```bash
❯❯
```

- Use -D to create a SOCKS5 tunnel inside your SSH connection. Some programs (like a web browser) can use these

```bash
❯❯ ssh -D 9999 you@remotehost
```

- line}"; done

```bash
❯❯ while read line; do echo "line length is ${
```

- Use a for loop to iterate over a list of items (files, numbers, etc) and run processes accordingly

```bash
❯❯ for i in *.jpg; do identify "$i"; done
```

- Use the && and || logic operators for results based process control

```bash
❯❯ pgrep myscript.pl && echo still running || echo "done" | mail admin
```

- There are helper commands for dealing with compressed files (gz, bz2 and xz). They have a z, bz or xz prefix

```bash
❯❯ zless, zgrep, zcat, zdiff
```

- Last one for today. This indicates to the program that there is no more input. In the shell, this usually closes the shell

```bash
❯❯ <Ctrl-d >
```

- Delete everything from the cursor to the beginning of the line. This can also be used to clear a password attempt and start over

```bash
❯❯ <Ctrl-u >
```

- Delete the previous word on the command line (before the cursor). This is highly useful when reusing old commands

```bash
❯❯ <Ctrl-w >
```

- This is usually equivalent to running 'clear'.  Its usually quicker and doesn't leave the command in your command line history

```bash
❯❯ <Ctrl-l >
```

- Incremental undo of command line edits

```bash
❯❯ <Ctrl-_ >
```

-  >

```bash
❯❯ <Meta-
```

- Insert the last argument from the previous line in the command history into the current line. Different from !$

```bash
❯❯ <Meta-. >
```

- Move your cursor to the end of the line. Faster than holding down right arrow

```bash
❯❯ <Ctrl-e >
```

- Move your cursor to the beginning of the line. Faster than holding down left arrow. In screen, you need to press <Ctrl-a a >

```bash
❯❯ <Ctrl-a >
```

- Reverse search through your command history for 'string'. Press Ctrl-r again to continue searching backwards. ESC when done

```bash
❯❯ <Ctrl-r >string
```

- Quick access to the ASCII character table via the ascii program or the man page if you don't have the program

```bash
❯❯ ascii || man ascii
```

- tmux is a great program that manages multiple terminal sessions and allows you to detach/reattach to the session. Also screen, dvtm

```bash
❯❯ tmux
```

- Use the 'tee' command to save a copy and see the output of a program at the same time

```bash
❯❯ ps auxww | tee output.log
```

- Use -k to search for something in all man pages, like 'sound'

```bash
❯❯ man -k sound
```

- There are several commands inside bash called 'built-ins'. You can access info about them using 'help builtin' or just run 'help

```bash
❯❯ help cd
```

- Print detailed list (-l) of all (-a) files reverse sorted (-r) by last modified time (-t) and with human readable size (-h)

```bash
❯❯ ls -ltrah
```

- You can usually press the tab key in the middle of typing a command name, file name or variable to auto complete it

```bash
❯❯ <Tab >
```

- Takes you back to the previous directory you were in. Good to know if you don't already

```bash
❯❯ cd -
```

- (With no arguments) Takes you back to your home directory

```bash
❯❯ cd
```

- description. The

```bash
❯❯ Just a reminder about the format of climagic tweets: command
```

- Cool visuals you can make in your terminal with your cursor

```bash
❯❯ https://t.co/ammutuorZG
```

- In GNU sort, you can use -V (version sort) to also sort IPv4 addresses numerically according to each class

```bash
❯❯ sort -V ipv4addrs.txt
```

- Use this pipeline pattern of -v -e term1 -e term2 to skip lines in output

```bash
❯❯ | grep -v -e garbage -e unimportant -e donotcare
```

- .Top 20 email From TLDs

```bash
❯❯ egrep -o "from=<[^ >]+\\.[a-z0-9-]{2,} >" /var/log/maillog |awk -F\\. \'{print $NF}\' |sort |uniq -c |sort -rn |head -20
```

- Show stats on messages per day in procmail log

```bash
❯❯ grep ^From procmail.log | cut -d' ' -f3- | date -f - +%Y-%m-%d | uniq -c
```

- Save your whole postfix queue to a file

```bash
❯❯ mailq | awk '/^[0-9A-F]/{print $1}' | tr -d \\* | xargs -n 1 postcat -q > mailq-20160801.txt
```

- Print human readable total size of just the files in the current directory. :)

```bash
❯❯ ls -lh | head -1
```

- Video background

```bash
❯❯ youtube-dl -q -o- _gp51lt9kdA|mplayer -wid $(xwininfo -int -name "Desktop"|grep "Desktop"|awk \'{print $4}\') -cache 5000 -
```

- Search for PATTERN in .c and .h file. Thx @suresh_kanzaria

```bash
❯❯ find . -name \\*.[ch] -exec grep -sl "PATTERN" {} \\;
```

- Find directories that have 33000 or more files in them

```bash
❯❯ find / -type f | sed 's,/[^/]*$,,' |sort |uniq -c | awk '$1 >=33000'
```

- Prepare a list of items (one two three) for SQL list syntax

```bash
❯❯ for i in one two three ; do printf "\'$i\'," ; done | sed \'s/,$//\' ; echo
```

- If you just ran a command like unzip -l https://t.co/dv1SBPbILW to see the contents, you can use ^-l^^ to run again without the -l

```bash
❯❯ ^-l^^
```

- Use elinks to read articles on websites that like to waste CPU energy and your time

```bash
❯❯ elinks https://t.co/qF81UixsjD
```

- Show the number of UNsuccessful requests per day. (Not HTTP code 2XX or 3XX)

```bash
❯❯ awk '$9!~/^[23]/{print $4}' access_log | cut -c1-12 | uniq -c
```

- Calculate how much money I'd have if I had a nickel for every potentially hacked wordpress based site

```bash
❯❯ echo ".05*37652825" | bc
```

- Sorry I missed this one by 2 days. Too damn busy

```bash
❯❯ echo epoch day $(( $( date +%s ) / 86400 ))
```

- Find files and directories under /var/www that are world writable. Exclude symbolic links

```bash
❯❯ find /var/www -perm -o+w -a -not -type l -ls
```

- Where log directory is not world readable, brace expansion helps when a wildcard can't

```bash
❯❯ sudo grep 1.2.3.4 /var/log/httpd/access_log{.2,.1,}
```

- Play a song at the end of long running command to notify you. For @kimadactl

```bash
❯❯ make ; mpg123 hawaii-five-o-theme.mp3
```

- bitcoin prices in USD. Thx @balazssomfalvi

```bash
❯❯ curl -s http://www.coindesk\\.com/price/ |grep bpiUSD |sed \'s/<\\/\\?[^ >]\\+ >//g\' |tr -d " \\t\\r
```

- French Flag

```bash
❯❯ t=$(($(tput cols)/3));for FR in $(seq $(tput lines));do printf "\\e[44m%${t}s\\e[47m%${t}s\\e[41m%${t}s\\e[0m\\n";done
```

- Show the HTTP response code for a URL. Catch it while you can!

```bash
❯❯ curl -sI https://www.nianticlabs\\.com/privacy/pokemongo/en/ | head -1
```

- Show new pingers. -l makes tcpdump linebuffered

```bash
❯❯ sudo tcpdump -l icmp[icmptype]=icmp-echo | awk '{if (!arr[$3]){print $3;arr[$3]++}}'
```

- Find primes w/ PCRE. https://t.co/rnfOtbFL33

```bash
❯❯ n=0;while : $((n++));do printf "%0${n}d"|grep -qP "^0?$|^(00+?)\\1+$"||echo $n;done
```

- Scan directly w/ cur date. Merci @dsampaolo

```bash
❯❯ scanimage --format=tiff --mode Color | convert tiff:- ~/Scans/$(date "+%Y-%m-%d_%H:%M:%S").jpg
```

- computrons https://t.co/Ei6XDKiQOS

```bash
❯❯ Just fixed a computer by touching it. I still got the power.
```

- Shipment status

```bash
❯❯ usps_status(){ elinks -dump tools.usps\\.com/go/TrackConfirmAction?qtc_tLabels1=$1 |sed -n '/Status of Item/{n;p;q}'; }
```

- Generic pipeline template. Just add args

```bash
❯❯ grep | awk | sed | grep | grep -v | while read data ; do something to data ; done | tee output
```

- Just in case you didn't get enough fireworks already. Req. rss-glx screensavers

```bash
❯❯ /usr/lib/xscreensaver/skyrocket --maxrockets 100
```

- Get the absolute value of the 4th column of numbers using the square root of the square trick

```bash
❯❯ awk -F, '{sqrt($4^2)}' data.csv
```

- vote4cli https://t.co/BBk8Ya9QIR

```bash
❯❯ awk/sed 201[0-9] Together We Can Change Anything" bumper sticker now available at https://t.co/FP7f4LUULT
```

- Print the number and column name to help write awk expressions

```bash
❯❯ head -1 data.csv | tr , $'\\n' | nl
```

- Prefix lines with timestamp. Thx @amenthes_de

```bash
❯❯ stdbuf -i0 -o0 ping 192.168.42.1 | while read l; do echo "[$(date \'+%H:%M:%S\')] $l"; done
```

- Use gcalcli to access your Google calendar. https://t.co/upzunxymAQ but its already available in some distros

```bash
❯❯ gcalcli
```

- In X, use xmodmap to turn your Caps Lock into an Escape key

```bash
❯❯ xmodmap -e "remove Lock = Caps_Lock" -e "keycode 66 = Escape
```

- Happy Tau (\xcf\x84) day!

```bash
❯❯ echo "scale=1000;4*a(1)*2" | BC_LINE_LENGTH=1004 bc -l | cut -c1-629
```

- Check the last modified date of a file on a web server

```bash
❯❯ curl -I http://langs.eserver\\.org/latin-terms.txt | grep Last-Modified
```

- Will show you the top power consuming processes on your Linux laptop

```bash
❯❯ powertop
```

- infosec

```bash
❯❯ I just had a bunch of teenagers run 'ping localhost' in front of a news reporter. They're hackers now!
```

- Print out line 107056 of your input file that your program is choking on for invalid input

```bash
❯❯ sed -n '107056p' WigleWifi_20140929191654.kml
```

- Sigh.. What is happening to our beloved Internet? (also run 'whois level3\\.sucks')

```bash
❯❯ dig RandomDomainNameThatDoesNotExistLLC\\.com @4.2.2.2
```

- Print lines not matching (-v) any extended regular expressions (-E) in expressions.conf (-f)

```bash
❯❯ grep -E -v -f expressions.conf file.txt
```

- Print lines from file where GPS coords are in range

```bash
❯❯ awk -F, '((37.19 < $7 && $7 < 37.23) && (-115.81 < $8 && $8 < -115.73))' gpsdata.csv
```

- Convert values from x=year,y=month table to linear CSV

```bash
❯❯ awk \'{for (i=2;i<=13;i++) {printf "%d-%02d,%d\\n",$1,i-1,$i}}\' data-table.txt
```

- Use a sleep and the -u option with scrot to capture a mouseover screenshot

```bash
❯❯ sleep 5; scrot -u Phishing-email-example-with-mouseover.png
```

- Force a timezone for the date by setting the TZ variable. In this case, get UTC time

```bash
❯❯ TZ=UTC date
```

- Replace the second occurrence of a regex match. Thx @slmagus

```bash
❯❯ echo "fuzzbuzz" | sed -e "s/u/i/2
```

- I just ran this vim expression to lower notes in an Arduino sketch 2 octaves

```bash
❯❯ %s/\\(NOTE_[A-Z]\\+\\)\\([0-9]\\)/\\=submatch(1).(submatch(2)-2)/g
```

- Discover the Super Cow Powers of aptitude

```bash
❯❯ o="-vvvvvv";for i in 0 {2..7}; do c="aptitude ${o:0:$i} moo";echo "$ $c"; $c; done
```

- % US pop. murdered 1960-2014

```bash
❯❯ elinks -dump bit\\.ly/qutWZK|tr -d ,|sed -e \'/^2014/q\'|awk \'/^[12]/{p=$6/$2*100; printf "%d %0.4f%%\\n",$1,p}\'
```

- Use a multi-character field separator to get field 3 out of a CSV file that uses double quoted fields

```bash
❯❯ awk -F\'","\' \'{print $3}\' data.csv
```

- This sequence will close an OpenSSH session from the client side (same as killing ssh process). [RET] = Return/Enter

```bash
❯❯ [RET]~.
```

- Yes! You can do nested grouping in extended regexes

```bash
❯❯ grep -Ev "((accept|drop|reject)log|ftpd)" /var/log/messages | less
```

- tbt

```bash
❯❯ SSH starts enabling encryption on all remote login sessions." Oh wait, that was 1995 news.
```

- If you have trouble saying No, get your computer to say it for you, falling back on a working command

```bash
❯❯ (espeak || say || cat)  < No
```

- See the current phase of the moon in your terminal. New feature of wttr.in

```bash
❯❯ curl wttr\\.in/Moon
```

- Take the current tmux pane from split window and break it out into a full sized window

```bash
❯❯ tmux break-pane or <Ctrl-b >:break-pane
```

- Rotate a video taken by a "smart"phone user 90 degrees CW. Or just for fun. Try rotate=2 for CCW

```bash
❯❯ mplayer -vf rotate=1 video.mp4
```

- See what software was used for an image

```bash
❯❯ exiftool <(curl -s apod.nasa\\.gov/apod/image/1605/NGC5078-LRGBhager2048.jpg) |grep Software
```

- Besides skipping aliases, a backslash before command also avoids Programmable Tab Completion

```bash
❯❯ \\vim not-everything-is-a-java-file.class
```

- serverless

```bash
❯❯ In my experience, most devs don't maintain their servers anyways. So what's new?
```

- Quick way to see if your pwd path contains any symlinks in it. If so there would be a difference between the two lines

```bash
❯❯ pwd ; pwd -P
```

- this is a trick you can use to grep the process without catching grep too

```bash
❯❯ @ExaGridDba ps -ef | grep [s]mon
```

- Read compressed logs, process only time lines and filter

```bash
❯❯ zcat 2016-05-23/smtp.*.gz |awk '$1~/^[0-9]{9}/' |grep -v -e 10.1.2.3 -e root@
```

- Calculate 7 years ago in days, accounting for leap years

```bash
❯❯ echo $(( ( $( date +%s ) - $( date -d -v-7y +%s ) ) /86400 ))
```

- Calculate 7 years ago in days, accounting for leap years

```bash
❯❯ echo $(( ( $( date +%s ) - $( date -d "now - 7 years" +%s ) ) /86400 ))
```

- Total bytes of files older than ~7 yr

```bash
❯❯ find . -xdev -type f -mtime +$((365*7)) -print0|xargs -0 du -bsc|awk '/\\ttotal$/{s+=$0}END{print s}'
```

- Ubuntu users, if appstreamcli is running right now, check this URL. 100% CPU bug

```bash
❯❯ pgrep appstreamcli && xdg-open https://t.co/b9W7ktbTRJ
```

- Show what files or filehandles are open in the specified directory

```bash
❯❯ sudo lsof +D /var/lib/apt/lists
```

- DigitalPackRat

```bash
❯❯ @w4rchylde I still have my email going back to 1994.
```

- tbt https://t.co/0QKYxLVs8V

```bash
❯❯ Another X screenshot from 1997.  My god I used X as root? Shameful.
```

- tbt https://t.co/zofEfxvxAr

```bash
❯❯ My "X Window System, Version 11" screenshot from 1999.
```

- Use strace to show the files openssl is opening

```bash
❯❯ strace -e open openssl s_client -crlf -quiet -starttls smtp -connect smtp.example\\.com:25
```

- BTW, if I ran the mail server this was on, I'd run this

```bash
❯❯ grep -lr "^Subject: test " Maildir/{cur,new} |xargs rm -v 2 >&1 |tee delete.log
```

- When running commands in a subshell, you can use job control (Ctrl-C, Ctrl-Z, fg, bg) on the subshell as a whole unit

```bash
❯❯ (cmd1;cmd2;cmd3)
```

- Rename the filesystem label on a USB thumb drive to Backups

```bash
❯❯ sudo mlabel -i /dev/sdg1 -s ::"Backups
```

- Press pause on your Roku. [When your kids lose the remote]

```bash
❯❯ curl -d "" http://YourRokuIP:8060/keypress/Pause
```

- See the last logged in users, but filter out entries for root, reboots and asmith

```bash
❯❯ last -da | grep -vE "^(root|reboot|asmith)
```

- RemoveALetterBreakAConfigFile

```bash
❯❯
```

- RemoveALetterSpoilABook https://t.co/qHdt16ZySu

```bash
❯❯ ill Gates: The Rod Ahead
```

- Get a list of debian packages with linux in their name and only list the ones that are fully installed

```bash
❯❯ dpkg -l '*linux*' | grep '^ii'
```

- Pipe the output of the man command into other commands to trim down the "insane amounts of drivel"

```bash
❯❯ man dpkg | sed -n \'/Doctal/,/2000 /p\'
```

- "Tell me about your relationship with your parents."

```bash
❯❯ pstree -a
```

- Start looking for vulnerable code using ImageMagick

```bash
❯❯ find www -name '*.php' -exec egrep -l 'bin/(identify|convert|mogrify|montage)\\b' {} +
```

- I posted this tweet using the @ImageTragick vuln and then fixed this server. Yes, its quite serious. Check it

```bash
❯❯ identify exploit.mvg
```

- I'm disappointed the logo for @ImageTragick vuln was not actually made in ImageMagick

```bash
❯❯ strings logo-medium.png|head
```

- Press enter every time you hear child cough to determine if per min rate is going down

```bash
❯❯ while read -s; do date +%H:%M; done |uniq -c
```

- If you are in a directory that is removed and recreated (such as a symlinked current dir), this will put you in the new directory

```bash
❯❯ cd .
```

- Number of git merges by day of the week. Thx @nicr9_

```bash
❯❯ git log --merges | grep ^Date | awk '{ print $2 }' | sort | uniq -c | sort -n
```

- List the files below the www directory that don't (-L) have PHP code in them

```bash
❯❯ grep -rL '<?php' www
```

- script is a nice program that allows you to record your interactive shell session. Great for logging upgrades

```bash
❯❯ script upgrade.log
```

- Print how many files are inside each directory under the current one

```bash
❯❯ find */ | cut -d/ -f1 | uniq -c
```

- Remove the previous word on the command line (before the cursor). This is highly useful when reusing old commands

```bash
❯❯ <Ctrl-w >
```

- This is usually equivilent to running 'clear'.  Its usually quicker and doesn't leave the command in your command line history

```bash
❯❯ <Ctrl-l >
```

- Incremental undo of command line edits. Ctrl-- works the same and Ctrl-? sometimes works as well, although its not documented

```bash
❯❯ <Ctrl-_ >
```

-  >

```bash
❯❯ <Meta-
```

- Insert the last argument from the previous line in the command history into the current line. Different from !$

```bash
❯❯ <Meta-. >
```

- Move your cursor to the end of the line. Faster than holding down right arrow

```bash
❯❯ <Ctrl-e >
```

- Move your cursor to the beginning of the line. Faster than holding down left arrow. In screen, you need to press <Ctrl-a a >

```bash
❯❯ <Ctrl-a >
```

- Reverse search through your command history for 'string'. Press Ctrl-r again to continue searching backwards. ESC when done

```bash
❯❯ <Ctrl-r >string
```

- Takes you back to the previous directory you were in. Good to know if you don't already

```bash
❯❯ cd -
```

- (With no arguments) Takes you back to your home directory

```bash
❯❯ cd
```

- With GNU sleep, you can use time suffixes (m = minute, h = hour, d = day). Note that some very large values get truncated

```bash
❯❯ sleep 5d
```

- ASCII globe animation

```bash
❯❯ oneworld=$( curl -Ls http://bit\\.ly/globe_vt );while sleep .1;do pv -L4220 -q  < "$oneworld";done
```

- View image metadata without downloading whole 16MB image

```bash
❯❯ curl -sr 0-1024 www.nasa\\.gov/images/content/618486main_earth_full.jpg |strings
```

- When using multiple file arguments with less or vi, you can use :n and :p to go next file (n) and prev file (p) in list

```bash
❯❯ :n and :p
```

- Remove the oldest .pcap file in the /netdumps directory

```bash
❯❯ rm "$( ls -1dt /netdumps/*.pcap | tail -1 )
```

- For those with xscreensaver installed. Press space to draw another one

```bash
❯❯ /usr/lib/xscreensaver/penrose -size 16 -ncolors 64 -delay 1000
```

- Audio prompt. Could also use different notes/melodies for various return codes

```bash
❯❯ PROMPT_COMMAND="play -qn synth sin G3 trim 0 0.1
```

- Change the host header to bypass the DNS

```bash
❯❯ curl -H "Host: https://t.co/BU49d2rfW6" http://example.climagic\\.org/config.php
```

- Alias for running a command as the nobody user. Maybe to reduce privilege or to confirm denial of access

```bash
❯❯ alias nobody='sudo -u nobody'
```

- climagic video: Joining files together using the join command

```bash
❯❯ https://t.co/nDVS07oTdg
```

- Search your history for commands matching ssh and then execute command

```bash
❯❯ history | grep ssh \r!423
```

- (In Linux VM) Used this to bind Mac right command key to Linux VM middle mouse click

```bash
❯❯ xmodmap -e "keycode 134 = Pointer_Button2";xkbset m
```

- Merge two files together based on the first column in each. Print file1.col1:file2.col2

```bash
❯❯ join -o 1.1,2.2 -1 1 -2 1 -t: file1 file2
```

- Remove meetings, really fast. (But make sure they are properly quoted)

```bash
❯❯ rm -rf "${MEETINGS[@]}
```

- This will print only the last line that matches REGEX. Thanks long time listener first time caller @stephensant

```bash
❯❯ sed -ne '/REGEX/h;${x;p}'
```

- Live insert the last word from the previous command in history into current line. Can repeat to go further. Not the same as !$

```bash
❯❯ [Meta-.]
```

- Deletes orphaned docker images. Thx @jvz

```bash
❯❯ for x in $(docker images | awk \'$1 ~ "<none >" {print $3}\'); do docker rmi $x; done
```

- Remove all exif metadata from a photo. Thx @cengizIO

```bash
❯❯ exiftool -all= foo.jpg
```

- Ping home when mic "hears" something

```bash
❯❯ while :;do rec -t raw /dev/null rate 32k silence 1 0.1 2% 1 0.0 2% && ping -c 1 home;sleep 1; done
```

- Major colors

```bash
❯❯ for i in *.jpg;do printf "$i %s\\n" $(convert "$i" -scale 1x1\\! -format \'%[pixel:u]\' info:- ) ;done |tee -a color-indexes.txt
```

- Continually watch processes with names Thx @_radome_

```bash
❯❯ watch -n 0.5 "ps uf -C process1,process2
```

- NPM outdate for projects in dir. Thx @afschr

```bash
❯❯ for d in */; do echo $d; cd $d; npm outdate; cd - > /dev/null; done
```

- Use timeout to only run a command for a set amount of time (1hour)

```bash
❯❯ timeout 1h tcpdump -n -i eth0 -w network.pcap not host 192.168.1.5
```

- Find out what country that IP that just pinged your host is from

```bash
❯❯ geoiplookup 111.75.195.232
```

- Format XMLs. Thx @deepankarb

```bash
❯❯ find -name "*.xml" | while IFS=$\'\\n\' read f ; do xmllint --format "$f" > tmp.xml && mv -v tmp.xml "$f"; done
```

- When Apr01 just won't do, show the (long) format start time for all processes on a Linux system

```bash
❯❯ ps -o pid,lstart,command ax
```

- Well written GUI programs play well with the command line. Multiple args open multiple files

```bash
❯❯ gimp IMG_253{1,4,6..9}.JPG
```

- Use Facebook authentication for SSH and auto "Like" the host too. New ssh options

```bash
❯❯ ssh --like -u fb::Bob_Reach https://t.co/SsgG5tPN0a
```

- Send those new Windows bash users a gift

```bash
❯❯ mkdir fun; touch fun/{R,r}{E,e}{A,a}{D,d}{M,m}{E,e};echo hello  >fun/rEadME;zip -r fun\\.zip fun
```

- Convert MP4 to WAV. Thanks @varpt

```bash
❯❯ for f in *.mp4; do echo "processing $f"; bname=$(basename $f); ffmpeg -i "$f" "$bname.wav"; done
```

- After killing processing using up all your RAM on Linux (Firefox!!), move processes off of swap

```bash
❯❯ sudo bash -c 'swapoff -a && swapon -a'
```

- Show partitions of only physical SCSI/SATA/SCA drives and not other things like device mapper entries

```bash
❯❯ sudo fdisk -l /dev/sd?
```

- n[*]}));play -qn synth pl ${n[$r]} trim 0 1;read -p "[A-G]?" g;[[ "$g" == "${n[r]:0:1}" ]]&&echo y||echo n

```bash
❯❯ n=({A..G}{2..6});r=$((RANDOM%${
```

- Print temperature value from sensor w/ time when temp is over 80

```bash
❯❯ while sleep 30; do curl -s 192.168.0.106 |jq '.temp'|awk '$1 >80'|ts ;done
```

- Output json data from sensor w/ time when temp reaches over 80

```bash
❯❯ while sleep 30; do curl -s 192.168.0.106 |egrep "temp: 8[0-9]" | ts ;done
```

- If you like pasting into STDIN pipeline, this trick can prevent the processing from starting until you press [Ctrl-D]

```bash
❯❯ tac|tac|
```

- Arduino temp sensor to timed logfile and view

```bash
❯❯ tail -f /dev/ttyACM0 |gawk \'{print strftime("%Y-%m-%d %T") " " $0)}\' |tee temperature.log
```

- longnow

```bash
❯❯ Hearing of Andy Grove's passing reminds me, we really are still at the beginning of computing. Imagine 1000 years from now.
```

- Every time you reuse a command from your command history, it saves a tree in the digital world. \xe2\x99\xbb

```bash
❯❯ <Ctrl-r >searchpattern
```

- In vim this will search all lines (%s) for wlan0 and replace all the instances per line (g) with eth3 and confirm (c)

```bash
❯❯ :%s/wlan0/eth3/gc
```

- If you ever want to use a negative offset (from the end) for variable substrings, the space before the - is important

```bash
❯❯ echo ${DISPLAY: -1}
```

- USER}/2}

```bash
❯❯ echo ${USER:0:${
```

- set access/modification times of newfile to those of oldfile

```bash
❯❯ touch -r oldfile newfile
```

- find 4-leaf

```bash
❯❯ t=$((COLUMNS*LINES-COLUMNS));r=$((RANDOM%t));printf "\\e[32m";for i in $(seq $t);do [[ $i == $r ]]&&printf "\xf0\x9f\x8d\x80"||printf "\xe2\x98\x98";done
```

- Long list the files/directories with only 4 characters by using 4 match any single character patterns (?). For @alecedworthy

```bash
❯❯ ls -ld ????
```

- Check a domain to make sure its all the ASCII characters you expect and not Unicode look-a-likes

```bash
❯❯ echo \xef\xbd\x99o\xcf\x85r\xef\xbd\x82\xef\xbd\x81\xef\xbd\x8e\xef\xbd\x8b.com | hexdump -c
```

- A rainbow in your shell

```bash
❯❯ yes "$(seq 231 -1 16)" | while read i; do printf "\\x1b[48;5;${i}m\\n"; sleep .02; done
```

- Show all programs listening TCP/UDP ports. You may want to run this with superuser privileges

```bash
❯❯ lsof -Pan -i tcp -i udp
```

- pi domain owners

```bash
❯❯ for i in $(seq 4 65);do echo -n "${pi:0:$i}.com: ";whois ${pi:2:$((i-2))}.com|grep --col=no "rant Na"||echo;sleep 5;done
```

- Happy Pi Day! Calculate \xcf\x80 to 1000 digits using bc and assign it to pi

```bash
❯❯ pi=$( echo "scale=1000;4*a(1)" | BC_LINE_LENGTH=1004 bc -l )
```

- Req. ImageMagick

```bash
❯❯ convert -size 413x314 xc:tan -fill red -pointsize 200 -gravity center -draw "text 0,0 \'3.14\'" -flop pie.png
```

- Kill all

```bash
❯❯ ps ax -o state -o ppid  | awk \'$1=="Z"{print $2}\' | xargs kill -9
```

- Change URL into a more filesystem friendly form and squeeze the repeated _ chars into one

```bash
❯❯ echo "$URL" | tr -s / _
```

- OpenStack https://t.co/lZHci6jETq

```bash
❯❯ Gotta love it when a speaker hands out CLI cheatsheets. Thanks @rbowen
```

- Generate a random ordered list of 20 numbers. For example to determine order of presentation

```bash
❯❯ seq 20 | shuf
```

- Show just the Documents followed by person@domain

```bash
❯❯ grep -e Document -e person@domain multilinelist.txt |grep -B1 person@domain
```

- Make stats of the top file types in this directory and below

```bash
❯❯ find . -exec file -b --mime-type {} + | sort | uniq -c | sort -nr
```

- How many times did they say cyber? Just select all in your browser copy and paste into this command to find out

```bash
❯❯ grep -io "cyber" | wc -l
```

- in bash, set this option to make sure backgrounded jobs don't get killed when the parent shell exits

```bash
❯❯ shopt -u huponexit
```

- Adjust all rsync processes on the system so that they have lower (idle) IO priority

```bash
❯❯ pgrep rsync | xargs ionice -c3 -p
```

- WP abuse

```bash
❯❯ grep -h "POST /.*wp-login.php" *-access_log |awk \'$1!~/^my.ip.addr$/{print $1}\' |sort|uniq -c|sort -nr |head -50 > wp-abusers.txt
```

- Its a pretty weird day when you find yourself running a command like this to diagnose a problem

```bash
❯❯ tcpdump -i eth0 dst net 127.0.0.0/8
```

- An easy way of selecting the processes owned by someuser

```bash
❯❯ ps wu -U someuser
```

- Drownattack TLD stats

```bash
❯❯ curl -s https://www.drownattack\\.com/top-sites |html2text|awk -F\\. '/^[0-9]+/{print $NF}' |sort|uniq -c|sort -nr
```

- Stump your friends. How many months had only 19 days? Answer: 1 (When we switched to Gregorian. Actual month depends on locale)

```bash
❯❯ cal 9 1752
```

- Show the first and last 5 lines of the file 'log'

```bash
❯❯ (head -5; tail -5) < log
```

- vim add column Data5=N with an inc. number

```bash
❯❯ :let i = 1 | g/|Population=/s/|Population=/\\=printf("|Data5=%d|Population=", i)/ | let i = i+1
```

- Show % reports of CPU statistics for every active task in the server at two second intervals

```bash
❯❯ pidstat 2 5
```

- Lower case all files in a folder

```bash
❯❯ for f in *; do b=$(echo "$f" | tr \'[A-Z]\' \'[a-z]\'); mv "$f" "$b"; done
```

- Make some waves. Req 256-color term

```bash
❯❯ yes "$(seq 19 21; seq 21 -1 18)" |while read i; do printf "\\x1b[48;5;${i}m\\n"; sleep .03; done
```

- counts files in the current path by modification month. Thx @aSheepie

```bash
❯❯ find . -maxdepth 1 -type f -printf '%TY-%Tm\\n' | sort | uniq -c
```

- Print all from 3rd field to end of line. Very useful for log parsing

```bash
❯❯ awk '{ print substr($0, index($0,$3)) }' mail.log
```

- *"Attempt"* to recover an accidentally removed file

```bash
❯❯ fgrep --binary-files=text -C 2000 "string in file" /dev/sda > recovereddata.out
```

- Make less more like more, but still more than more. Percent of file in prompt, etc. Thx @CLK55

```bash
❯❯ export LESS='-sCmqPm--Less--(?eEND:%pb\\%.)'
```

- This environment variable will invoke 'less' with these options when it is used. Like when viewing a man page

```bash
❯❯ export LESS="-S -j10 -i
```

- Terminal based spreadsheet program. Has some degree of vi key support

```bash
❯❯ sc
```

- This is an X automation tool that allows you to script your keyboard and mouse

```bash
❯❯ xdotool
```

- You can actually follow more than one log at once and get new updates on them. Use -q to not print filename header

```bash
❯❯ tail -f *.log
```

- TEXT}

```bash
❯❯ TEXT="measure the length of this text" ; echo ${
```

- In RPM, determine which packages where installed in Nov 2015

```bash
❯❯ rpm -qa --queryformat "%{NAME} %{INSTALLTIME:date}\\n" | grep "Nov 2015
```

- Find and long list mp3 files in Music dir older than a year and larger than 10MB

```bash
❯❯ find music -name '*.mp3' -mtime +365 -a -size +10M -ls
```

- Show photo filenames where no flash was used. Req. Imagemagick

```bash
❯❯ identify -format "%f F:%[EXIF:Flash]\\n" *.jpg | egrep " F:(0|16|24|32)$
```

- Stream mp3 at bitrate speed (128Kbits). WARNING: NSFW "lyrics"

```bash
❯❯ curl -N --limit-rate 16K http://f.climagic\\.org/techsup.mp3 | mpg123 -
```

- Search for names and build a frequency count for each name

```bash
❯❯ egrep -wo "(Donnie|Frank|Roberta|Grandma)" story.txt |sort|uniq -c|sort -r
```

- Show the total space used on all your local disk partitions

```bash
❯❯ df -lP |awk \'{sum += $3} END {printf "%d GiB\\n", sum/2**20}\'
```

- Use the */ trick to get only the directories, then use ${dir%/} to remove the trailing / you get

```bash
❯❯ for dir in */ ; do echo "${dir%/}" ; done
```

- Use perl regex (negative look-behind/look-ahead assertions) to get URLs

```bash
❯❯ grep -P -o \'(?<=href=")http:\\S+(?=")\' *.html
```

- Create a 1280x720 color plasma image. Different each time. Uses ImageMagick

```bash
❯❯ convert -size 1280x720 plasma:green-blue background.png
```

- Write 1MB (1048576) of random numbers to a file

```bash
❯❯ strings /dev/urandom | tr -c -d '0-9' | dd of=randomnumbers.txt bs=1 count=1M
```

- Replace foo with bar only on lines that contain 'bang'. Use in pipeline or with file args. Thanks @Agarri_FR

```bash
❯❯ sed "/bang/ s/foo/bar/
```

- Poor man's video streaming service at video bitrate

```bash
❯❯ Server: nc -l 8762 < video.mpg  Client: nc server 8762 | mplayer -cache 1000 -
```

- After all the host keys and auth, you'll be on server3

```bash
❯❯ ssh -t user1@server1 \'ssh -t user2@server2 "ssh -t user3@server3"\'
```

- rig is this cool little program that generates random identities

```bash
❯❯ rig
```

- Guitar strum. play is from sox pkg

```bash
❯❯ play -n synth pl G2 pl B2 pl D3 pl G3 pl D4 pl G4 delay 0 .05 .1 .15 .2 .25 remix - fade 0 4 .1 norm -1
```

- Climagic video - Aliases vs Functions and where to use $1

```bash
❯❯ https://t.co/5h7TPmrTOs
```

- Play music for 60 minutes and then shutdown. Like sleep on alarm clock

```bash
❯❯ sudo shutdown -h 60 & mpg123 ambientmusic/*.mp3
```

- Using +F option or pressing F in less is similar to `tail -f filename.log` but can use less's features. Thx @gazoombo

```bash
❯❯ less +F filename.log
```

- In vim, when you want to paste in code, its often useful to 'set paste' so that the autoindent/syntax doesn't interfere

```bash
❯❯ :set paste
```

- If you set your production server's time to this date, you will get fired

```bash
❯❯ date -s 1970-01-01
```

- Nice little demo of the potential of UTF-8 in plain text files

```bash
❯❯ vim 'https://t.co/I695o2mTh2'
```

- Record a macro called 'a' that moves down two lines (jj) and then deletes 1 line (dd). Run w/ @a, run 100 times 100@a

```bash
❯❯ vi macro: qajjddq
```

- Change the case (to lowercase) of the first letter E of a filename using brace expansion

```bash
❯❯ mv {E,e}ecummings.txt
```

- List of empty subdirectories of current directory

```bash
❯❯ find . -empty -type d
```

- Like ping, but it uses an ARP request to check, which gets around host firewalls blocking ICMP. Only works on same subnet

```bash
❯❯ arping 10.0.8.5
```

- Check if cert was signed by key

```bash
❯❯ diff <(openssl rsa -in my.key -modulus | grep Modulus) <(openssl x509 -in my.crt -modulus | grep Modulus)
```

- Hide the previous command you just ran and forgot to use space

```bash
❯❯ alias hideprev='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'
```

- Show your basic terminal text colors for terminal preferences change

```bash
❯❯ printf "\\e[%dm%d dark\\e[0m  \\e[%d;1m%d bold\\e[0m\\n" {30..37}{,,,}
```

- 1.jpg

```bash
❯❯ curl \'https://t.co/5Eu3Bbah5L\' -o "trip
```

- Use cut to print out columns 1, 5 and 10 through 15 in data.csv and write that to new.csv

```bash
❯❯ cut -d, -f1,5,10-15 data.csv > new.csv
```

- Copy a file using "ionice -c 3" to give it idle priority to reduce load on the system

```bash
❯❯ ionice -c 3 cp vm1.img vm1-clone.img
```

- Find file duplicates in 'dir' recursively based on size and mdsum and log to dupes.txt. Thx @sizeof

```bash
❯❯ fdupes -r dir > dupes.txt
```

- Count syslog hits per minute in your messages log file. Useful for doing quick stats

```bash
❯❯ awk -F: {\'print $1 ":" $2\'} messages |uniq -c
```

- Todo list

```bash
❯❯ todo(){ cd ~/.todo||return 1&& l=$(ls -1t|head -n1)&&t=$(date +%Y%m%d);[[ "$1" == "last" ]]&&cp $l $t; ${EDITOR:-vi} $t;cd -;}
```

- Use the exiv2 EXIF program to rename your jpg files according to their exif date/time data. Thx @mvuets

```bash
❯❯ exiv2 -k -F rename *.jpg
```

- Remove the prefix 'unwanted' from the beginning of each filename with .jpg suffix in CWD

```bash
❯❯ rename 's/^unwanted//' *.jpg
```

- Create a dynamic SOCKS5 proxy on port 8989 using an SSH connection. Some apps can be configured to use this

```bash
❯❯ ssh -D 8989 you@remotehost
```

- Print the day of the year. Can be useful with things like find

```bash
❯❯ date +%j
```

- Pandora music client for the command line. And like many CLI clients, it has more control, features and less bloat

```bash
❯❯ pianobar
```

- linux

```bash
❯❯ What animals live in the snow? Penguins.\rWhat other animals live in the snow? A lot of penguins.
```

- Compare the contents of 2 dirs. Show only 2 columns, each for files unique to the directory

```bash
❯❯ comm -3 <(ls -1 dir1) <(ls -1 dir2)
```

- How many days will it take to transfer 145GiB at 1.35MiB/sec? Use qalc!

```bash
❯❯ qalc "145Gibyte / 1.35(Mibyte/second) to day
```

- Monitor your wireless card signal strength on the screen

```bash
❯❯ watch -n1 cat /proc/net/wireless
```

- Want to write a word doc without the fuss? Make a TXT, Markdown, etc. & convert. Thx @BriceDutheil

```bash
❯❯ pandoc -o proposal.docx proposal.txt
```

- group subdomains by domain. Good use of rev

```bash
❯❯ cat longdomainlist.txt | rev | sort | rev
```

- Compare just the assignment lines of two config files that use = for value assignment

```bash
❯❯ diff <(grep = config.txt) <(grep = config.txt-new)
```

- Show the 10 largest directories at top level along with total usage. All in megabytes

```bash
❯❯ du -cms .[^.]*/ */ | sort -rn | head
```

- On Linux, print out a list of the process IDs that are in the zombie state

```bash
❯❯ ps aux | awk \'{if ($8=="Z") { print $2 }}\'
```

- Mount a CDROM disc from its ISO image file

```bash
❯❯ dd if=/dev/cdrom of=image.iso ; mkdir CDroot ; mount -o loop image.iso CDroot ; cd CDroot
```

- 20 years ago IBM supercomputer Deep Blue defeats Garry Kasparov in chess for the first time

```bash
❯❯ fliptable(){ echo "\xef\xbc\x88\xe2\x95\xaf\xc2\xb0\xe2\x96\xa1\xc2\xb0\xef\xbc\x89\xe2\x95\xaf \xe2\x94\xbb\xe2\x94\x81\xe2\x94\xbb"; }
```

- Write out 20 png format frames from a video starting at 3 minutes, 46 seconds

```bash
❯❯ mplayer -vo png -ss 3:46 -frames 20 stairs.mp4
```

- Move photos with EXIF data to directories by year created/taken. Be verbose

```bash
❯❯ exiftool -v '-Directory<DateTimeOriginal' -d %Y .
```

- Get list of top URLs from all logs combined

```bash
❯❯ zcat access_log*.gz |cat - access_log |awk '{print $7}' |sed 's/\\?.*//' |sort|uniq -c|sort -nr
```

- xkcd https://t.co/qIAPXwY2Xj

```bash
❯❯ These are your father's parentheses. Elegant decorations, for a birthday cake.
```

- A site that helps you build the find options you want to use and now several other common commands

```bash
❯❯ https://t.co/OahUUpr12o
```

- Annoyed by wrapped lines in df output. Try -P to unwrap the lines and piping to column will align the columns

```bash
❯❯ df -P | column -t
```

- Print disk space used on all ext3 or 4 FS in GiB

```bash
❯❯ df -Pl -t ext3 -t ext4 | tail -n+2 | awk '{ sum+=$3 } END { print sum/2**20 }'
```

- $PS1

```bash
❯❯ PS1=
```

- Compress files with xz in PWD according to size, starting with smallest

```bash
❯❯ ls -Sr1 | while IFS=$\'\\n\' read -r file; do xz "$file"; done
```

- For Mar 22nd, print the req fields for hosts from two letter gTLD

```bash
❯❯ fgrep 22/Mar/2015 access_log |awk \'$1~/\\.[a-z][a-z]$/{print $6 " " $7}\'
```

- "}; print $0 " " b;}

```bash
❯❯ awk \'{print $4}\' apache_log|sort -n|cut -c1-15|uniq -c|awk \'{b="";for(i=0;i<$1/10;i++){b=b
```

- Imagine being able to run tail -f /dev/world (You can get the t command for twitter here: https://t.co/wa8QhYYAdE)

```bash
❯❯ t matrix
```

- Do an instant replay on your Roku

```bash
❯❯ curl -d "" http://YourRokuIP:8060/keypress/InstantReplay
```

- CLIMagic video: Epic demo of how I watched Superbowl 46 over a netcat stream

```bash
❯❯ https://t.co/iXz16142fG
```

- Detect 90% of pwn'd PHP code or thereabouts

```bash
❯❯ grep -r eval.*base64 source_code_tree
```

- Run Nyan Cat in your terminal like its 2011

```bash
❯❯ https://t.co/6Q1oHKLrwq
```

- Which days I've worked... By @d1eg0_garc1a

```bash
❯❯ git log --date=short --format="%ci"|awk \'{print $1}\'|uniq
```

##

```bash
❯❯ du -h . | grep "^[0-9\\.]\\+G
```

- Do an apt upgrade and save a copy of the output to a current dated filename

```bash
❯❯ apt-get upgrade | tee upgrade-$( date +%F ).log
```

- Life is too short to run the same command twice

```bash
❯❯ export HISTSIZE=0
```

- Random color per log line

```bash
❯❯ tail -F syslog |while read -r line;do printf "\\033[38;5;%dm%s\\033[0m\\n" $(($RANDOM%255)) "$line";done
```

- Because you can't do this in real life

```bash
❯❯ nohup sleep 8h
```

- Make month histogram of dates of files in current directory

```bash
❯❯ ls -la --full-time |tr -s " " |cut -f6 -d " "|cut -c1-7 | sort | uniq -c
```

- A nice fade slideshow command you can also use

```bash
❯❯ /usr/lib/xscreensaver/glslideshow -pan 20 -duration 20 -delay 0 -fade 5 -clip -window-id
```

- Matrix screensaver background

```bash
❯❯ /usr/lib/xscreensaver/glmatrix -window-id $(xwininfo -int -name "Desktop" |awk \'/Desktop{print $4}\')
```

- Move current year pics to 2015 directory

```bash
❯❯ find . -maxdepth 1 -daystart -type f -name '*.jpg' -mtime -$( date +%j ) -exec mv -v {} 2015/ \\;
```

- Learn a command on each new shell open

```bash
❯❯ echo \'man $(ls /usr/bin | shuf -n 1)| sed -n "/^NAME/ { n;p;q }"\' > > ~/.bashrc
```

- Show directory size and sort by human readable amount (MB, GB, etc.). Requires GNU sort for -h option

```bash
❯❯ du -sh */ | sort -h
```

- list top 50 404's in descending order

```bash
❯❯ awk \'$9 == "404" {print $7}\' access.log |sort|uniq -c|sort -rn| head -n 50
```

- iodine is a client and server that allow you to tunnel IP traffic over DNS, bypassing many firewalls, etc

```bash
❯❯ https://t.co/Uxzf93qAkC
```

- Edit a file on a remote server using vim from your local *nix desktop

```bash
❯❯ vim scp://user@server1//etc/httpd/httpd.conf
```

- And you probably haven't heard one of these in a while

```bash
❯❯ play -n synth sine 480 sine 620 remix 1-2 fade 0 0.5 delay 0.5 repeat 5
```

- With this command you can generate a U.S. dial tone using sox play

```bash
❯❯ play -n synth sine A sine F remix 1-2 fade 0 5
```

- @stormdragon2976 constructed this command that imitates the sound of an old rotary phone using espeak

```bash
❯❯ https://t.co/sDwF5A448q
```

- Find any files or directories on your system that are suid or sgid. Older versions of find can try -perm +u+s

```bash
❯❯ find / -perm /+s -ls
```

- Quick popup notification command after 3 minutes

```bash
❯❯ sleep 3m; xmessage -nearmouse "Your tea is ready
```

- Get a list of all files last modified in 2013. Useful for passing to xargs or while loop

```bash
❯❯ find . -printf "%TY %p\\n" | grep ^2013
```

- List all rpm packaged files in /var/log by what rpm they belong to

```bash
❯❯ rpm -qa --filesbypkg | grep " /var/log/
```

- Say hello using a nice voice

```bash
❯❯ wget -q -O- -U Mozilla "https://t.co/FtVcqALluf\\.com/translate_tts?q=hello&tl=en"|mpg123 -q -
```

- Create the "Matrix effect" in your terminal window

```bash
❯❯ https://t.co/XoOtJkj06I
```

- find all files larger than 100MB and display their human readable size

```bash
❯❯ find / -size +100M -exec du -h {} \\;
```

- You can use the bc command to convert base 10 numbers to base 16 (hexadecimal). Tip: Specify obase first

```bash
❯❯ echo "obase=16;ibase=10;40" | bc
```

- Convert hexadecimal number 28 to decimal 40. Can also do echo $((16

```bash
❯❯ echo $((0x28))
```

- Ever edit a file as a normal user that is owned by root. This vim command will allow you to overwrite it with root perms

```bash
❯❯ :w !sudo tee %
```

- Turn a Unix epoch time back into a human readable date. Feature of GNU date

```bash
❯❯ date -d @192179700
```

- Play alarm.wav once site is back

```bash
❯❯ while ! curl -m 10 http://www.example\\.com/ ; do echo still down ; sleep 1m ; done ; play alarm.wav
```

- CLI generated dubstep. Thx @Butter_Tweets

```bash
❯❯ while :; do echo wub wub wub | espeak --stdout | play - pitch -400 bend .3,-600,.3 ; done
```

- groundhog0day

```bash
❯❯ The groundhog saw /etc/shadow, the rainbows are next. Winter is over.
```

- sshfs is a nice util that uses FUSE and SSH to mount a remote directory as a local one

```bash
❯❯ sshfs user@remotehost:/remotedir mydir
```

- 1

```bash
❯❯ You probably learned SSH from me. I wrote the top ssh tutorial for the past 15 years. Search for ssh tutorial. Its the Suso one, usually
```

- Apparently according to testing, this is the fastest way to delete millions of small files

```bash
❯❯ rsync -a -delete empty/ foo/
```

- You started a program, but now want it to notify you when its done

```bash
❯❯ <ctrl-z > bg ; wait %1 ; echo "done" | mail -s "done" you@example.com
```

- Download playlist vids

```bash
❯❯ youtube-dl --max-quality 37 --title --playlist-start=1 --playlist-end=10 --ignore-errors youtube-playlist-url
```

- CLIMagic video: Use comment characters in commands to add meta info to commands

```bash
❯❯ https://t.co/k9WE4wZycs
```

- Suspend and reattach a process to screen

```bash
❯❯ longcmd ; [Ctrl-Z] ; bg ; disown ; screen ; reptyr $( pidof longcmd )
```

- By @seidler2547

```bash
❯❯ git log --author=$USER --format="- %B" --since=-7days --reverse |mail -s "What I\'ve done this week" boss@company\\.com
```

- I find brace expansion useful for renaming files. This cmd expands to "mv Picture.jpg Picture-of-my-cat.jpg"

```bash
❯❯ mv Picture{,-of-my-cat}.jpg
```

- mnt iPad filesystem. Thx @timothyjones

```bash
❯❯ apt-get install ifuse", "ifuse /media/iPad" and "cp -v /media/iPad/DCIM/100APPLE/IMG*MOV /target
```

- Use the exiv2 EXIF program to rename your jpg files according to their exif date/time data

```bash
❯❯ exiv2 -k -F rename *.jpg
```

- tail log & highlight errors (if your grep supports --color) Thx @kvegh

```bash
❯❯ tail -f foo.log|egrep --line-buffered --color=auto 'ERROR|WARN|$'
```

- Pretend that you're on a starship

```bash
❯❯ play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +30 fade h 1 86400 1
```

- Extract MP3 from FLV function. Thx @tweetygeekyhbar

```bash
❯❯ extr_mp3(){ ffmpeg -i $1.flv -f mp3 -ar 44100 -ac 2 -ab 192k -y -acodec copy $1.mp3; }
```

- Mark Zuckerburg could've saved a billion if he knew about ImageMagick. (Instagram)

```bash
❯❯ convert +level-colors Firebrick, me.jpg oldme.jpg
```

- Show the query and results of 'select' queries going to your mysql server. Won't work on socket conns

```bash
❯❯ ngrep -d eth0 -i 'select' port 3306
```

- Show what processes are using port 80 either locally or remotely. Need to be root for unowned processes

```bash
❯❯ lsof -i TCP:80
```

- Wrap the lines of draft.txt at 72 characters wide, doing so at spaces, not middle of word (-s)

```bash
❯❯ fold -w 72 -s draft.txt > newdraft.txt
```

- Professional development: Learn vim while playing an adventure game

```bash
❯❯ https://t.co/wGMlnaXJYp
```

- Blink eth0's LED so you can find it in the rat's next of server cables. Ctrl-C to stop

```bash
❯❯ ethtool -p eth0
```

- Save a url for reading later when you "have time". Also try https://t.co/8R1vy0yrRR

```bash
❯❯ saveurl() { cat > /dev/null; }
```

- Display top RAM using processes. Browser is probably

```bash
❯❯ ps aux|tail -n+2 |sort -nrk4 |head -$(($(tput lines)-1)) |cut -c 1-$(tput cols)
```

- Remote intercom system. "Kent, this is God!"

```bash
❯❯ rec -t wav - | ssh remotehost play -t wav -
```

- Quickly find the largest 5 files in the CWD tree without crossing filesystem boundaries

```bash
❯❯ find . -xdev -ls | sort -n -k 7 | tail -5
```

- Quick and easy way to make a mirror of a website

```bash
❯❯ wget -m http://www.example\\.com/
```

- Start a web service on port 8000 that uses the current directory as its document root

```bash
❯❯ python -m SimpleHTTPServer
```

- Automatically installs your public key to the remote host (this is included in the openssh package)

```bash
❯❯ ssh-copy-id 'user@remotehost'
```

- restore a

```bash
❯❯ pv bigdump.sql.gz | gunzip | mysql
```

- Show the TCP and UDP ports being listened on and if you're root, also show the process associated, user, etc

```bash
❯❯ netstat -lepunt
```

- Make slideshow from *.jpg

```bash
❯❯ for p in *.jpg; do ffmpeg -loop_input -f image2 -i $p -t 3 -r 4 -s 1080x720 -f avi - > > slides.avi; done
```

- Your Linux laptop says ESSID names while you drive around

```bash
❯❯ while :;do iwlist wlan0 scan |awk -F\\" \'/ESSID/{print $2}\' |espeak;done
```

- Make local webserver available via remoteserver:8080. Req. GatewayPorts yes on sshd

```bash
❯❯ ssh -R *:8080:localhost:80 remoteserver
```

- Quickly scan network without using nmap, etc

```bash
❯❯ for i in 172.16.0.{1..254};do (ping -c1 $i > /dev/null && echo $_) &done > pinged-hosts
```

- CLIMAGIC video: Using awk or numsum to sum up numbers in df output

```bash
❯❯ https://t.co/kpb7imeVxs
```

- Quickly list the directories that are two levels down without having to do something more complex with 'find'

```bash
❯❯ ls -ld */*/
```

- Search for available python packages through yum, but only show lines for packages starting with python

```bash
❯❯ yum search python | grep ^python
```

- Scan your internal network for hosts listening on TCP port 22 (SSH)

```bash
❯❯ nmap --open -p T:22 192.168.1.0/24
```

- Turn a mono channel recording of talking into a small mp3

```bash
❯❯ lame -b 32 -m m --bitwidth 8 podcast.wav podcast.mp3
```

- Delete messages from Jan 20th in the postfix queue

```bash
❯❯ mailq |grep " Jan 20 " |awk {\'print $1\'} |xargs -n 1 postsuper -d
```

- Make box around text. By @bartonski

```bash
❯❯ function box(){ t="$1xxxx";c=${2:-=}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }
```

- Make a quick rot13 translation quick reference table

```bash
❯❯ echo {a..z} ; echo {n..z} {a..m}
```

- Run a command "unreliably". Useful in cron. Remember to use \\% instead of % if using in crontab

```bash
❯❯ [ $(( $RANDOM % 2 )) -eq 0 ] && command
```

- Display top bandwidth hogs on website

```bash
❯❯ awk \'{a[$1] += $10} END {for (h in a) print h " " a[h]}\' access_log | sort -k 2 -nr | head -10
```

- CLIMagic video: Tar command tutorial

```bash
❯❯ https://t.co/Jd8hP5clg0
```

- This will show a count of all lines that have more than 1 copy. So only show the duplicates. (-d)

```bash
❯❯ uniq -cd popular.txt
```

- Show the mail servers that mail destined to example\xe2\x80\x8b.com is going to go. +short for less info than default

```bash
❯❯ dig +short MX example\\.com
```

- Split a file into 500 line files called splitfile-xaa, splitfile-xab, etc. Useful for variety of things

```bash
❯❯ split -l 500 largefile splitfile-
```

- List the filenames that don't contain the pattern specified

```bash
❯❯ grep -L pattern *
```

- Go directly to the crontab man page that is in chapter 5 of the unix manual pages. Some topics have multiple man pages

```bash
❯❯ man 5 crontab
```

- Use rev twice to get around limitation of cut not being able to truncate end of a string

```bash
❯❯ echo test | rev | cut -c 2- | rev
```

- Split a file into multiple using an empty line as the split point. {*} means do this until the end

```bash
❯❯ csplit sections.txt '/^$/' {*}
```

- Print out the file requested for CLF log entries with HTTP 404 status code

```bash
❯❯ awk '$10==404 {print $7}' access_log
```

- On Linux and others, display the inodes used per filesystem. Useful for determining how long it takes to backup or search the fs

```bash
❯❯ df -i
```

- Show a 3 month view (before, current, after) in cal

```bash
❯❯ cal -3
```

- Find which Debian package the notify-send program is included with - > libnotify-bin

```bash
❯❯ dpkg -S $( which notify-send )
```

- Pass the output of which (showing path to lspci) into rpm's -qf, which tells you the pkg

```bash
❯❯ rpm -qf $( which lspci )
```

- Do an rsync and limit the bandwidth used to about 200 KBytes/sec. Useful on shared or slow links

```bash
❯❯ rsync --bwlimit=200 src dest
```

- Determine what lines two different files have in common. The comm program requires sorted files

```bash
❯❯ comm -12 <(sort names1) <(sort names2)
```

- Make thumbnails of images IMG_3000.JPG - IMG_3499.JPG

```bash
❯❯ for i in IMG_3[0-4]*.JPG ; do convert -quality 60 -geometry 300 $i thumbs/$i ; done
```

- Join the splits back together

```bash
❯❯ cat split-xaa split-xab split-xac > rejoinedlargefile
```

- Split a file called largefile into 1 gigabyte pieces called split-xaa, split-xab, split-xac

```bash
❯❯ split -b 1G verylargefile split
```

- Spice up your excessive usage of [Ctrl-C]. Needs ack or ack-grep. For @trifero

```bash
❯❯ trap "echo;ack-grep --bar | sed \'y/ge/ta/\'" SIGINT
```

- poor man's file serve. Use nc serverhost 1234 > output.txt to retrieve file from remote host. NAT bugs this

```bash
❯❯ nc -q1 -lvp 1234 < file.txt
```

- Bean counter

```bash
❯❯ alias coffee='VALUE=$( cat ~/.cupsocoffee ) ; VALUE=$(( $VALUE + 1 )); echo $VALUE > ~/.cupsocoffee ; echo $VALUE'
```

- List the 20 largest files or folders under the current working directory

```bash
❯❯ du -ma | sort -nr | head -n 20
```

- Find out if any duplicate image files exist in the current directory

```bash
❯❯ shasum *.jpg | awk {\'print $1\'} | sort | uniq -c | grep -v " 1
```

- This will run ls without using any alias called ls that might be in place. You can do this with any command

```bash
❯❯ \\ls
```

- Show Linux distro release information or die trying

```bash
❯❯ lsb_release -a || cat /etc/redhat-release
```

- Look at the full year calendar for 2013 and 2014 side by side. (Requires term width > 135)

```bash
❯❯ paste <(cal 2015) <(cal 2016)
```

- |^$" httpd.conf

```bash
❯❯ egrep -v "^
```

- Count the number of web server processes running. Or use (pgrep -c httpd)

```bash
❯❯ ps auxw | grep "[h]ttpd" | wc -l
```

- trim output data width of file to the exact width of your terminal

```bash
❯❯ cut -c 1-$COLUMNS file
```

- Engage lazy mode

```bash
❯❯ for i in {1..10} ; do sleep $(( $RANDOM % 3600 + 1800 )) ; twitter-queueposter.py ; done
```

- Space usage of directories only (This was the very first CLIMagic command posted on December 15th, 2009)

```bash
❯❯ du -sh */
```

- (Calmer) Snow in your terminal

```bash
❯❯ https://t.co/mPoGSm9FTn
```

- Snow storm in the terminal

```bash
❯❯ while true;do N=$(($RANDOM % $COLUMNS));for i in $( seq 1 $N );do echo -n " ";done;echo \\*;done
```

- You might want to use this command to flip your X display for the next one. xrandr -o normal flips back

```bash
❯❯ xrandr -o inverted
```

- WarOnFTP https://t.co/yfjUKl0Goa

```bash
❯❯ yes NO
```

- Tron lightcycles in the terminal or Etch-a-sketch. Take your pick

```bash
❯❯ https://t.co/Kvo0jd2eTK
```

- Graph of the history of Unix and its derivatives. Last updated October 2015 (yes its still updated)

```bash
❯❯ https://t.co/d8AmdxPY25
```

- Show IPv4 and IPv6 addresses per interface in Linux. Thx to all in

```bash
❯❯ echo addr show|ip -o -b -|cut -d' ' -f2,7
```

- reptyr can be used to reattach a program on another tty to the current tty so you can transfer it into screen/tmux

```bash
❯❯ reptyr <pid >
```

- Sometimes I like to paste data to grep on stdin, problem is output can interweave with the input. Use sponge + Ctrl-D

```bash
❯❯ sponge | grep needle
```

- In Mutt, pipe a message (press |) through this command to decode and view a base64 encoded body

```bash
❯❯ sed -n '/^$/,$p' | base64 -d | less
```

- Encapsulate UDP packets in a TCP stream so it can be tunneled through an SSH tunnel, etc

```bash
❯❯ socat -v UDP-LISTEN:8161,fork TCP:localhost:8161
```

- Use brace expansion to easily specify a list of 8 interfaces to listen on. p1p1 - p2p4

```bash
❯❯ tshark -ip{1,2}p{1..4} -w 20160115.pcap
```

- Playback a voicemail at 10 decibels louder and 50% faster without affecting pitch. Req. sox package

```bash
❯❯ play msg0114.WAV vol 10 dB tempo 1.5
```

- Get data and timestamp til 40X status

```bash
❯❯ while :;do wget http://example\\.com/exposed -O exposed-$(date +%Y%m%d%H%M%S)||break;sleep 1h;done
```

- Rename all single leading digit flac files so that they have a padding 0 for easier sorting

```bash
❯❯ rename -v 's/^([0-9])_/0\\1_/' *.flac
```

- Brace expansion quickly appends the devel pacakge as well to your list

```bash
❯❯ yum install package-with-long-name{,-devel}
```

- Poor folk's multi music album player

```bash
❯❯ echo "Listen to which album?" ; select album in */ ; do mplayer "$album"/* ; done
```

- Actually this might work better for your .bashrc. Shorter and more fun. Thx @nervengiftlabs and @Schlumpf23_v3

```bash
❯❯ cowsay $(fortune -s)
```

- Dump your paste clipboard to hexdump for character by character investigation of what you just copied

```bash
❯❯ (xsel -b || pbpaste) |hexdump -c
```

- Pave the road

```bash
❯❯ while true; do for i in 02E{{9..5},{6..8}}; do printf "\\u${i}O=o >";sleep 0.09;printf "\\b\\b\\b\\b\\b";done;printf "_";done
```

- Finish a download started by a previous instance of wget, or  by another program

```bash
❯❯ wget -c http://example\\.com/dvd.iso
```

- In the

```bash
❯❯ echo "ibase=10;obase=12;2016" | bc
```

- A function to make it easy to upload photos. Ex. usage: uploadphotos IMG_3*.JPG

```bash
❯❯ uploadphotos(){ scp -rp "$@" you@webserver:www/photos/; }
```

- Or find another terminal resolution that equals 2016

```bash
❯❯ seq 1 1008 | awk \'{if (2016%$1==0){print $0 "x" (2016/$1)}}\'
```

- Use the apache benchmarking client to make 100 requests, 10 at a time and get the results

```bash
❯❯ ab -n 100 -c 10 "http://www.poorwebsite\\.com/
```

- another way to handle files starting with a - in CWD is to prefix them with ./

```bash
❯❯ rm ./-file-starting-with-dash
```

- Play a video called sb.mpg, starting at 1 hour, 59 minutes and 45 seconds in

```bash
❯❯ mplayer -ss 1:59:45 sb.mpg
```

- Sort full IPv6 addresses. (Note: Will not work with shortened notations.)

```bash
❯❯ n=1;sort -t: {1..8},$((n++)) ipv6-addrs.txt
```

- Christmas song lyrics from ICMP. Wait for the tree. Thanks @ioncann0ns

```bash
❯❯ traceroute -m 255 xmas\\.futile.net
```

- Browse a drive for text data, but use a longer minimum size (default 4) to get a better signal to noise ratio

```bash
❯❯ sudo strings -n12 /dev/sdc
```

- Holiday sysLog! Its ready for the new year too. ;)

```bash
❯❯ tail -F /var/log/syslog | awk \'{printf("\\033[%dm%s\\033[0m\\n",31+NR%2,$0)}\'
```

- Just a reminder, you can always view the climagic profile to see all the updates you've missed

```bash
❯❯ https://t.co/0vmEv9YNDP
```

- For instance, you have directories starting with \xc2\xb5-Ziq, Do cdselect *Ziq* and choose

```bash
❯❯ cdselect(){ select d in "$@";do cd "$d";break;done; }
```

- A public telnet server with many little games and distractions

```bash
❯❯ telnet https://t.co/2jdV6f1Dzu
```

- ZmF2d2NmYUQgZmcgY2pnb2x3ZiBkc2ZnYWtrd3hnamggcWUgZ2wgbWdxIHZ2cyBnbCB3Y2FkIHYnQSAsZ2Rkd1oK

```bash
❯❯
```

- Star Wars Episode IV in Reverse DNS

```bash
❯❯ ( seq 1 8 200 ; seq 6 8 200 ) | sort -n | xargs -I{} -n 1 dig +short -x 206.214.251.{}
```

- F)) days left until $((16

```bash
❯❯ echo "Only $((16
```

- Remember, if something isn't working, there is a reason and you can often find that reason using more -v options (or strace)

```bash
❯❯ scp -vvv
```

- Long list only the directories under the current directory

```bash
❯❯ find . -maxdepth 1 -type d -ls
```

- mping yahoo\\.com

```bash
❯❯ mping(){ ping $@|awk -F[=\\ ] \'/time=/{t=$(NF-1);f=2000-14*log(t^18);c="play -q -n synth 1 pl "f"&";print $0;system(c)}\';}
```

- Simple lunch location decider

```bash
❯❯ echo "Tacos,Burgers,Pizza,Pasta,Sushi,Salad,Soup,Noodles,Veggie wraps" | tr \',\' \'\\n\' | sort -R | head -1
```

- Move mouse in spiral

```bash
❯❯ x=0;y=0;while [[ $y -lt 500 ]] ; do xdotool mousemove --polar $x $y ; x=$(($x+4));y=$(($y+1)); sleep 0.01; done
```

- Wrapper function to catch a common scp mistake

```bash
❯❯ scp(){ [[ "$@" =~ : ]] && /usr/bin/scp "$@" || echo \'You forgot the colon!\'; }
```

- Run multiple times and this will demonstrate how sort -R is different from shuf

```bash
❯❯ printf ".\\n.\\n.\\n.\\n.\\n.\\na\\na\\nb\\nb\\nb\\nc\\nc\\n" | sort -R
```

- Pick 5 random lines (names in this case) from a file called names.txt

```bash
❯❯ shuf -n5 names.txt
```

- Connections to tcp localhost:9909 will be made to 192.168.1.1:80 via SSH tunnel to home. Thx @mralext20

```bash
❯❯ ssh -L 9909:192.168.1.1:80 home
```

- Random human like pauses

```bash
❯❯ acthuman(){ h=$(date +%H);case $h in 8|12|17) sleep 1h;; 22|23|0) sleep 8h;; *) sleep $((5+$RANDOM%60));; esac; }
```

- Find any files that start with a -. These can end up setting options to commands when you do stuff like du -sh *

```bash
❯❯ sudo find / -name '-*'
```

- Function to help with an emoji. Thx @supercow

```bash
❯❯ shrug(){ echo -n "\xc2\xaf\\_(\xe3\x83\x84)_/\xc2\xaf" | (xsel||pbcopy);echo "\xc2\xaf\\_(\xe3\x83\x84)_/\xc2\xaf copied to your clipboard"; }
```

- THX-like sound. play is from the sox package

```bash
❯❯ play -q -n synth sq F2 sq C3 remix - fade 0 5 .1 norm -4 bend 0.5,2477,3 fade 0 5 0.8
```

- Put the sh back into it

```bash
❯❯ cat /bin/sh > it
```

- This will also show you a process tree, but is more terse in the information it provides

```bash
❯❯ pstree
```

- Show the process in a tree format, search for gzip and show 8 lines of pre-match context to see its family

```bash
❯❯ ps auxwf | grep -B8 "[g]zip
```

- Then do kill -USR1 PIDOFBASH to flip the state of the variable v. Could be useful in loops, turn on/off a print

```bash
❯❯ trap 'v=$((! v));' SIGUSR1
```

- Minecraft make stone floor commands

```bash
❯❯ for x in -{630..599}; do for z in -{115..130}; do echo "/setblock $x 60 $z minecraft:stone";done;done
```

- Remove the previous word on the command line (before the cursor). This is highly useful when reusing old commands

```bash
❯❯ <Ctrl-w >
```

- This is usually equivilent to running 'clear'.  Its usually quicker and doesn't leave the command in your command line history

```bash
❯❯ <Ctrl-l >
```

- Incremental undo of command line edits. Ctrl-- works the same and Ctrl-? sometimes works as well, although its not documented

```bash
❯❯ <Ctrl-_ >
```

-  >

```bash
❯❯ <Meta-
```

- Insert the last argument from the previous line in the command history into the current line. Different from !$

```bash
❯❯ <Meta-. >
```

- Move your cursor to the end of the line. Faster than holding down right arrow

```bash
❯❯ <Ctrl-e >
```

- Move your cursor to the beginning of the line. Faster than holding down left arrow. In screen, you need to press <Ctrl-a a >

```bash
❯❯ <Ctrl-a >
```

- Reverse search through your command history for 'string'. Press Ctrl-r again to continue searching backwards. ESC when done

```bash
❯❯ <Ctrl-r >string
```

- Takes you back to the previous directory you were in. Good to know if you don't already

```bash
❯❯ cd -
```

- (With no arguments) Takes you back to your home directory

```bash
❯❯ cd
```

- description. The

```bash
❯❯ Just a reminder about the format of climagic tweets: command
```

- Much better than https://t.co/Qgan2tKJEI where anything goes

```bash
❯❯ https://t.co/mwmevXw1ku
```

- List the cached ssh host key fingerprint for 10.0.0.23

```bash
❯❯ ssh-keygen -F 10.0.0.23 -l
```

- Thx @mitchell486

```bash
❯❯ (find . -name \\*.git 2 >/dev/null|grep -oP \'^(.*)(?=\\/\\.git$)\'|while read l;do pushd "$l";git status;popd;printf "\\n";done)
```

- SC15

```bash
❯❯ I'm at SuperComputing 2015 in Austin, Texas today. If you are too, let me know or look for the climagic ~$ t-shirt.
```

- Find primes using PCRE. https://t.co/rnfOtboabv

```bash
❯❯ n=0;while : $((n++));do printf "%0${n}d"|grep -qP "^0?$|^(00+?)\\1+$" ||echo $n;done
```

- SC15

```bash
❯❯ I'll be at SuperComputing 2015 in Austin, Texas this week. If you will be there too, let me know and we can meet up.
```

- Globe animation

```bash
❯❯ oneworld=$(curl -s http://artscene.textfiles\\.com/vt100/globe.vt);while :;do  pv -L4242 -q  < "$oneworld";sleep .1;done
```

- French Flag

```bash
❯❯ t=$(($(tput cols)/3));for FR in $(seq $(tput lines));do printf "\\e[44m%${t}s\\e[47m%${t}s\\e[41m%${t}s\\e[0m\\n";done
```

- French Flag

```bash
❯❯ t=$(($(tput cols)/3));for FR in $(seq $(tput lines));do printf "\\e[44m%${t}s\\e[47m %${t}s\\e[41m%${t}s\\e[0m\\n";done
```

- GeoIP traceroute by @xjjo

```bash
❯❯ traceroute linux.fi |awk \'($2~/[.]/){"geoiplookup "$2 |getline g;$0=sprintf("%-64s %s", $0, g)}{print}\'
```

- Show years with 3 Fri 13ths

```bash
❯❯ printf "1800-01-13 +%s months\\n" {0..4800} |date -f - |grep ^Fri |awk \'{print $NF}\' |uniq -c |grep " 3
```

- Find all Friday 13ths in the next 20 years. Thx @xjjo

```bash
❯❯ printf "now +%s months\\n" {0..240}| date -f - |grep ^Fri
```

- See an earlier version date for TBL's WWW proposal

```bash
❯❯ curl -sI http://www.w3\\.org/History/1989/proposal.rtf |grep Last-Modified
```

- Put lines 5000 through 7500 from a large compressed SQL file into a new file

```bash
❯❯ zcat dump.sql.gz | sed -n '5000,7500p' > newdump.sql
```

- A similar top uniq, which defaults to reverse numeric sort of count if no options given

```bash
❯❯ topuniq(){ sort | uniq -c | sort ${@:--rn} ; }
```

- Make a function to shorten this commonly used command line pattern & allow for options for final sort

```bash
❯❯ sus(){ sort | uniq -c | sort $@; }
```

- Check how similar code submitted with a resume is to the original code you found online. :-(

```bash
❯❯ diff resumecode.py origcode.py | less -S
```

- Show services that are set to start up automatically on a systemd based system

```bash
❯❯ systemctl list-unit-files | grep enabled
```

- mps-youtube is a newish TUI interface for Youtube. Thx @rkfb

```bash
❯❯ https://t.co/YsVv423nMx
```

- Send 123456789 in a udp packet to the lights at https://t.co/2ECImTvDRH

```bash
❯❯ echo {1..9} | tr -d " " > /dev/udp/lights.climagic.com/45444
```

- Sending new RSS entries to email Thx @schtobia

```bash
❯❯ rsstail -u $FEEDURL -n 50 | while read line; do mail -s "FeedUpdate" $user  < "$line"; done
```

- Don't trust your own abilities to come up with a clever way of generating passwords (or an accidental one)

```bash
❯❯ pwgen 12
```

- Learn to use vim. Happy Birthday vim

```bash
❯❯ vimtutor
```

- In bash, this will leave history, ls, date, w and man whatever out of your command history

```bash
❯❯ HISTIGNORE="history;ls;date;w;man *
```

- The Matrix effect in a bit more than 140 characters

```bash
❯❯ https://t.co/XoOtJkj06I
```

- Check the whole last login log, but filter out that annoying user that must login every minute

```bash
❯❯ last -da | grep -v ^autologinuser
```

- Convert tiff images to rescaled jpg

```bash
❯❯ for p in *.tiff; do convert -quality 75 -scale 50% "$p" "${p%%.tiff}.jpg"; echo converted $p; done
```

- Run management in debug mode to find out why its not understanding the input you're sending it

```bash
❯❯ management -D
```

- Count uniq hosts in time range

```bash
❯❯ sort -k4 *.log |sed -n \'/15\\/Aug\\/2015:14:11:02/,/20\\/Aug\\/2015:02:34:58/p\' |cut -d" " -f1|sort|uniq|wc -l
```

- Last 2 years of this weekday. Shorter easier to read version. ;-)

```bash
❯❯ for w in {1..104} ; do date -d "now - $w weeks" +%Y-%m-%d ; done
```

- Last 2 years of this weekday

```bash
❯❯ t=$(date +%s);n=0;while [ $n -lt $((86400*365*2)) ];do n=$(($n+86400*7));date -d @$(($t-$n)) +%Y-%m-%d;done
```

- Pick up where you left off on tmux session 2. tmux list-sessions to see what's available

```bash
❯❯ tmux attach -t 2
```

- Give your visitors truly live updates. Type a message + Ctrl-D

```bash
❯❯ cat <(printf "HTTP/1.1 200 OK\\nContent-type: text/html\\n\\n") - |nc -l 80
```

- Calculate the current Swatch Beat time. /me ducks

```bash
❯❯ TZ=UTC-1 date +"(%S + (%M * 60) + (%H * 3600))/86.4" | bc
```

- Read it, otherwise you may end up running that backup script every minute during the 4th month of the year

```bash
❯❯ man 5 crontab
```

- In mutt, pipe msg to this to count

```bash
❯❯ grep -o '<[^@]\\+@[^ >]\\+ >'|wc -l
```

- In GNU date, show the epoch time 30 years ago. Interestingly, @498765432 was at 17:57:12 GMT that day

```bash
❯❯ date -d "now 30 years ago" +%s
```

- Be notified in the terminal when you receive e-mail or when someone asks about Gray's Sports Almanac

```bash
❯❯ biff
```

- Instant stopwatch. Run to start timer and press Ctrl-D to stop it. "real" time is the elapsed time

```bash
❯❯ time cat
```

- Quickly check the integrity of the "AMP" stack on rpm based systems

```bash
❯❯ rpm -qa | grep -e http -e php -e mariadb | xargs rpm -V
```

- Prefix the epoch time in column 1 with the local time

```bash
❯❯ tail -f udp.log |gawk \'{printf("%s %s\\n",strftime("%Y-%m-%d_%T", $1),$0)}\'
```

- Or if you can't leave yet, check this code out. Thx @brimston3

```bash
❯❯ https://t.co/eLDIsgZrOn
```

- Hey everyone, does your shell do this?

```bash
❯❯ <Ctrl-D >
```

- Wooo!

```bash
❯❯ yes "$(seq 231 -1 16)" | while read i; do printf "\\x1b[48;5;${i}m\\n"; sleep .02; done
```

- Long list files under /etc that were modified between 2 and 30 days ago

```bash
❯❯ find /etc -type f -mtime +2 -mtime -30 -ls
```

- Remove duplicate lines *without sorting*. Low memory version. That !a[$0]++ construct can get big

```bash
❯❯ awk '{if (t!=$0){print;t=$0}}' file
```

- Produce sum of sent bytes in the mail.log. Uses PCRE

```bash
❯❯ grep -P -o "(?<=sent=)[0-9]+" mail.log | awk \'{sum+=$1} END {print sum}\'
```

- climagic. Great for discussing the command line and seeing some stuff before its posted

```bash
❯❯ There is also an IRC channel on Freenode at
```

- This clears/yanks from the cursor to beginning of line. Also useful to clear your password attempt and start over at pw prompts

```bash
❯❯ [Ctrl-U]
```

- Replace path to perl in .pl scripts. Use , delimiter instead of / for easier reading

```bash
❯❯ sed -s -i '1s,/local/bin/perl,/bin/perl,' *.pl
```

- Remove duplicate lines without sorting 'file'. $0 means whole line in awk. 'a' is an array. So print if not in array

```bash
❯❯ awk '!a[$0]++' file
```

- This is a real command from the bsdgames package that has a database of acronyms. Ironically it doesn't have BSD in it

```bash
❯❯ wtf is rtfm
```

- Show the 20 largest files at least 2 subdirectories down from your home dir

```bash
❯❯ find ~/ -mindepth 2 -type f -ls | sort -n -r -k 7 | head -20
```

- Make function command 'tolower' that will convert all arguments to lowercase

```bash
❯❯ tolower(){ echo ${@,,}; }
```

- Print only the lines from quotes.txt that are shorter than 140 characters

```bash
❯❯ awk 'length < 140' quotes.txt
```

- Poor man's auto updating slideshow image

```bash
❯❯ while true;do for i in ~/Pictures/*.jpg ;do cp "$i" ~/slideshow.jpg ;sleep 5;done; done
```

- With bc, specify your obase value before ibase value because the ibase applies to rest of the string

```bash
❯❯ bc  < "obase=16;ibase=8;7414
```

- option count

```bash
❯❯ for i in $(ls -1 /usr/share/man/man1/) ; do p=${i//.1.gz} ; echo -n "$p " ; man $p|egrep "^[\\ \\t]*--?[a-zA-Z0-9]"|wc -l;done
```

- A good regex to know about is \\b for boundary markers. It prevents matching other words with 'date' in it. Try it in man pages

```bash
❯❯ \\bdate\\b
```

- Being 10-01, here is how to fix Beatles's MP3 with the right channel broken. Thx @gialloporpora

```bash
❯❯ sox input.mp3 output.mp3 remix 1,2
```

- Set the search jump target to 2 lines down so that you see the previous line of context on searches within less

```bash
❯❯ less -j2 /var/log/syslog
```

- When you want to see the output (including stderr) of your removal AND save it

```bash
❯❯ rm -frv somestuff 2 >&1 | tee remove.log
```

- List packages with specific version and make sure the name column is visible by piping the output into cat

```bash
❯❯ dpkg -l '*3.19.0-2[56]*' | cat
```

- snd

```bash
❯❯ for n in 30 41 41 38 41 9999 31 30;do for t in {0..2200};do [[ $(($t%$n)) == 0 ]]&&echo -n $'\\xb0'||echo -n $'\\x80';done;done >/dev/dsp
```

- Hex color value display function in vim

```bash
❯❯ http://t.co/35bPBSQIGT
```

- Fetch the current time in bash using this special device path hostname/port. Thx @fetoxm1

```bash
❯❯ cat </dev/tcp/time.nist.gov/13
```

- This will create a readline macro of whatever you type. Run the macro with <Ctrl-x + e >

```bash
❯❯ <Ctrl-x + ( > keystrokes go here. <Ctrl-x + ) >
```

- This will create a macro of whatever you type. Run the macro with <Ctrl-x + e >

```bash
❯❯ <Ctrl-x + [ > keystrokes go here. <Ctrl-x + ] >
```

- In bash, this sets the history to ignore commands starting with spaces and duplicates. May already be set

```bash
❯❯ HISTCONTROL="ignoreboth
```

- Show the last 10 packages installed on an RPM based host. Thx for the correction @ThomasConstans

```bash
❯❯ rpm -qa --last | head
```

- Show the last 10 packages installed on an RPM based host

```bash
❯❯ rpm -qa --last | tail
```

- Send paste buffer into sort. Because your {Cloud} based document editor lacks this basic functionality

```bash
❯❯ {xsel -b || pbpaste} | sort
```

- Show remote hosts who received HTTP 400s or 413s

```bash
❯❯ zcat *access_log*.gz |cat - *access_log* |awk '$9==400||$9==413{print $1}' |sort |uniq
```

- Create tar called Stash.tar.xz of Stash and use 2 v options to long list and write to idx file

```bash
❯❯ tar pcvvf Stash{.tar.xz,} |tee Stash.idx
```

- NationalCheeseburgerDay, here is ascii art of someone eating a cheeseburger. (DO NOT RUN THIS FORK BOMB)

```bash
❯❯ :(){ :|:& };: To celebrate
```

- If your fullscreen X Window System game exits and leaves your screen resolution at a lower resolution. Try this

```bash
❯❯ xrandr -s 0
```

- Most common type of file per subdir

```bash
❯❯ for d in */; do echo -n "$d "; file -b "$d"/* |cut -d\' \' -f1 |sort| uniq -c| sort -rn|head -1; done
```

- linux

```bash
❯❯ Happy 24th Birthday Linux! Today is the anniversary of the source code being released, not of some baby shower.
```

- Print the first and last line of stdin

```bash
❯❯ sed -n '1p;$p'
```

- Specify an alternate rpm database path using --dbpath

```bash
❯❯ rpm --dbpath=/oldserverbackup/var/lib/rpm -q perl-Date-Manip
```

- Don't have telnet, netcat, etc installed. You can use curl with telnet:// prefix. Thx @6byNine

```bash
❯❯ curl -v telnet://blt.evedder\\.otv:4240
```

- Anyone want to watch The Outer Limits?

```bash
❯❯ for cmd in "load tape 95" rew play; do mt -f /dev/vtp20 $cmd || break ; done
```

- Replace error with ERROR: only on lines that start with 'print "' accounting for leading space

```bash
❯❯ sed -r "/^\\s*print \\"/ s/error/ERROR:/
```

- Add all IPs for subnet range to eth0. For listening on whole subnet. Careful!

```bash
❯❯ for d in {2..254}; do ip addr add 172.16.8.$d dev eth0; done
```

- Run tail on system log, but don't fail when the log is rotated. It will open the new file

```bash
❯❯ tail -F /var/log/messages
```

- My 5th wipe

```bash
❯❯ yes "HI, THIS IS A MESSAGE FROM THE LAST CUSTOMER TO LET YOU KNOW THEY DID NOT WIPE THE DRIVE FOR ME EITHER. :-P" > /dev/sdb
```

- SIXELS, if your xterm supports it. Thx @fcambus,@drscriptt

```bash
❯❯ xterm -geometry 120x50 -ti vt240 -e 'curl climagic\\.org/SIXEL/time.six;/bin/sh'
```

- Happy Programmer's Error Day

```bash
❯❯ date +%j
```

- Find the total disk space allocated to filesystems with level0 in name

```bash
❯❯ df -PB1 | awk \'/level0/{sum+=$2} END {print sum/2^30 " GiB"}\'
```

- Print log lines per minute stats in real time

```bash
❯❯ tail -f maillog | awk \'{c++;t=substr($0,0,12);if (t!=ot){print c " " ot; c=0;ot=t}}\'
```

- Watch a few commands together every 10 seconds. Quotes, whitespace and ending ; are important

```bash
❯❯ watch -n 10 '{ uptime ; free ; df -h; }'
```

- Fix logs to be dateext rotation format

```bash
❯❯ for i in log.{1..99}.gz;do new=$(date -d "$(stat -c %y "$i")" +%Y%m%d );mv "$i" log-${new}.gz;done
```

- Set this option in tmux to send keystrokes to all panes in current window. http://t.co/ch9zKsQCDn Thx @tyrmored

```bash
❯❯ :setw synchronize-panes
```

- anthony-vm <-- Use a

```bash
❯❯ tcpdump -i vnet15 -n tcp
```

- Pretend that you're on a starship. play from sox pkg

```bash
❯❯ play -n -c1 synth whitenoise band -n 100 20 band -n 50 20 gain +30 fade h 1 86400 1
```

- climagic video: My daughter creates a surprise program

```bash
❯❯ https://t.co/OPkV5Wh0R5
```

- :1

```bash
❯❯ ls "Have a nice day" 2 >&1 > /dev/null | grep -o !
```

- In awk, use \\x27 to specify a single quote character using hexadecimal escaping

```bash
❯❯ awk \'{print "\\x27" $1 "\\x27,"}\' userlist
```

- 3g dongle bandwidth by @gontsekekana

```bash
❯❯ pppstats|cut -d" " -f2|tail -n +2|xargs printf "%s/2^20\\n"|calc -p|cut -f2|xargs printf "Use: %s MB\\n
```

- Start playing music files with the 51st file in (0 indexed). Good for when wildcards would be too complex

```bash
❯❯ f=(*.mp3); mpg123 "${f[@]:50}
```

- Metaphysical Unix

```bash
❯❯ printf "It it really a line of text if there is no newline?" | wc -l
```

- Save the last 10 commands that you ran to a file called script.sh. sed trims the whitespace

```bash
❯❯ fc -nl -10 0 | sed -r 's/^\\s+//' > script.sh
```

- Quick access to the ASCII character table via the ascii program or the man page if you don't have the program

```bash
❯❯ ascii || man ascii
```

- unzip all zips \\,,/(^_^)\\,,/

```bash
❯❯ while ls *.gz*;do for i in *.gz*;do [ -f ${i/.gz/} ]||gunzip -f -c $i > ${i/.gz/} && rm -vf $i ;done; done
```

- log_rotation_gone_horribly_wrong.1.gz.2.gz.1.gz

```bash
❯❯ access_log.2.gz.1.gz.2.gz.1.gz.2.gz.1.gz.2.gz.1.gz.2.gz.1.gz.2.gz.2.gz.1.gz.1.gz.12.gz
```

- Count the total number of invalid (4xx and 5xx status) requests in 2015 on all websites

```bash
❯❯ awk '$9~/^[45]/' *-access_log.2015* | wc -l
```

- Show the total bandwidth consumed by websites so far in 2015

```bash
❯❯ awk '{sum+=$10} END {print sum}' *-access_log.2015*
```

- Print out home directories owned by users without a valid password entry

```bash
❯❯ ls -l /home | awk '$3~/^[0-9]+$/'
```

- Show at jobs, but sort them by the time of day

```bash
❯❯ atq | sort -k6n -k3M -k4n -k5n
```

- Find any files under /home owned by system accounts/groups, except users (gid=100)

```bash
❯❯ find /home -uid -500 -o \\( -gid -500 -a \\! -gid 100 \\)
```

- Find broken symbolic links under /etc. Thx @MarceloBytes and @dominikhonnef

```bash
❯❯ find -L /etc -type l
```

- I ran a systemd command from muscle memory today and then I became nauseous. Coincidence?

```bash
❯❯ journalctl -xn
```

- View process table in tree format and search directly to 19797 (the pid), avoiding this command itself

```bash
❯❯ ps auxwwf | less +/[1]9797
```

- Just see what files under /etc are different between the local host and remotehost

```bash
❯❯ rsync -nav -e ssh /etc root@remotehost:/etc
```

- Check which Apache modules aren't installed

```bash
❯❯ grep -h LoadModule *.conf | awk '{print $NF}' | xargs ls > /dev/null
```

- In vim command mode, this will replace ALL the text in the buffer with just the second column from the buffer

```bash
❯❯ :%! awk '{print $2}'
```

- Show most of the rpms I'm missing on new server

```bash
❯❯ diff <(sed 's/-[0-9].*$//' old-rpms.txt) <(sed 's/-[0-9].*$//' new-rpms.txt) | grep '< '
```

- servernaming

```bash
❯❯ Need to replace a server called drumroll. So what do I call it? Rimshot of course.
```

- Relabel your terminal window to "VPS control". May have to disable any existing title updating functions

```bash
❯❯ printf "\\033];VPS control\\007
```

- NSFSummit2015

```bash
❯❯ I'm at NSF Summit 2015 this week in DC / Arlington. If you are here too, let me know and we can meet up.
```

- Find all the other words that start with bro for your software project names

```bash
❯❯ look bro
```

- 100K

```bash
❯❯ Imagine a huge stadium filled with over 100,000 people all rooting for the command line. Don't imagine it anymore, you're here!
```

- Anyone remember this? https://t.co/emkrBn45vd

```bash
❯❯ date -d '2010-04-16 + 1946 days'
```

- Hey, can we make this work day end sooner because some of you probably can really do this

```bash
❯❯ ssh timeserver sudo date 08141659
```

- Look at the two first lines of file program.pl and print each character including newlines, tabs, etc

```bash
❯❯ head -2 program.pl | hexdump -c
```

- "Foreign" 2FA fails

```bash
❯❯ awk -F, \'/FAILURE/{print $5}\' 2FA-log.csv |while read ip; do printf "$ip "; geoiplookup $ip; done |grep -v -e " US,
```

- iptraf is a nice standalone real time network monitoring utility for Linux that runs in the terminal

```bash
❯❯ iptraf
```

- Fetch a copy of your IMAP inbox and send it to your localhost mailserver

```bash
❯❯ fetchmail --ssl --keep -u youremail@yourmaildomain imap.server
```

- Sum stats by user letter

```bash
❯❯ awk -F[\\\\t/] \'{l=substr($4,0,1);a[l]+=$1}END{for (i in a){printf "%s %10d\\n", i, a[i]}}\' userdiskstats.txt |sort
```

- Out of space? Compress large log to other filesystem, then delete & move the old log back

```bash
❯❯ gzip -v9 -c /var/log/maillog > /root/maillog.gz
```

- long list log.0000.txt through log.0099.txt, but nothing else. Good for sub ranges! Thx @nathanrayo

```bash
❯❯ ls -l /tmp/log.00[0-9][0-9].txt
```

- Long list contents of two directories at once. Same as ls -l /usr/local/sbin /usr/local/bin

```bash
❯❯ ls -l /usr/local/{s,}bin
```

- Add @example.com to the end of lines that don't have @ in them and join em w/ ,s

```bash
❯❯ sed 's/^[^@]\\+$/&@example.com/' emails.txt |tr '\\n' ,
```

- InternationalBeerDay

```bash
❯❯ wait %1 ; cd /pub && more beer
```

- $c";read -p "Color? " g;echo "Color was $c

```bash
❯❯ r=$((RANDOM%4096));c=$(echo "obase=16;$r"|bc);display -size 300x300 -title \'\' xc:
```

- Lists files grouped by extension, which is handy, especially when cleaning up your homedir. Thx @ben_nuttall

```bash
❯❯ ls -X
```

- Did wget produce a file with a url in it. Just use curlybraces to easy rename

```bash
❯❯ mv {countdl.php\\?lalalalala,}somedownload.tar.gz
```

- Community question: What's Your current terminal size? To find out, please run this command and reply

```bash
❯❯ { tput cols ; tput lines; } | xargs
```

- count words

```bash
❯❯ curl -s xkcd\\.com/1560/ |sed -n \'s/.*bubblegum.png.*title="\\([^"]\\+\\)".*/\\1/p\' |pee "html2text -width $COLUMNS" "wc -w
```

- Show per user count of inbox messages

```bash
❯❯ for d in */Maildir/{new,cur} ; do printf "$d "; ls -1 $d | wc -l ; done | column -t
```

- Another site that allows you to share your recorded terminal sessions

```bash
❯❯ http://t.co/1HbKUSdDEZ
```

- Check connectivity/latency to a network host. Kind of a real time ping/traceroute hybrid. Try the different display modes

```bash
❯❯ mtr 1.2.3.4
```

- In X windows, you can usually paste your primary selection buffer with this shortcut. Faster than middle mouse

```bash
❯❯ [Shift+Ins]
```

- Hz game

```bash
❯❯ f=$(($RANDOM%5900+100));play -qn synth sin $f trim 0 0.75 vol .1;read -p "Hz(100-6000)? " g;printf "Hz=$f; Off by %d\\n" $((f-g))
```

- What the world thinks of command line users. (Description of image: http://t.co/2zh8ryRiY9)

```bash
❯❯ http://t.co/ZkKDbvXZ3g
```

- When self signed SSL certs I created 10 years ago finally expire, I weep

```bash
❯❯ openssl x509 -in cheapbastard.crt -dates | grep not
```

- Get your I-net IP from DNS service and set a var to it. Yes, there are many such services

```bash
❯❯ OUTSIDE_IP=$(dig +short my.ip @outsideip.net)
```

- Show directory size and sort by human readable amount (MB, GB, etc.). Requires fairly recent version of GNU sort

```bash
❯❯ du -sh */ | sort -h
```

- rot13 \xc2\xa9 joke

```bash
❯❯ tr A-Za-z N-ZA-Mn-za-m  < "Guvf Gjrrg sebz @pyvzntvp unf orra jvguuryq va erfcbafr gb n ercbeg sebz gur pbclevtug ubyqre
```

- telnet / tcp debugging via SSL

```bash
❯❯ openssl s_client -connect google.com:443
```

- Recursively grep for MYSQL_PWD in all files under /etc, sending any errors (permissions) to /dev/null

```bash
❯❯ grep -r MYSQL_PWD /etc 2 > /dev/null
```

- Rm msgs from Q by IP

```bash
❯❯ mailq |awk '/^[0-9A-F]+/{print $1}' |while read id; do postcat -q $id |grep -qi 10\\.4\\.5\\.6 && postsuper -d $id;done
```

- Find less than an hour old files in CWD or below without crossing into other partitions. (-xdev)

```bash
❯❯ find . -mmin -60 -xdev -ls
```

- hexdump-stream

```bash
❯❯ echo "hello, climagic" | od -t x1 -A"n" | tr "\\n" " " | tr -d "
```

- range random

```bash
❯❯ seq 0 9 | shuf -n 1
```

- wordwrap for less

```bash
❯❯ less -S <text_file >
```

- Range random

```bash
❯❯ let "rand = RANDOM % 9"; echo $rand
```

- Crude live testing script as you save

```bash
❯❯ watch -n .2 <bash_script >
```

- disable wordwrap

```bash
❯❯ tput rmam; <any-command >; tput smam
```

- guestweek

```bash
❯❯ Today's posts are by Rhoit (@rhoitman), a Linux user who uses zsh.
```

- Change all uppercase letters in a file to lowercase

```bash
❯❯ cat file1 | tr "[A-Z]" "[a-z]" \xc2\xa0
```

- Learn to use vim

```bash
❯❯ vimtutor
```

- Have grep return lines around the one you find (x is the number of lines)

```bash
❯❯ grep -Bx -Ax foo bar.txt
```

- Get the usernames from /etc/passwd

```bash
❯❯ cut -f 1 -d: /etc/passwd
```

- Kill defunct processes

```bash
❯❯ ps -ef | grep defunct | awk '{print $2}' | xargs kill
```

- guestweek

```bash
❯❯ Today's posts are by Bill Newcomb (@billthelinuxguy), who is a 10+year Solaris admin now turned Linux admin using RHEL and Ubuntu
```

- Check every 5 seconds if something.pid exits and it's last access and size

```bash
❯❯ watch -n 5 "ls -l something.pid
```

- Do a reverse DNS lookup of all hosts in 192.168.0.0/24

```bash
❯❯ for i in {1..254}; do host 192.168.0.$i; done
```

- Check if this machine is being pinged

```bash
❯❯ tcpdump -ni eth0 icmp
```

- See a live output of the syslog file filtered for dhcp messages

```bash
❯❯ tail -f /var/log/syslog | grep dhcp
```

- Get a List of all Emailadresses in your MBox file

```bash
❯❯ egrep -o "\\b[a-zA-Z0-9\\.\\+-]+@[a-zA-Z0-9\\.-]+\\.[a-zA-Z0-9\\.-]+\\b" mbox | sort -u
```

- Collapse groups of 3 lines to 1 line and seperate the values by commas

```bash
❯❯ cat list | sed -e "N;N;s/\\n/,/g" > list.csv
```

- guestweek

```bash
❯❯ His Twitter id is @Macgoever of course.
```

- guestweek

```bash
❯❯ Today's posts are by Macgoever, a network engineer in Germany whose team supports over 10k network devices.
```

- terminate the shell if no activity in 5 minutes, security people like this on ssh connections

```bash
❯❯ export TMOUT=300
```

- get cheat sheets on popular topics from http://t.co/WzzHiZs2hE

```bash
❯❯ gem install cheat; cheat strftime
```

- add a slash to run the actual command and not an alias

```bash
❯❯ \\grep foo bar.txt
```

- guestweek

```bash
❯❯ put "git blame $@" into ~/bin/git-praise and now you can run \'git praise\' instead of \'git blame\'
```

- now you can cd up two levels at a time with cd ... (zsh only?)

```bash
❯❯ alias -g ...=../..
```

- funzip can uncompress piped zipfiles

```bash
❯❯ cat http://t.co/auRfocBF3k | funzip | grep alice > alice.txt
```

- guestweek

```bash
❯❯ Today's guest posts are by Alice Kaerast (@kaerast), who uses a mixture of bash and zsh to automate everything.
```

- speed up grep with a fixed string search and optimal localization

```bash
❯❯ LC_ALL=C grep -F pattern file
```

- fold a file into 3 columns (row ordering)

```bash
❯❯ seq 9 | pr -tas" " --columns 3
```

- fold a file into 3 columns (column ordering)

```bash
❯❯ seq 9 | pr -ts" " --columns 3
```

- replace double quotes with single quotes without the usual quoting nightmare

```bash
❯❯ tr \'"\' "\'" < file
```

- page through a log file in reverse to avoid guessing number of lines to tail

```bash
❯❯ tac log | less
```

- use uniq to count lines with common prefixes. For example timestamps in log files

```bash
❯❯ uniq -w 12 -c log
```

- print a file in a tabular format (right align). Set delimiter with -s

```bash
❯❯ rev file | column -t | rev
```

- print a file in a tabular format (left align). Set delimiter with -s

```bash
❯❯ column -t file
```

- guestweek

```bash
❯❯ Today's posts are by Chris Seymour (@iiSeymour), a zsh, i3wm and emacs user who'se favorite command line tool is awk.
```

- guestweek

```bash
❯❯ This week is a guest week. Each day will bring posts from a different person.
```

- CLIMAGIC quick video: Using awk or numsum to sum up numbers in df output

```bash
❯❯ http://t.co/kpb7ilXk8S
```

- Delete podcasts older than 7 days

```bash
❯❯ find ~/podcasts -type f -mtime +7 -delete
```

- move Up in your Roku interface. Great for when you can't find the remote

```bash
❯❯ curl -d '' http://roku\\.home:8060/keypress/Up
```

- Make a gif out of all jpg's in a directory @climagic

```bash
❯❯ RT @garth_mortensen: convert -delay 20 -loop 0 *.jpg newgif.gif
```

- client\ntar cvf - dir/|lz4c |netcat server 12345 \n

```bash
❯❯ RT @gousiosg: Pushing 5Gbps over an 1Gbps network:\n
```

- Find files on the entire filesystem for which there is no corresponding user or group

```bash
❯❯ find / \\( -nouser -o -nogroup \\) -ls
```

- If you'd like to be a poster for the upcoming guest week, please follow this link for instructions

```bash
❯❯ http://t.co/ZsC9plbyeU
```

- Breakup compressed log by syslog date and recompress

```bash
❯❯ zcat large.log.gz | awk \'{print $0 | "gzip -v9c > large.log-"$1"_"$2".gz"}\'
```

- Compress and ssh transfer a log that has filled a filesystem

```bash
❯❯ gzip -c large.log | ssh user@hostwithbigdisk 'cat > /dir/large.log.gz'
```

- Check the size of yesterday's netflow data directory using date format technique

```bash
❯❯ du -s $( date -d "yesterday" +/netflow/%Y/%m/%d )
```

- New tmux session, split window w/ 5 (4) line tail of syslog at bottom

```bash
❯❯ tmux new-session \\; split-window -l 5 -d 'tail -F /var/log/syslog'
```

- Having trouble with username resolution? (LDAP issues, etc.) Use the -n option with -l to print uids instead of usernames

```bash
❯❯ ls -ln
```

- By default, strings will only show data if there are 4 or more consecutive ASCII chars, you can reduce this with -n

```bash
❯❯ strings -n1 file.bin
```

- Figure out when your md-raid will finish

```bash
❯❯ date -d "$(grep finish /proc/mdstat |sed -e \'s/^.*finish=//;s/ .*$//;s/\\..*$//\')min
```

- True on last day of the month. Useful in cron and other places

```bash
❯❯ [ $( date -d 'next day' +%d ) == 1 ] && echo 'its the end of the month'
```

- circlecitycon

```bash
❯❯ Me @ conferences - > Alright, now I have all my stuff setup just they way I like it..... awww time to go already?
```

- Try all upper/lower case combos of url

```bash
❯❯ for mc in http://goo\\.gl/{A,a}{B,b}9{X,x}0 ; do curl -sI $mc | grep Location: && echo $mc ; done
```

- In GNU sort, you can use -V (version sort) to also sort IPv4 addresses numerically according to each class

```bash
❯❯ sort -V ipv4addrs.txt
```

- vim in Read only mode. Useful when you just want to get features like syntax highlighting without modifying anything

```bash
❯❯ vim -R httpd.conf
```

- run the non-aliased version of rm. Putting a \\ in front of a command name will bypass any aliases of the same name

```bash
❯❯ \\rm file
```

- Poor man's annoy-a-tron. 3 - 6 min interval

```bash
❯❯ while :; do play -qn synth sin 14k trim 0 0.75 vol .8 ; sleep $((RANDOM % 4 + 3))m ; done
```

- (Unrotated log) Count the number of lines per month in boot.log

```bash
❯❯ cut -c1-3 boot.log | uniq -c
```

- Log!

```bash
❯❯ base64 -d < TVRoZAAAAAYAAQABAYBNVHJrAAAAOgD/UQOAAAAAkEV/CIBFfwCQRX8IgEV/AJBKfwiASn8AkEx/CIBMfwqQSX8IgEl/AJBKfwiASn//LwA= |timidity -
```

- Rename set of files with non-hyphenated date to be hyphenated

```bash
❯❯ rename 's/_(\\d{4})(\\d{2})(\\d{2}).txt/_$1-$2-$3.txt/' *_????????.txt
```

- Use a subshell to generate a complex list of files for tar

```bash
❯❯ (find /one -print0; find /two -print0) | tar cvf backup.tar --null -T -
```

- Run du -sh every 5 minutes precisely (ignoring time it takes to run du -s by using watch -p)

```bash
❯❯ watch -n 300 -p du -s
```

- thousands of logfiles, compressed in as many threads as CPUs you have. / cc @climagic

```bash
❯❯ RT @SnowRaptor: ls *.log | parallel xz -v
```

- diy

```bash
❯❯ RT @Tech_Poet: This is the kind of thing that gives IT professions heart attacks.
```

- hook into stdout and stderr of a running process! /cc @climagic

```bash
❯❯ RT @amenthes_de: sudo strace -p <PID > -e trace=write -e write=1,2
```

- CLI PDF to HTML tool

```bash
❯❯ pdftohtml -stdout my.pdf > my.pdf.html; elinks my.pdf.html
```

- Show the last access time of all files ending with .txt. This may not work on all filesystems/setups

```bash
❯❯ ls -l --time=atime --full-time *.txt
```

- Who watches who? You watch who!

```bash
❯❯ watch who
```

- uuoc

```bash
❯❯ Stuck on an island, with only a terminal. I ran \'cat file\' and 1000 people appeared saying "Useless use of cat!" Rescued.
```

- Check if old domains are still pointing to you

```bash
❯❯ cat old_domains |while read -r d; do dig +short NS $d |grep -q yourNShost && echo $d; done
```

- When using less with piped input data, you can use the 's' key to save the data to a file. Very useful with database queries

```bash
❯❯ less tip: s
```

- Just noticed that my town (Bloomington) has got http://t.co/PqP8oA7lcM

```bash
❯❯ whois root\\.com | grep -E "Registrant (City|State|Country)
```

- emojic8ball how will I die?

```bash
❯❯ em8ball(){ a=$( printf "%x\\n" $(($RANDOM%368+9728)) );printf "\\u$a ";random -e 2 && $FUNCNAME||echo; }
```

- Funhouse mirror with your webcam. Kids love this

```bash
❯❯ mplayer --vf=geq='(p(X\\,Y*sin(X/512))-0)' tv://
```

- Record a macro called 'a' that moves down two lines (jj) and then deletes 1 line (dd). Run w/ @a, run 100 times 100@a

```bash
❯❯ vim macro: qajjddq
```

- Linux

```bash
❯❯ RT @a_alasiri: vi / vim visualized cheat-sheet.\n
```

- unix

```bash
❯❯ RT @nixcraft: Open 5 random articles:\n\nfor J in {1..5}; do xdg-open http://t.co/TvxBGjcKo9; done\n\nMore http://t.co/i1zaNi7kN8
```

- Its alive!

```bash
❯❯ while :;do printf "\\e[%d;%dH\\e[48;5;%dm \\e[0m" $(($RANDOM%$LINES)) $(($RANDOM%$COLUMNS)) $(($RANDOM%216 )); done
```

- Use poppler-utils to extract text data

```bash
❯❯ for i in *2015-04-*-.pdf; do printf "$i " ; pdftotext $i - | sed -n \'/Total Bytes/{n;n;p;q}\';done
```

- Print the sum of all the values of lines that start with "Bytes: " in traffic.log

```bash
❯❯ awk \'/^Bytes: /{sum+=$2} END {print sum}\' traffic.log
```

- To print commits per day for a git repo.  Thx @akkaashgoel

```bash
❯❯ git log | awk \'/Date/{print " : " $4 " " $3 " " $6}\' | uniq -c
```

- Print messages per day stats in a maildrop.log file

```bash
❯❯ grep ^Date maildrop.log | cut -c1-16 | uniq -c
```

- Long list all(a) files(l) in CWD, ordering by size(S) ascending(r) and displaying size in human readable form(h)

```bash
❯❯ ls -Sharl
```

- We shouldn't have counted our thumbs when we choose a numeric base

```bash
❯❯ for i in {0..70};do printf "$i ";echo "ibase=10;obase=8;2^$i"|bc;done
```

- puzzle

```bash
❯❯ 590295810358705653049
```

- Decimal to binary conversion in bash by @blind_coder

```bash
❯❯ Dec2Bin=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}); echo ${Dec2Bin[27]}
```

- Play enough of the video to get the VIDEO dimensions. (The monkey way)

```bash
❯❯ mplayer -ao null -vo null --endpos=0.1 *.mp4 | grep VIDEO
```

- bzip2 compress 90+ day old log files under directories a - z

```bash
❯❯ find [a-z] -mtime +90 -type f -name '*_log' -exec bzip2 -v9 {} \\;
```

- Analyze your whole Linux lastlog to see the different remote hosts for each user

```bash
❯❯ last -da | awk \'{print $1 " " $NF}\' | sort | uniq -c
```

- And if you're looking for a more keys/scales, instruments. Try this program I wrote a few years back

```bash
❯❯ http://t.co/4TJhfBbaie
```

- Poly synth. Press asdfghj

```bash
❯❯ n=CDEFGAB;l=asdfghj;while read -n1 k;do x=$(tr $l $n < $k);play -qn synth pl ${x}3 fade 0 .7 & done
```

- An addicting command line game where you use hjklyubn keys to move around and gobble up numbers. http://t.co/MUtxVLlaqq

```bash
❯❯ greed
```

- View the 'open' system calls made by a program called vpnc. strace = window into program functionality

```bash
❯❯ strace -e open vpnc
```

- Sometimes its handy to copy small amounts of data from one host to host this way

```bash
❯❯ base64 + copy buffer - > base64 -d + paste buffer
```

- Go left in your Roku interface. Great for when you can't find the remote

```bash
❯❯ curl -d '' http://roku\\.home:8060/keypress/Left
```

- It probably says a lot that pulseaudio's kill command has a short option, but the start option doesn't

```bash
❯❯ pulseaudio -k
```

- This is how you quit vi

```bash
❯❯ <Esc >:q!
```

- Remove the previous word on the command line (before the cursor). This is highly useful when reusing old commands

```bash
❯❯ <Ctrl-w >
```

- This is usually equivilent to running 'clear'.  Its usually quicker and doesn't leave the command in your command line history

```bash
❯❯ <Ctrl-l >
```

- Incremental undo of command line edits. Ctrl-- works the same and Ctrl-? sometimes works as well, although its not documented

```bash
❯❯ <Ctrl-_ >
```

-  >

```bash
❯❯ <Meta-
```

- Insert the last argument from the previous line in the command history into the current line. Different from !$

```bash
❯❯ <Meta-. >
```

- Move your cursor to the end of the line. Faster than holding down right arrow

```bash
❯❯ <Ctrl-e >
```

- Move your cursor to the beginning of the line. Faster than holding down left arrow. In screen, you need to press <Ctrl-a a >

```bash
❯❯ <Ctrl-a >
```

- Reverse search through your command history for 'string'. Press Ctrl-r again to continue searching backwards. ESC when done

```bash
❯❯ <Ctrl-r >string
```

- Takes you back to the previous directory you were in. Good to know if you don't already

```bash
❯❯ cd -
```

- (With no arguments) Takes you back to your home directory

```bash
❯❯ cd
```

- description. The

```bash
❯❯ Just a reminder about the format of climagic tweets: command
```

- Show directory-only usage in human readable form, but don't decend into other filesystems. Sort human readable data

```bash
❯❯ du -shx */ | sort -h
```

- Cures most shell symptoms, including runny prompts, echo congestion, binary infection and color stain. Use as directed

```bash
❯❯ stty sane; reset
```

- Instead of using sleep 60, you can use read and "short-circuit" the wait with a return

```bash
❯❯ while :; do do_something; read -st 60 X ; done
```

- Find ph words where the ph is not pronounced as 'f

```bash
❯❯ look . |grep ph |while read w; do espeak -qx "$w"|grep -q f||echo "$w"; done
```

- Try finding the URL given a fuzzy screenshot

```bash
❯❯ for u in example/bc{3,8}449{0,8,9}2-ab7a-1{3,8}03; do curl -sI $u|grep -q 404||echo $u; done
```

- Open mplayer man page and search for 'ass,'

```bash
❯❯ LESS="+/ass," man mplayer
```

- Use || when you want to run a command only if the first one failed

```bash
❯❯ fsck -y /dev/sda1 || echo "You\'re fscked!" | mail -s alert admin@x.com
```

- lasttweet

```bash
❯❯ RT @msquadrat: allow the IP you're connecting from via SSH all access for two hours
```

- Find *.txt in $dir sorted by lines with $word By .@msquadrat

```bash
❯❯ find "$dir" -name \'*.txt\' -print0|xargs -0 grep -FwiHc $word|sort -rn -t: -k2
```

- Sum instance counts by start set of non-zero numbers

```bash
❯❯ gawk \'{gsub("0","",$1);a[$1]+=$2} END {for (p in a){print p " " a[p]}}\' resistors.txt
```

- Start a web service on port 8000. Among other things, it can be useful to testing LISTENing ports vs firewall

```bash
❯❯ python -m SimpleHTTPServer
```

- Speak nicely

```bash
❯❯ googlesay(){ curl -A RG translate\\.google\\.com/translate_tts -d "tl=en&q=$*" |mpg123 -; }; googlesay "I\'m tired of talking.
```

- Automatically installs your public key to the remote host (this is included in the openssh package)

```bash
❯❯ ssh-copy-id 'user@remotehost'
```

- When you want to see output AND save it, try "| tee" of just a " >" redirect

```bash
❯❯ rm -fv /somedir | tee remove.log
```

- On Linux, show the exact time/date the system was last booted

```bash
❯❯ date -d @$(grep ^btime /proc/stat | cut -d" " -f 2)
```

- Use Perl regex to find cases of status: NOT followed by NOERROR in dig output files

```bash
❯❯ zgrep -A100 -P "(?<= status: )(?!NOERROR)" 99.*.gz
```

- In vim, after using something like 'v' to select a range of lines, you can pass the range of lines through commands

```bash
❯❯ :'<,' >!sort |column -t
```

- Find broken symlinks

```bash
❯❯ find . -type l | (while read FN ; do test -e "$FN" || ls -ld "$FN"; done)
```

- Multiple choice music player.  Type the number of the song you want to hear

```bash
❯❯ select mus in *.mp3 ; do mpg123 "$mus" ; done
```

- See http://t.co/CxXfZILQE7

```bash
❯❯ echo $(( ( $( date -d '2031-06-28' +%s ) - $( date +%s ) ) / 86400 )) days until Tau day
```

- Happy Pi Day! (Run at 9:26:53am of course or just use date -d '2015-03-14 9:26:53.589793238')

```bash
❯❯ date +%-m.%-d%y%-H%-M%-S%-N
```

- How many Friday the 13ths are there this year

```bash
❯❯ printf "%d\\n" {1..12} | xargs -n1 -I{} date -d "2015-{}-13" | grep ^Fri
```

- Try catching a file that shows up temporarily in a queue

```bash
❯❯ while true ; do cp -va *.dat /tmp/saveit/ 2 > /dev/null ; sleep 0.05 ; done
```

- How much space files older than the present year are using. %j=Julian day

```bash
❯❯ find . -mtime +$(date +%j) -ls | awk '{sum+=$7} END {print sum}'
```

- Remove data dirs with specific length names older than 7 days

```bash
❯❯ find /data -maxdepth 1 -type d -mtime +7 -name '20??????' -exec rm -vf {} +
```

- *facepalms*

```bash
❯❯ rmdir mkdir
```

- First 80GB of sda to remote host w/ progress

```bash
❯❯ dd if=/dev/sda bs=1G count=80 |pv -s80G |pbzip2 -c |ssh user@remote 'cat > /tmp/sda-80GB.bz2'
```

- A rainbow in your shell

```bash
❯❯ yes "$(seq 231 -1 16)" | while read i; do printf "\\x1b[48;5;${i}m\\n"; sleep .02; done
```

- Another fun video trick. Mirror right side of video to left

```bash
❯❯ mplayer --vf=geq='p(X\\,Y)*gt(W/2\\,X)+p(W-1-X\\,Y)*lt(W/2-1\\,X)' tv://
```

- Alternate dimension with your webcam. Kids love this

```bash
❯❯ mplayer --vf=geq='128+(p(X\\,Y)-128)*8' tv://
```

- Generate a random ordered list of 20 numbers. For example to determine order of presentation

```bash
❯❯ seq 20 | shuf
```

- [01].[01].[01]

```bash
❯❯ convert -crop 150x750+100+150 dress.jpg txt: | grep "black|
```

- Listen to permissions

```bash
❯❯ n=(C D E F G A B "C4 ");stat -c%a *|while read -n1 k;do x=${n[$k]};sleep .2;play -qn synth pl ${x}3 fade 0 1 & done
```

- Anyone else seeing this https://: problem?

```bash
❯❯ curl -I https://archive\\.org/index.php | grep Location
```

- paste chk

```bash
❯❯ pmd5(){ xsel -p|md5sum|cut -d\' \' -f1;}; while :;do if [[ "$l" != "$( pmd5 )" ]];then xsel -p;echo;l=$( pmd5 );fi ;sleep .25;done
```

- Never trust your own abilities to come up with a clever way of generating passwords. Swallow your ego and use pwgen instead

```bash
❯❯ pwgen 12
```

- Counts files in the current path by modification month

```bash
❯❯ find . -maxdepth 1 -type f -printf '%TY-%Tm\\n' | sort | uniq -c
```

- Find logs for auths under hosts dir and list them by last modified time

```bash
❯❯ find hosts -name auth.log -o -name secure.log | xargs ls -ltra
```

- Do something special number of ssh processes > 20

```bash
❯❯ while [[ $(pgrep -c -f "ssh " ) -le 20 ]]; do sleep 10; done; echo "There is a problem
```

- E-mail reformat dates

```bash
❯❯ grep -r \'for <me@host >\' . |awk -F\\; \'{print $2}\'|while read -r date; do date -d "$date" +%Y-%m-%d ; done > dates-Ymd
```

- climagic video: Use comment characters in commands to add meta info to commands

```bash
❯❯ http://t.co/k9WE4wZycs
```

- Mount set of partitions for recovery

```bash
❯❯ for i in {1..12}; do mkdir /media/sdd$i &&mount -o ro /{dev,media}/sdd$i ||rmdir /media/sdd$i ; done
```

- Using GNU date you can specify a Unix epoch date with an @ in front and return the local time

```bash
❯❯ date -d @1424242424
```

- Put this in your .bashrc so that on login it will list your tmux sessions. If none, don't show the error

```bash
❯❯ tmux list-sessions 2 > /dev/null
```

- in .profile, lists screen sessions on login /c...

```bash
❯❯ RT @schtobia: if [ -x `which screen` ]; then screen -q -ls; [ $? -ge 10 ] && screen -ls; fi
```

- Print out the first character of $val. The syntax is ${variable:start:length}. Omitting length value gives rest of string

```bash
❯❯ echo ${val:0:1}
```

- 1} -eq 1 ] && arg="Lit_$1" ||arg=$1; curl -d '' "http://roku\\.yournetwork:8060/keypress/$arg"; }

```bash
❯❯ roku(){ [ ${
```

- climagic. Its a great place for discussing command line tricks

```bash
❯❯ There is also an official IRC channel for climagic on http://t.co/8Ef508iK89
```

- Columns with data

```bash
❯❯ for i in {1..161}; do printf "$i "; awk -F, \'NR >1{print $\'$i\'}\' weather.csv |uniq -c |wc -l; done |awk \'$2 >1{print $1}\'
```

- Make a function to shorten this commonly used command line pattern & allow for options for final sort

```bash
❯❯ sus(){ sort | uniq -c | sort $@; }
```

- GNU grep supports perl regex expressions. This gives only the PID on CRON lines in syslog

```bash
❯❯ grep -o -P "(?<=CRON\\[)\\d+" /var/log/syslog
```

- "Last" Received: line of each msg

```bash
❯❯ find .spam/ -type f -exec sed -n -e \'/^Received:/{h}\' -e \'/^$/{x;p;q}\' {} \\; > initial-received
```

- Quick access to the ASCII character table via the ascii program or the man page if you don't have the prog. @mshindal

```bash
❯❯ ascii || man ascii
```

- Find incomplete years in data

```bash
❯❯ awk -F, '/USC00120784/{print substr($6,0,4)}' weather.csv |uniq -c |awk '$2%4==0&&$1<366||$2%4!=0&&$1<365'
```

- Mount the root filesystem to an alternate path in Linux to access "hidden" files underneath logical mountpoints

```bash
❯❯ mount -o bind / /mnt/root
```

- Run this if you want to send your children off in the world to be on their own. I'm talking about processes of course

```bash
❯❯ disown -a
```

- Get a random line from a file. sort -R will also do this

```bash
❯❯ shuf -n1 quotes.txt
```

- In vim, when you want to paste in text, this will prevent autoindent/autosyntax doesn't interfere. :set nopaste to turn off

```bash
❯❯ :set paste
```

- Linux full ps output, sorting process table by memory usage in descending order (- before rss)

```bash
❯❯ ps auxw --sort -rss
```

- Show the process in a tree format, search for gzip and show 8 lines of pre-match context to see its family

```bash
❯❯ ps auxwwf | grep -B8 "[g]zip
```

- Play music for 60 minutes and then shutdown. Like sleep on alarm clock

```bash
❯❯ sudo shutdown -h 60 & mpg123 ambientmusic/*.mp3
```

- In Linux, find running dd processes and send them a signal to print out their progress. For @Erstejahre

```bash
❯❯ kill -USR1 $( pidof dd )
```

- Happy Groundhog Day!

```bash
❯❯ [ -f /etc/shadow ]&&while :;do N=$(($RANDOM%$(tput cols)));for i in $(seq 1 $N);do echo -n " ";done;echo \\*;done
```

- climagic video: The epic demo of how I watched Superbowl 46 using the command line

```bash
❯❯ http://t.co/dL1fKj9Npw
```

- On Debian, find out which non-installed package provides a file. Need to install apt-file package first

```bash
❯❯ apt-file search /usr/bin/apxs2
```

- When adding "bar" to project, which files contain foo but not bar? Thx @CoolSWEng

```bash
❯❯ comm -23 <(grep -rl foo . |sort) <(grep -rl bar . |sort)
```

- Show photo filenames where no flash was used. Req. Imagemagick

```bash
❯❯ identify -format "%f F:%[EXIF:Flash]\\n" *.jpg | egrep " F:(0|16|24|32)$
```

- Search for something in CWD and below and then order those matching files by time

```bash
❯❯ grep -lrZ password . | xargs -0 ls -lt
```

- Find eval( lines in PHP files in user's www subdirectory trees

```bash
❯❯ find /home/*/www -name "*.php" -exec grep --color -H -n \'eval(\' {} +
```

- Listen to the last 20 seconds of a long voicemail that has the contact phone at the end

```bash
❯❯ play msg0493.WAV trim -20
```

- Today's famous birthdays

```bash
❯❯ elinks -no-numbering -dump-width $COLUMNS $(date +enwp\\.org/%B_%-d)|sed '/Birth/,/Death/!d'|grep \\*
```

- Use brace expansion to copy range of images (IMG_1050.JPG through IMG_1622.JPG) to usb drive

```bash
❯❯ cp -va IMG_{1050..1622}.JPG /media/usbdrive/
```

- Use rev twice to get around limitation of cut not being able to truncate end of a string

```bash
❯❯ echo test | rev | cut -c 2- | rev
```

- Print different parts of two different lines and join them

```bash
❯❯ awk \'/date/{print $4 " " $5} /src_ip/{print $3}\' alerts.mbox | xargs -n3
```

- Play pink noise for thirty hours. Thx @hackedy

```bash
❯❯ play -t sl - synth 30:00:00 pinknoise band -n 1200 200 tremolo 20 .1 </dev/zero
```

- Download images in sequence IMG_0001.JPG through IMG_0100.JPG

```bash
❯❯ curl --remote-name http://www.example\\.com/images/IMG_[0001-0100].JPG
```

- A "stronger" version of Ctrl-C. It sends a SIGQUIT, which will kill most programs. Some still trap it. kill -9 is even "stronger"

```bash
❯❯ [Ctrl-\\]
```

- Set the search jump target to 10 lines down so that you see 9 previous lines of context on searches within less

```bash
❯❯ less -j10 /var/log/syslog
```

- Some DNS ASCII ART by @dblockdotorg

```bash
❯❯ dig +short naptr http://t.co/58MsxFQIoD @8.8.8.8 | sort
```

- Find all files larger than 100MB and display their human readable size

```bash
❯❯ find / -size +100M -exec ls -sh {} \\;
```

- 2015 is a binary palindrome

```bash
❯❯ for i in {2048..1024};do b=$(echo "ibase=10;obase=2;$i"|bc);[[ $b == $(rev < $b) ]]&&echo $i $b;done
```

- Play an ASCII art animation via pv command for speed control

```bash
❯❯ curl -s climagic\\.org/ascii/climagic8000.vt | pv -q -L9600
```

- gzip files in the current directory that are more than 60 days old

```bash
❯❯ find . -maxdepth 1 -type f -mtime +60 -exec gzip -v9 {} \\;
```

- Pipe into first command available

```bash
❯❯ time echo "Happy Birthday Stephen Hawking" | ( Equalizer || espeak || say -v Fred || cat )
```

- anim

```bash
❯❯ convert -pointsize 72 label:'01011' -duplicate 50 -virtual-pixel tile -distort SRT '0,0 1,0,%[fx:w*t/n],%[fx:h]' -loop 0 binary.gif
```

- Takes you back to the previous branch you were in. Thx @shawndumas

```bash
❯❯ git checkout -
```

- Use regex character classes to find 4 letter words that work in ipv6 segs. l=1, o=0, s=5

```bash
❯❯ egrep -e "^[a-flos]{4}$" /usr/share/dict/words
```

- Takes you back to the previous directory you were in. Good to know if you don't already

```bash
❯❯ cd -
```

- print difference between the last and first row in 5th column

```bash
❯❯ awk '{if (!first){first=$5;}; last=$5;} END {print last-first}' stats.log
```

- Use your webcam and mplayer as a mirror with this function

```bash
❯❯ mirror(){ mplayer -vf mirror -v tv:// -tv device=/dev/video0:driver=v4l2; }
```

- Find the longest line in quotes.txt

```bash
❯❯ awk 'length > max { max=length;maxline=$0 } END { print maxline; }' quotes.txt
```

- Print the factors of 2015. Happy New Year!

```bash
❯❯ seq $((2015/2)) | awk '2015%$0==0'
```

- Happy 30th Anniversary Free Software Foundation in 2015. Inspiring video

```bash
❯❯ https://t.co/Po0nUSbALT
```

- Using +F option or pressing F in less is similar to `tail -f filename.log` but you can use less's features

```bash
❯❯ less +F filename.log
```

- Find 10 most freq words in file

```bash
❯❯ cat mybook.txt|tr -s '[:space:]' '\\n' |tr '[:upper:]' '[:lower:]'|sort|uniq -c|sort -nr|head -10
```

- Search the file system, but don't descend into the /sys or /proc directories

```bash
❯❯ find / \\( -path /proc -o -path /sys \\) -prune -o -print
```

- 5 second per screensaver visual preview

```bash
❯❯ for i in /usr/lib/xscreensaver/i* ; do echo "This one is $i" ; $i & sleep 5 ; kill %% ; done
```

- Snow in your terminal

```bash
❯❯ http://t.co/m7Sm2V34YW
```

- Make dated directories for next 100 days. Use date -v+{}d on BSD

```bash
❯❯ seq 100 | xargs -n1 -I{} date -d "+{} days" +%Y%m%d | xargs mkdir
```

- Thx @asociale

```bash
❯❯ googlesay(){ curl -A RG translate\\.google\\.com/translate_tts -d "tl=en&q=$@" |mpg123 -; }; googlesay "I\'m tired of talking.
```

- JB

```bash
❯❯ curl climagic\\.org/txt/jb.txt|while read -r c n l;do printf "\\e[1;${c}m%${COLUMNS}s\\e[0m\\n" " ";play -q -n synth pl $n trim 0 $l;done
```

- Space usage of directories only (This was the first climagic command posted from December 15th, 2009)

```bash
❯❯ du -sh */
```

- Birthday of the late Mike Muuss, creator of ping & default routes

```bash
❯❯ ping -c$[2000-1958] $(ip route |awk '/default/{print $3}')
```

- Check for Poodle vuln

```bash
❯❯ nmap --script ssl-enum-ciphers -p 443 twitter\\.com |grep "SSLv3: No supported" ||echo "Site vulnerable to poodle
```

- The correct image in a lossless format

```bash
❯❯ identify -format %k http://t.co/cDn4PW1TEO
```

- Count unique colors in an image. Not 1,000,000 as advertised. Thx @lorddrachenblut

```bash
❯❯ identify -format %k http://t.co/Aqy4qFfay7
```

- Dec 10 = Oct 12 They should use October 12th for Ada Lovelace day

```bash
❯❯ printf "ibase=10;obase=8;10\\n" | bc
```

- Log start and ending timestamps of a long running job

```bash
❯❯ date +"Start: %c" > timestamps ; runsomething ; date +"Ended: %c" > > timestamps
```

- Overhead projectors are dangerous IT equipment. They should put warnings on them

```bash
❯❯ Username: 7p3VMO01RzeS
```

- More cool visuals you can make in your terminal with your cursor

```bash
❯❯ http://t.co/ammutuorZG
```

- 1000 factorial using brace expansion. Remember to backslash * or else it will act as wildcard

```bash
❯❯ echo {1000..2}\\* 1 | bc
```

- Sometimes I think the purpose of this directory is to serve as advertising to the rest of the Unix world

```bash
❯❯ rm -fr __MACOSX
```

- @CarlaSchroder has written a nice article inspired by some recent "Fun Friday" climagic tweets

```bash
❯❯ http://t.co/TOiGQzwqZm
```

- New CLIMAGIC video: Joining files together using the join command

```bash
❯❯ https://t.co/9vPDDXtmPm
```

- This is an easy way to join a file into one line if you're in a hurry. Be careful with really long data though

```bash
❯❯ xargs < file.txt
```

- For apache, this may be a good sort command to pass the previous command through

```bash
❯❯ | sort -t' ' -k4.5,4.7M -k4.2,4.3n -k4.14,4.21
```

- Shellshock attempts

```bash
❯❯ find . \\( -name \'*-access_log.1\' -o -name \'*-access_log\' \\) -execdir grep --color=always -HE \'\\(.*\\).*\\{.*\\}.*"\' {} +
```

- Learn about the power of the lsof command.  Thx @INDIVIDUALIT

```bash
❯❯ http://t.co/yh82QeqmDD
```

- Find out the name of the Debian package that contains the program VirtualBox (when you execute it w/o path)

```bash
❯❯ dpkg -S $( which VirtualBox )
```

- In vim, depending on whether your terminal background is dark or light, setting this will help with color syntax

```bash
❯❯ :set background=dark
```

- If you have a big file to copy, use pv instead of cp. pv gives you progress and speed. Thx @i4AK

```bash
❯❯ pv /oldfolder/file > /newfolder/file
```

- upgrades

```bash
❯❯ Do you want to also install these other packages that will break everything else? [Y/y]
```

- Handy command to help you decide if you should panic by @jschauma. Thx IgorBrigadir

```bash
❯❯ host -t txt http://t.co/6OGgztZg93
```

- New CLIMAGIC video: The Star Wars Reverse DNS command

```bash
❯❯ https://t.co/2pOHWasKwn
```

- Show when temp changes > 1. (sqrt(n*n) is equivalent to absolute value)

```bash
❯❯ awk '{n=$1-lc;if (sqrt(n*n) >1) { print; lc=$1; }}' temp.log
```

- Print out packages with 3.11.0 in them and expand the first column (name) so its fully readable

```bash
❯❯ dpkg -l '*3.11.0*' | cut -c1-$COLUMNS
```

- Calculate how many days old you are. Uses GNU syntax

```bash
❯❯ echo $(( $(( $( date +%s ) - $( date -d "1989-11-29" +%s ) )) / 86400 ))
```

- Star Wars Episode IV in Reverse DNS

```bash
❯❯ ( seq 1 8 200 ; seq 6 8 200 ) | sort -n | xargs -I{} -n 1 dig +short -x 206.214.251.{}
```

- Generate 0 through 255 directories with 0 through 255 subdirectories inside each in one command

```bash
❯❯ mkdir -p {0..255}/{0..255}
```

- Emoticon prompt for BASH shows return status as emoticon

```bash
❯❯ PS1=\':$( [ $? == 0 ] && echo ") " || echo "( " )\'
```

- ] and, presto!, all comments are gone. Thx @m_strehl

```bash
❯❯ Skimming through config files got so much better right now: In less(1) enter &^[^
```

- xkcd

```bash
❯❯ So hopefully you\'ll be able to defuse the "tar bomb" if you ever are in that situation. Sorry BSD users but you are goners. ;-)
```

- If you didn't know, GNU tar now auto-detects the compression algorithm you need. No option required

```bash
❯❯ tar xvf archive.tar.bz2
```

- Function to draw a dividing line in a terminal. Thx @Fluffkin

```bash
❯❯ separator(){ printf '%*s\\n' $(tput cols) '' | tr ' ' -; }
```

- Fix a typo in the previous command. :-(

```bash
❯❯ !!:s/right/rite/
```

- This used to be a right of passage for most Linux users. Today few recognize it

```bash
❯❯ make config && make dep && make zImage
```

- I have to admit, this spam subject did make me run "look f | egrep ^f..k$"

```bash
❯❯ Subject: F**k binary
```

- Merge files together based on fields. -o specifies output format

```bash
❯❯ join -o 1.1,2.2,1.3,1.4,1.5,1.6,1.7 -1 1 -2 1 -t: passwd shadow
```

- jpegtran also rotates images, but without quality loss like IM convert. Thx @kaihendry

```bash
❯❯ jpegtran -rotate 90 -outfile rot90.jpg image.jpg
```

- Run sudo on the last command in your history. be careful because this can bite you. `<Up Arrow > & [Ctrl-a] is just as fast`

```bash
❯❯ sudo !!
```

- Alert me when ping desktop fails. Quick diagnostics

```bash
❯❯ while ping -c 1 desktop; do sleep 10; done; xmessage "Desktop unreachable at $(date)
```

- whoops

```bash
❯❯ Hostnames, they are important.
```

- Add header by using "pee"(included in moreutils)

```bash
❯❯ RT @Heliac1999: df -Ph | pee "head -n 1" "tail -n+2 | sort -k5nr
```

- Start on the second line (-n+2) of output and sort by 5th column numerically descending. Thx @chenghlee

```bash
❯❯ df -Ph | tail -n+2 | sort -k5nr
```

- Show the processes of user 'someuser' in long form. Thx @clodoco

```bash
❯❯ ps wu -U someuser
```

- Organize files by month modified

```bash
❯❯ find . -maxdepth 1 -printf "%TB %f\\n" | while read -r month file ; do mv -v "$file" $month/ ; done
```

- su tux -c xeyes\nX11 ... wrong authentication.\n

```bash
❯❯ RT @mvidner:
```

- ShowMeTheText

```bash
❯❯ Website slow? Try using elinks.
```

- You can use the strings command on binary data to see the readable portions of it. I use this all the time

```bash
❯❯ strings imagefile.jpg
```

- Pandora music client for the command line. And like many CLI clients, it has more control, features and less bloat

```bash
❯❯ pianobar
```

- CLIMagic variety show

```bash
❯❯ http://t.co/6l8YD8d7BN
```

- Quick ref alias

```bash
❯❯ alias what_are_those_damn_conditional_expressions="man bash | sed -n \'/^CONDITIONAL EXPRESSIONS/,/^SIMPLE COMMAND/p\'
```

- Just a quick and dirty way to list interface names and just their TX/RX byte lines

```bash
❯❯ ifconfig | grep -oE -e "^[^\\ ]+" -e ".*bytes.*
```

- If you are in a directory path containing symlinks, this will put you into the physical directory path that the symlinks point to

```bash
❯❯ cd -P .
```

- Auto mouse scroll up in X for 30 seconds. Helps with http://t.co/s52TZ2T9Lr

```bash
❯❯ sleep 5; xdotool click --repeat 1500 --delay 20 4
```

- In case you didn't know, pipe output to less so you can limit output to a page at a time. -S will prevent wrapped lines

```bash
❯❯ ls -l | less -S
```

- Print "columns" 5 and 11 through the end of line. Throw the rest away

```bash
❯❯ find . -ls | awk \'{$1=$2=$3=$4=$6=$7=$8=$9=$10=""; print $0}\'
```

- If you use mutt, this can be a useful command to pipe an e-mail into to check for malicious domains in URLs

```bash
❯❯ egrep -o https?://[^/]*/
```

- reptyr can be used to reattach a program on another tty to the current tty so you can transfer it into screen/tmux. Thx @d3m0n35

```bash
❯❯ reptyr
```

- Using a trap, increment $a by 1 through a USR1 signal. Then do kill -USR1 PIDOFBASH to do it

```bash
❯❯ trap 'a=$((++a)); echo a is now $a' SIGUSR1
```

- You started a program, but now want it to notify you when its done

```bash
❯❯ <ctrl-z > bg ; wait %1 ; echo "done" | mail -s "done" you@example.com
```

- A logical && after sleep gives a chance to "Ctrl-C" out w/o it running the other command if you "chicken out"

```bash
❯❯ sleep 1m && shutdown -h 0
```

- By @stackpivot

```bash
❯❯ perl -e 'use bytes; for($t=0;;$t++){ print chr($t*(($t > >11|$t > >23)&53&$t > >3)); }'  |play -t raw -b8 -r8k -e un -
```

- Go to random site using up to 12 letter word from dictionary

```bash
❯❯ elinks http://www.$( look . | grep -E "^[a-z]{,12}" | shuf | head -n 1 ).com
```

- Show what files or filehandles are open in the /tmp directory (if its not a seperate partition). This can be slow

```bash
❯❯ lsof +D /tmp
```

- Make sure all photos in current directory have been backed up

```bash
❯❯ for i in *.JPG; do ls -l /multimedia/photos/family/$i ; done > /dev/null
```

- Reverse DNS for list of IPs

```bash
❯❯ sort -u -t. -k1n,1 -k2n,2 -k3n,3 -k4n,4 |while read -r ip; do r=$( dig +short -x $ip ); echo "$ip - > $r"; done
```

- Wait for a wget download to finish then shutdown the computer

```bash
❯❯ while pgrep wget ; do sleep 5 ; done ; shutdown -h now
```

- Remember doing this?

```bash
❯❯ while true; do echo $((++n)); done
```

- Math music by viznut

```bash
❯❯ perl -e 'use bytes; for($t=0;;$t++){ print chr($t*(($t > >12|$t > >8)&63&$t > >4)); }' | play -t raw -b8 -r8k -e un -
```

- Long list only the normal files (not directories, etc) in the current directory in last modified order

```bash
❯❯ ls -ltrah | grep -E '^-'
```

- Show the total space used on all your local disk partitions

```bash
❯❯ df -lkP | awk \'{sum += $3} END { printf "%d GiB\\n", sum/(2**20) }\'
```

- Simple meal location decider function

```bash
❯❯ eatwhat(){ echo "Tacos,Burgers,Pizza,Sushi,Salad,Pasta" | tr \',\' \'\\n\' | sort -R | head -1; }
```

- Convert image to color

```bash
❯❯ jp2a -b --colors --fill http://t.co/JyYyscVdAZ
```

- ASCII art stereogram generated using aa3d. Focus past the text on the screen

```bash
❯❯ http://t.co/ZPhxSZiTv5
```

- less often tries to interpret known extensions using lesspipe. If you want to avoid that and see raw data, try this method

```bash
❯❯ less < van.doc
```

- Top 50 404's in descending order

```bash
❯❯ zcat access_log*.gz | cat access_log - | awk \'$9 == "404" {print $7}\' |sort|uniq -c|sort -rn| head -n 50
```

- ferguson |grep --line-buffered -P "^\\s+@" |while read l; do date +%H:%M;done|uniq -c

```bash
❯❯ t stream search \\
```

- Rainbowstream is another CLI twitter client that is colorful and allows in-terminal image viewing. Thanks @dtvd88

```bash
❯❯ http://t.co/w1eKfgGmQO
```

- Long time follower @jeroenhjanssens is giving a webcast today at 1pm EST on data science at the command line

```bash
❯❯ http://t.co/0NdptnKISb
```

- rig is this cool little program that generates random identities and is nice for testing forms

```bash
❯❯ rig
```

- Using brace expansion to make it quicker to specify args when the tarfile and directory name are same base

```bash
❯❯ tar zcvf directory{.tar.gz,}
```

- An answer on this site provides an interesting solution for coloring multiple tail outputs. Thx @DanFromGermany

```bash
❯❯ http://t.co/bRjaRfrcIm
```

- script is a nice program that allows you to record your interactive shell session. Great for logging upgrades

```bash
❯❯ script shellsession.log
```

- hacktheplanet

```bash
❯❯ Grand Central Station!
```

- tail syslog continuously and add extra newline, which may help with readability when lines are long

```bash
❯❯ tail -f syslog |awk \'{print $0 "\\n"}\'
```

- In ZSH, you can press Meta + h to display the man page of the command to the left of the cursor. Thx @_dhamidi

```bash
❯❯ [Meta-h]
```

- Show usage of files/directories, sorted by the human readable size. -h is available with newer versions of sort

```bash
❯❯ du -sh * |sort -h
```

- This is how my day has been

```bash
❯❯ play -n synth sine 480 sine 620 remix 1-2 fade 0 0.5 delay 0.5 repeat 5
```

- @sehetw likes to use the -w option, which ignores all whitespace-only changes between files

```bash
❯❯ diff -w file-with-crlf.dos file-with-lf.txt
```

- Quickly navigate your filesystem using a couple of functions. Thx @kidpixo

```bash
❯❯ http://t.co/Xw8iJ5XWRD
```

- Show what is different between two directories containing plugin code

```bash
❯❯ diff -uNr plugin-orig plugin-current | less
```

- Even though my complaint is about it being the default everywhere, you can use the output of this program to set the color

```bash
❯❯ dircolors
```

- 4 RPG fans

```bash
❯❯ d20kill(){ n=$(($RANDOM%20+1));case $n in 20)kill -9 $1;echo 'Critical hit!';;1[0-9])kill $1;echo 'Hit';;*)echo 'Miss';;esac; }
```

- Roll a digital 6 sided die. Thx @marissa_rae

```bash
❯❯ echo $(($RANDOM % 6 + 1))
```

- Quickly see what day of the week some date this year is on, just use a -v for each part of the date in BSD date

```bash
❯❯ date -v Nov -v 15d
```

- Quickly see what day of the week some date this year is on, you can just use date -d "short date" in GNU date

```bash
❯❯ date -d "Nov 15
```

- Watch ESSID's in your area every 5 seconds including count at the end

```bash
❯❯ watch -n 5 "iwlist wlan0 scan | grep ESSID | pee cat \'wc -l\'
```

- Old term is new term. Thx @JCaesar (love your cipher and your salad)

```bash
❯❯ http://t.co/dpX3TFgFet
```

- .*//' manifests/nodes.pp|egrep -o '\\$\\w+') modules|sort -t: -k2 |uniq

```bash
❯❯ fgrep -roH -f<(sed 's/
```

- Look up a definition for the word autonomy in a few online sources. You probably need to install dict for this

```bash
❯❯ dict minging
```

- Set your keyboard repeat rate under X windows to 220 ms delay before repeat and 60 cps. YMMV

```bash
❯❯ xset r rate 220 60
```

- UTF8 sanitize. Thx @mvidner

```bash
❯❯ iconv -f utf8 -t utf8//ignore < mostly_utf8_with_some_invalid_characters > utf8_offending_characters_removed
```

- Happy 15th System Administrator Day! I bring you the epic tale of The Stick!

```bash
❯❯ http://t.co/daCwGTySxI
```

- In vim, this search will find non-ascii characters and things like invisible space characters generated by "friendly" apps

```bash
❯❯ /[\\x80-\\xff]
```

- In OS X, send the base64 data in your copy/paste buffer into base64 for decoding

```bash
❯❯ pbpaste | base64 -D
```

- In X windows, send the base64 data in your copy/paste buffer into base64 for decoding

```bash
❯❯ xsel -b | base64 -d
```

- AT&T telephone building moved in 1930 during working hours

```bash
❯❯ http://t.co/oi1LzJUJBu
```

- xiki

```bash
❯❯ All those new options and syntaxes should keep climagic going for years.
```

- Show SMTP transaction to see if e-mail is valid

```bash
❯❯ swaks --to cancelation@comcast\\.net --server mx1.comcast\\.com --quit-after RCPT
```

- The ascii command also allows you to convert ascii text into the various numeric bases

```bash
❯❯ ascii -s "show me the codes" | column -t
```

- Quick access to the ASCII character table either through the ascii program or the man page if you don't have the prog

```bash
❯❯ ascii || man ascii
```

- Here is a short list of other useful readline keystrokes you can use in bash. Thx @komidore64

```bash
❯❯ http://t.co/DOyeGUlLSN
```

- Find files under the current directory tree that have a space in the filename

```bash
❯❯ find . -name '*\\ *'
```

- Test your shell-fu in a "wargame" environment. Many climagic tricks can be used here

```bash
❯❯ http://t.co/GMu32WGJCl
```

- joke

```bash
❯❯ Kellogg's is tightening up its cybersecurity because they have lots of old serial connections. They're also worried about air gaps.
```

- Instead of using sleep 60, you can use read and "short-circuit" the wait with a return. Thx @jpluscplusm

```bash
❯❯ while :; do read -st 60 X ; done
```

- Remove the previous word on the command line (before the cursor). This is highly useful when reusing old commands

```bash
❯❯ <Ctrl-w >
```

- This is usually equivilent to running 'clear'.  Its usually quicker and doesn't leave the command in your command line history

```bash
❯❯ <Ctrl-l >
```

- Manual lists this as Ctrl-_ but Ctrl-- usually works too. Incremental undo of command line edits

```bash
❯❯ <Ctrl-- >
```

-  >

```bash
❯❯ <Meta-
```

- Insert the last argument from the previous line in the command history into the current line. Different from !$

```bash
❯❯ <Meta-. >
```

- Move your cursor to the end of the line. Faster than holding down right arrow

```bash
❯❯ <Ctrl-e >
```

- Move your cursor to the beginning of the line. Faster than holding down left arrow. In screen, you need to press `<Ctrl-a a >`

```bash
❯❯ <Ctrl-a >
```

- Reverse search through your command history for 'string'. Press Ctrl-r again to continue searching backwards. ESC when done

```bash
❯❯ <Ctrl-r >string
```

- Takes you back to the previous directory you were in. Good to know if you don't already

```bash
❯❯ cd -
```

- (With no arguments) Takes you back to your home directory

```bash
❯❯ cd
```

- description. The

```bash
❯❯ Just a reminder about the format of climagic tweets: command
```

- Kinda philosophical. What is a line of text really? (Disclaimer: I know the manpage does say "newline" count)

```bash
❯❯ printf "hello" | wc -l
```

- space per user

```bash
❯❯ getent passwd|while IFS=: read -r user n uid n n home n;do if [[ $uid -ge 500 ]];then printf "$user ";du -sh $home;fi;done
```

- Redirect "external" port 3000 from your router to port 3000 of 192.168.1.100. Thx @ntnmrndn

```bash
❯❯ upnpc -a 192.168.1.100 3000 3000 tcp
```

- Show 5 lines of context output after every match of any div tag in index.html

```bash
❯❯ grep -A5 '<div' index.html
```

- More fireworks! GUI output, but many CLI options. You need the rss-glx screensavers package

```bash
❯❯ /usr/lib/xscreensaver/skyrocket
```

- Virtual fireworks noises (WARNING: screamer)

```bash
❯❯ play -n synth sine 8000 bend 0.5,-1800,5 flanger 0 3 0 20 10 tri 20 quad trim 0 7
```

- Bottle rocket sound

```bash
❯❯ play -n synth whitenoise 200 fade 0.2 1 1 trim 0 0.5 ; sleep 1 ; play -n synth whitenoise 200 fade 0 1 1 trim 0 1
```

- Right, that was overkill. I forget that the default function of uniq is to just print out the unique lines. Duh!

```bash
❯❯ uniq data.txt
```

- Print the lines that only occur once in data.txt

```bash
❯❯ sort data.txt | uniq -c | grep "^\\ *1
```

- Maybe find file/dirs in an unreadable /tmp dir

```bash
❯❯ look .| egrep "^[a-z]{1,5}$" |while read word; do [ -e /tmp/$word ] && echo $word ; done
```

- Print the last field of every other line in the file data.txt. Use `NR%2==1` for the "other" line

```bash
❯❯ awk \'(NR%2==0) { print $NF }\' data.txt
```

- update Mac OSX on command line Thx @qtfimik

```bash
❯❯ softwareupdate -iav
```

- How I feel after I switch over to a new router at home and finally get it connected

```bash
❯❯ http://t.co/Ih1qrFr16b
```

- Find out what Linux distro you are using

```bash
❯❯ lsb_release -a || echo "Its probably Red Hat based.
```

- Use brace expansion to copy range of images (IMG_1050.JPG through IMG_1622.JPG) to usb drive

```bash
❯❯ cp -va IMG_{1050..1622}.JPG /media/usbdrive/
```

- Convert something typed in qwerty layout on a dvorak layout. ;-)

```bash
❯❯ tr "qwertyuiop[]sdfghjkl;\'zxcvbnm,./" "\',.pyfgcrl/=oeuidhtns\\-;qjkxbmwvz
```

- sudo makecoffee works too. But /sbin/printf is "more powerful" so be careful

```bash
❯❯ alias makecoffee=\'printf "\\xE2\\x98\\x95\\n"\'
```

- "}; print $0 " " b;}

```bash
❯❯ awk \'{print $4}\' apache_log|sort -n|cut -c1-15|uniq -c|awk \'{b="";for(i=0;i<$1/10;i++){b=b
```

- Quickly give yourself an Unix time epoch value 1 year from now. Use date -v+1y +%s on Mac/BSD date

```bash
❯❯ date -d "now + 1 year" +%s
```

- Here, play some robotfindskitten, that will make things all better and you won't have to think about parsing HTML

```bash
❯❯ robotfindskitten
```

- Print only the data between open and close pre tags in an HTML doc

```bash
❯❯ sed -n -e '/<pre >/,/<\\/pre >/p' < data.html
```

- Fast extract audio track from a set of videos

```bash
❯❯ for vid in *.avi ; do mplayer -ao "pcm:file=${vid%%.avi}.wav:fast" -vo null "$vid" ; done
```

- Use readline shortcuts in GUI (eg. Ctrl-U)

```bash
❯❯ printf \'include "/usr/share/themes/Emacs/gtk-2.0-key/gtkrc"\\ngtk-key-theme-name = "Emacs"\\n\'
```

- Find .htaccess files with "allow from" directives (that may need revision)

```bash
❯❯ find www -name .htaccess -exec grep -l "Allow from" {} +
```

- How Wargames would have ended if they had been using two factor auth

```bash
❯❯ https://t.co/KBT3N3pUOp
```

- Player chooses c h m o d as his letters. It didn't give him the access he needed. Not in the wheel group I guess

```bash
❯❯ http://t.co/pt7B5B7QKf
```

- This will show a count of all lines that have more than 1 copy. So only show the duplicates. (-d)

```bash
❯❯ uniq -cd
```

- Show a 3 month view (before, current, after) in cal

```bash
❯❯ cal -3
```

- Find which Debian package the notify-send program is included with - > libnotify-bin

```bash
❯❯ dpkg -S $( which notify-send )
```

- Pass the output of which (showing path to lspci) into rpm's -qf, which tells you the pkg

```bash
❯❯ rpm -qf $( which lspci )
```

- /\\xE2\\x96\\x88/g' < qr-code

```bash
❯❯ sed -e 's/
```

- You're SSH'd to your home box and you want to port forward to your router's web admin via localhost:8080

```bash
❯❯ [Enter]~C -L 8080:192.168.1.1:80
```

- Use sox to invert track and get hidden audio signal

```bash
❯❯ sox -m -v1 24.flac -v-1 24_CTF.flac signal.wav silence 2 5 2%
```

- For your Friday amusement. Thx @komidore64

```bash
❯❯ http://t.co/P4wxRLZYF7
```

- A rainbow in your shell

```bash
❯❯ yes "$(seq 231 -1 16)" | while read i; do printf "\\x1b[48;5;${i}m\\n"; sleep .02; done
```

- CircleCityCon in Indy. Wearing the climagic logo t-shirt so if you see me, say hi. climagic meetup near registration area at 7:10pm

```bash
❯❯ I'm at
```

- Unless you have this option turned off for your filesystem, this will show you the last accessed time of files

```bash
❯❯ ls -l --time=atime
```

- vim tip: pressing '.' in command mode will repeat the last change made (insert, append, delete, etc.). Can be prefixed with number

```bash
❯❯ .
```

- Clear the contents of logfile, reducing it to 0 bytes. Often used when you don't want to change the perms/mode of the file

```bash
❯❯  >logfile
```

- Pass two runs of ifconfig 60 seconds apart through the same grep using a subshell

```bash
❯❯ ( ifconfig eth0 ; sleep 60 ; ifconfig eth0 ) | grep X
```

- Find specific lines matching session opened and print the 3rd word from end

```bash
❯❯ awk '/session opened/ {print $(NF-2)}' /var/log/auth.log
```

- theinternetofthings

```bash
❯❯ Dude, you ssh\'d into someone\'s mouth?
```

- Remote intercom system. "Kent, this is God!"

```bash
❯❯ rec -t wav - | ssh remotehost play -t wav -
```

- Show the path to the executable that was run to start PID 2394. Need permission

```bash
❯❯ lsof -p 2394 |awk \'{if ($4=="txt"){print $NF}}\' |head -1
```

- mod

```bash
❯❯ find . -name \'*.html\' |while IFS=\\n read f ; do r=$(mktemp);touch -r "$f" $r;t=$(stat -c %y "$f");mod "$f";touch -r $r "$f";rm $r;done
```

- Use regex boundary markers (\\b) to find instances of the string ed alone in a file

```bash
❯❯ grep -E "\\bed\\b" queue.txt
```

- Mmmmm, donuts. Today is national donut day. Requires rss-glx package

```bash
❯❯ /usr/lib/xscreensaver/lattice --tasty
```

- Take a single 1280x720 picture of your TV input, which is often your webcam

```bash
❯❯ mplayer -vo png -frames 1 tv:// -tv width=1280:height=720
```

- Order filesystems by percent usage and keep header in place

```bash
❯❯ df -hP |column -t |tee  >( head -n1 > /dev/stderr ) |grep % |sort -k5nr
```

- Show perms/owner at each dir level

```bash
❯❯ treeperms(){ d=$(cd "$1" ; pwd -P) ; ls -ld "$d"; [[ "$d" != "/" ]] && treeperms $(dirname "$d"); }
```

- Don't watch the clock yourself, Auto check when a tunnel interface times out

```bash
❯❯ while ifconfig utun0 > /dev/null; do sleep 15; done; date
```

- Because you ain't got time to use find -type f -exec blah. Just redirect the errors to devnull

```bash
❯❯ grep -li color /etc/* 2 > /dev/null
```

- Make box around text. http://t.co/ptTP0mmlCx

```bash
❯❯ function box(){ t="$1xxxx";c=${2:-=}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }
```

- Display top bandwidth hogs on website

```bash
❯❯ awk \'{a[$1] += $10} END {for (h in a) print h " " a[h]}\' access_log | sort -k 2 -nr | head -10
```

- Filter by port range to host and connection state. Thx @hecky and @raganello

```bash
❯❯ lsof -iTCP@irc.evil.net:1024-50000 -s TCP:ESTABLISHED
```

- Show what processes are using port 80 either locally or remotely. Need to be root for unowned processes

```bash
❯❯ lsof -i TCP:80
```

- Learn vim while playing an adventure game

```bash
❯❯ http://t.co/wGMlnbfTcx
```

- Mouse spiral

```bash
❯❯ x=0;y=0;while [[ $y -lt 500 ]] ; do xdotool mousemove --polar $x $y ; x=$(($x+3));y=$(($y+1)); sleep 0.001; done
```

- Tron lightcycles in the terminal or Etch-a-sketch. Take your pick

```bash
❯❯ http://t.co/zZmcvsVtwi
```

- Another one to try

```bash
❯❯ /usr/lib/xscreensaver/apple2 -text -fast -program $SHELL
```

- Use phosphor for your terminal

```bash
❯❯ /usr/lib/xscreensaver/phosphor -scale 2 -delay 5000 -geometry 1024x768 -program $SHELL
```

- climagic, meet the magic keyboard

```bash
❯❯ http://t.co/SprJ1PiMMl
```

- The origin of the sudo command as told by its co-author Bob Coggeshall. Thx normod

```bash
❯❯ https://t.co/DNcP31ykga
```

- Foremost is a file recovery program that can extract files from disk images and more. http://t.co/JP4nL6iSyN

```bash
❯❯ foremost
```

- Play all the media files in the current directory by mod time for file

```bash
❯❯ ls -tr > timeordered ; mplayer -playlist timeordered
```

- saves you searching for disks and other block devs attached to your

```bash
❯❯ lsblk
```

- The real meaning of

```bash
❯❯ for i in {A..Z}; do echo $i; done |nl |grep "[XKCD]" |awk \'{sum+=$1} END {print sum}\'
```

- \xcf\x80 * l33t% = 42 Happy

```bash
❯❯ echo "scale=10; 3.1415926535 * (1337.0/100.0)" | bc
```

- Print the decimal encoded value of an * (everything)

```bash
❯❯ printf \'%d\\n\' "\'*
```

- Lego keyboard. Now you have a new project

```bash
❯❯ https://t.co/HRbyGyotGx
```

- After receiving this command about 100x from followers over the years, I can finally safely post it. Thx @NuxRo

```bash
❯❯ http://t.co/n3Lqug0E1k
```

- Your own mv function for files with a "template"

```bash
❯❯ my_mv(){ d_id=$( basename "$(pwd)" |cut -d\' \' -f2); mv -v "$1" "special_${d_id}-$2_$1; }
```

- Untar a program file and cd into the directory it created without the .tar.gz extension

```bash
❯❯ tar xvf program-1.2.3.tar.gz ; cd ${_%%.tar.gz}
```

- :$:s/.png/.jpg/

```bash
❯❯ convert -quality 80 Screenshot-2014-05-20.png !
```

- :1"{}

```bash
❯❯ curl http://example\\.com/vids/ | grep -Po \'(?<=")[^"]+.webm(?=")\' | xargs -I{} -n1 wget !
```

- This document explains the differences between !$, Meta+. and $_ for referencing "last args"

```bash
❯❯ http://t.co/d1wFX5sHQr
```

- $_ is a shell special variable that expands to the last argument given in the prev command. Thx @PetrHodac

```bash
❯❯ mkdir -p /tmp/a/b/c ; cd $_
```

- You may have heard about Docker and Linux containers. Here is a good primer on LJ. Thx @brimston3

```bash
❯❯ http://t.co/Zn4bsvNGAD
```

- How to setup THX startup sound, cd+video and Ackbar Ctrl-C for yourself

```bash
❯❯ http://t.co/QtnrBFR67K
```

- Correction, but I wasn't really serious

```bash
❯❯ cd(){ builtin cd $@; mplayer -quiet -geometry 400x280+0+0 "$(ls -1 ~/Videos/*|shuf| head -1)" & }
```

- Make your shell more like a website

```bash
❯❯ cd(){ builtin cd $@; mplayer -quiet -geometry 400x280+0+0 "$(ls -1 ~/Videos/|shuf| head -1)" &); }
```

- For the non-believers. TIMTOWTDI!

```bash
❯❯ grep "Yes it" $( which frozen-bubble ) && wc -l $_
```

- Convert to mp3. One of the reasons @erikaheidi & @laceytech <3 Linux

```bash
❯❯ for f in *.wav; do lame --vbr-new -V 3 "$f" "${f%.wav}.mp3"; done
```

- Disable the Back/Forward keys (at least on my keyboard). Great for babies

```bash
❯❯ xmodmap -e "keycode 166 = 0x0000" -e "keycode 167 = 0x0000
```

- SVG 2 PNG in CWD

```bash
❯❯ find . -maxdepth 1 -name \'*.svg\' |while IFS=$\'\\n\' read f ; do inkscape "$f" --export-png="PNG/${f%%.svg}.png"; done
```

- THXsh startup sound

```bash
❯❯ echo '(play -q -n synth sine F2 sine C3 remix - fade 0 4 .1 norm -4 bend 0.5,2399,2 fade 0 4.0 0.5 &)' > > ~/.bashrc
```

- Idea: Backslashing the * glob instead of quoting the expression. Thx @lorddrachenblut

```bash
❯❯ find ./music  -name \\*.mp3 -exec cp {} ./new \\;
```

- Easy peasy time warp tweety @DrFNFurter

```bash
❯❯ at "now + 5 years"  < \'t update "...pation"\'
```

- tarbombparty

```bash
❯❯ @discreetsecure Heh, then address everyone you know in the Cc line and watch them start repling to all.
```

- If you want to learn about tar, watch this video I made 4 years ago

```bash
❯❯ http://t.co/ZUP6jYwnu4
```

- Detect

```bash
❯❯ tarbomb(){ [[ $( tar tf "$1" |sed \'s,^\\./,,\' |awk -F/ \'{print $1}\' |sort |uniq |wc -l ) -eq 1 ]] && echo "OK" || echo \'Tarbomb!\'; }
```

- Its not Friday yet?

```bash
❯❯ while [[ $( date +%A ) != "Friday" ]]; do echo Its not Friday yet ; sleep 1h ; done ; echo "Yea Friday
```

- Send every two files found through diff. (Of course, this may not always be what you want) For @mgpreppy

```bash
❯❯ find -print0 | xargs -0 -n 2 diff
```

- Move all files modified in the last 2 mins to ./target .Thx @davidnormo

```bash
❯❯ find ~/path/to/files -mmin -2 -execdir mv -t ./target/ {} +
```

- MIND BLOWN! \xcf\x80 * l33t% = 42 Thx @Notfound404__

```bash
❯❯ echo "scale=10; 3.1415926535 * (1337.0/100.0)" | bc
```

- epoch //via @climagic

```bash
❯❯ RT @blubtwit: Happy 1400000000
```

- See what is in the file called '-'. 9 times out of 10 for me this is the output of strace or tcpdump

```bash
❯❯ less ./-
```

- Show the differences between two directories. comm can also be good for this

```bash
❯❯ diff <(cd dir1 ; ls -1 | sort) <(cd dir2 ; ls -1 | sort)
```

- AA countdown to 1.4 billion epoch

```bash
❯❯ e=1400000000;while [[ $(date +%Y) -ne $e ]];do figlet $(($e-$(date +%s)));sleep 1;clear;done;figlet $e
```

- See what local time for you the

```bash
❯❯ e=1400000000;date -d @$e || date -r $e
```

- Start a web service on port 8000. Among other things, it can be useful to testing LISTENing ports vs firewall

```bash
❯❯ python -m SimpleHTTPServer
```

- See the last logged in users, but filter out entries for root, reboots and asmith

```bash
❯❯ last -da | egrep -v "^(root|reboot|asmith)
```

- How scientist and climagic follower @MikeRSpencer is using the command line to help track snowfall in Scotland

```bash
❯❯ http://t.co/SnUORpJ3tv
```

- Lots of amusing anecdotes of command line mistakes here. Especially in the comments

```bash
❯❯ http://t.co/k8sSDdktZp
```

- opps

```bash
❯❯ Man takes picture of himself every day for 10 years, then carelessly runs dd if=/dev/sdb of=/dev/sda to copy his 1st drive to 2nd.
```

- 4fun

```bash
❯❯ grep -o --binary-files=text '[[:alpha:]]' /dev/urandom |tr -d '[a-zA-Z]' |xargs -n $(($COLUMNS/2)) |tr -d ' '| lolcat -f | pv -L80k
```

- OH THE HORROR!!

```bash
❯❯ List thread: "Subject: Troubleshooting Linux Applications Without Using the Command Line
```

- |^\\ *$)" httpd.conf | less

```bash
❯❯ egrep -v "(^
```

- Alias for mplayer when you want its window matched with special rule for devilspie or other

```bash
❯❯ alias mplayerdp=\'mplayer -title "mplayer dp"\'
```

- Use the -d option when you want to see the directory itself instead of what's inside when you use wildcards like this

```bash
❯❯ ls -ld *log*
```

- Send a signal to any/all dd processes to give a status report every five minutes

```bash
❯❯ while :; do killall -USR1 dd ; sleep 5m ; done
```

- Moves the first line of the file to the end, allowing to cycle through it. Thx @benthorben

```bash
❯❯ sed -ni '1h;1!p;${x;p}' queuefile
```

- 1: What's in this chest? Kid

```bash
❯❯ Kid
```

- Using a logical && after sleep gives you a chance to Ctrl-C out of sleep without it running the rest

```bash
❯❯ sleep 5m && rm -fr /
```

- Sleep for 5 days, 2 hours, 1 minute and 15 seconds. This syntax works in GNU coreutils sleep at least

```bash
❯❯ sleep 5d 2h 1m 15s
```

- full process output in a tree view so you can see the parent - > child process relationships

```bash
❯❯ ps auxwf
```

- scrot is a nice command for capturing screenshots of the whole screen, a window or a selected area

```bash
❯❯ scrot -s screenshotname.png
```

- Check if file is done downloading from Firefox (not 0 bytes) before moving

```bash
❯❯ [ -s ./Downloaded.zip ] && mv -v Downloaded.zip Ringtones.zip
```

- Cures most shell symptoms, including runny prompts, echo congestion, binary infection and color stain. Use only as directed

```bash
❯❯ reset
```

- Use -r to download a byte range from large file

```bash
❯❯ curl -r 61049103-61865118 hackerpublicradio\\.org/eps/hpr1418.mp3 | mpg123 -
```

- Watch in real time as people mention your city on Twitter

```bash
❯❯ t stream search -l "yourcityname state
```

- More secure than telnetmallows, but not as hip as moshmellows. Thx @hubert3 & @JCaesar

```bash
❯❯ http://t.co/zBgf4cP274
```

- The speedometer program (http://t.co/noIyJQBBe6) makes a nice real time network graph

```bash
❯❯ speedometer -k 256 -i 0.2 -r eth0 -t eth0
```

- Use multiple search terms, grep's count result and sort to find a doc by "scoring"

```bash
❯❯ grep -Irc -e php -e mysql *.pkgs |sort -t: -k2nr|head
```

- Start playing music files with the 51st file in (0 indexed). Good for when wildcards would be too complex

```bash
❯❯ f=(*.mp3); mpg123 ${f[@]:50}
```

- tbt http://t.co/IrmPouiDxs

```bash
❯❯ Its a UNIX system, I know this.
```

- I find brace expansion very useful for renaming files. Expands to "mv Picture.jpg Picture-of-my-cat.jpg"

```bash
❯❯ mv Picture{,-of-my-cat}.jpg
```

- f4f3f0 -opaque \\

```bash
❯❯ convert detroit-green-shape.png -fuzz 3% -fill \\
```

- Side by side comparison of zip index

```bash
❯❯ pr -W $COLUMNS -m -t <(unzip -l backup1.zip | sort -k4 ) <(unzip -l backup2.zip | sort -k4 ) | less
```

- Display changelog of 1st arg (pkg). If 2nd arg set, search for it in the log

```bash
❯❯ changelog(){ rpm -q --changelog $1 |less -j3 ${2:++/"$2"}; }
```

- Start searching for text data, but skip the first 25GB (25k of 1MB blocks) of the drive

```bash
❯❯ sudo dd if=/dev/sdc bs=1M skip=25k | strings -n12
```

- Search a drive for text data, but use a longer minimum size (default 4) to get a better signal to noise ratio

```bash
❯❯ sudo strings -n12 /dev/sdc
```

- Sum up the bandwidth consumed by requests for matched lines. BTW, it was 35GB

```bash
❯❯ awk '/itdance.gif/{sum+=$10} END { print sum }' access_log
```

- Give your photo a 70s look

```bash
❯❯ convert +level-colors Firebrick, me.jpg oldme.jpg
```

- This will run ls without using any alias called ls that might be in place. You can do this with any command

```bash
❯❯ \\ls
```

- Use rev twice to get around limitation of cut not being able to truncate end of a string

```bash
❯❯ echo test | rev | cut -c 2- | rev
```

- Wkly Box Of. change

```bash
❯❯ elinks imdb\\.to/1fzw0R4 |sed -n -e 's/[$,]//g' -e '/Gross/,/Weekend/p'|grep '(USA)'|tac|awk '{print $1-last; last=$1}'
```

- Determine what lines the file names2 has that are unique. The comm program requires sorted files

```bash
❯❯ comm -13 <(sort names1) <(sort names2)
```

- You can put DATETIME in your shell rc file & use it to make time format

```bash
❯❯ DATETIME="%Y%m%d_%H%M%S"; ps auxwwf > $(date +psauxwwf-$DATETIME)
```

- In pulseaudio, set the application volume of input sink

```bash
❯❯ pactl set-sink-input-volume 353 60%
```

- Get PA sink id

```bash
❯❯ pactl list| awk \'/(^Sink|process.id = "\'$(pidof pianobar)\'")/{if($0 ~ /^Sink/){s=$3};if($0~/process.id/){print s;exit};}\'
```

- Use less as your pager and open the man page perlre and find first instance of "Look-Around"

```bash
❯❯ LESS="-p Look-Around" man -P less perlre
```

- Almost 2^16

```bash
❯❯ f=$(curl -Ls twitter\\.com/climagic | grep -Po \'(?<=followers_count&quot;:)[0-9]+\') ;bc  < "ibase=10;obase=2;$f
```

- earthday

```bash
❯❯ The command line gives you more computing power for less energy.
```

- This alone should save several megawatt hours today

```bash
❯❯ killall firefox; killall chrome
```

- earthday

```bash
❯❯ If each of my 65,000 followers shut off one computer for today it would save over 100 Megawatts.
```

- How many of you will actually do it instead of just retweeting it?

```bash
❯❯ shutdown -h 0 || shutdown now || halt
```

- earthday  How many of you will actually do it?

```bash
❯❯ shutdown -h 0 || shutdown now || halt
```

- with GNU sort doing a version sort would have the same effect

```bash
❯❯ RT @iiSeymour: @climagic sort -V ipv4addrs.txt
```

- Sort IPv4 addresses numerically according to each class

```bash
❯❯ sort -t . -n -k1,1 -k2,2 -k3,3 -k4,4 ipv4addrs.txt
```

- See all the programs in path dirs with suid or sgid bits set

```bash
❯❯ find ${PATH//:/ } -type f -maxdepth 1 -perm /6000 -ls
```

- pzl

```bash
❯❯ 32596b4a6e657464 4849676748626751 6e6267455861325a 69596b4253633442 53626c4248497968 435a734133596b4a 4749693548497468 4749675541633d6f
```

- Move all duplicate files in CWD (except first in set) into 'dupes' sub-directory

```bash
❯❯ fdupes -f . | xargs --delimiter='\\n' mv -vt dupes/
```

- heartbleed http://t.co/zqazzAEbSu

```bash
❯❯ This one cracked me up. Thx @LizQuilty
```

- Check which hosts in IP list are not up

```bash
❯❯ for i in $( cat ip-list ); do ping -c1 $i 2 >&1 > /dev/null || echo $i not up; done
```

- Get Google results number

```bash
❯❯ gresults(){ s="$@"; wget -q -O- -U Mozilla www.google\\.com/search?q=\\"$s\\" |egrep -o "About [0-9,]+ results";}
```

- kill -9, the song. Warning: NSFW lyrics

```bash
❯❯ http://t.co/Y1qS1EJ5HY
```

- Find all those crazy options you have to use to make an LDAP search, because you know you can't remember them. ;)

```bash
❯❯ history |grep ldapsearch
```

- Or as @raganello just reminded me, you can just use the --last option. But that's too easy. ;-)

```bash
❯❯ rpm -qa --last
```

- List rpms by date installed

```bash
❯❯ rpm -qa --queryformat "%{INSTALLTIME} %{INSTALLTIME:date} %{NAME}\\n" |sort -n |cut -d\' \' -f2-
```

- Some interesting historical insight into sed's y command. Thx @gumnos

```bash
❯❯ http://t.co/skoBjrQzVo
```

- Reduce the verbosity of mplayer output by turning down the msglevel of most modules

```bash
❯❯ mplayer -msglevel all=-1:statusline=5:cplayer=5 *.mp3
```

- Or as @jacalvo_zentyal mentioned you can use time read or my favorite, time cat. Ctrl-D and read the "real time" in the output

```bash
❯❯ time cat
```

- Quick and dirty stopwatch with nanosecond accuracy. [Enter] stops it

```bash
❯❯ echo $(a=$(date +%s.%N); line; b=$(date +%s.%N); echo "$b-$a"|bc )
```

- Show a list of mail users and their login failed attempt count

```bash
❯❯ grep "LOGIN FAILED" maillog | egrep -o "user=[^,]+," | sort | uniq -c
```

- I know it may be annoying at first, but it will save you hours later

```bash
❯❯ cd(){ builtin cd $@; /etc/init.d/sssd restart; }
```

- Generate 16 x 4 random long-word passphrases from a list of common words

```bash
❯❯ shuf common-words-10k.txt |egrep ".{5,}" |head -64 |xargs -n4
```

- As kinda a one off thing. If you find yourself doing a lot of line trimming, try this for one keystroke line delete

```bash
❯❯ :map <F2 > dd
```

- Whenever I have to reboot this scene plays in my head except with "reboot"

```bash
❯❯ https://t.co/0zXahrEZiy
```

- It can be both @Brisawoman @rcalsaverini ;-)

```bash
❯❯ elinks -dump http://thefuckingweather\\.com/?zipcode=Fargo | grep " IT\'S" | (espeak||cat)
```

- Some people really go out of their way to insult others. Thx @brimston3

```bash
❯❯ for d in {0..255}; do dig +short -x 202\\.78.246.${d}; done
```

- Get a list of website hostnames you've visited

```bash
❯❯ echo "select host from moz_hosts;" | sqlite3 places.sqlite > ~/history-hosts.txt
```

- If you cant find an error message in your language on Google, run your command "in English". Thx @MarcCornella

```bash
❯❯ LANG=en apt-get upgrade
```

- On Debian, find any packages that manage files in /boot and list them uniquely

```bash
❯❯ dpkg -S '/boot/*' | cut -d: -f1 | sort | uniq
```

- Check what services are still using old now removed libraries and need to be reloaded. Thx @nmcfarl

```bash
❯❯ sudo lsof -n | grep ssl | grep DEL
```

- Create an HD color plasma image. Different each time. Uses ImageMagick

```bash
❯❯ convert -size 1920x1080 plasma:fractal background.png
```

- An alias that prints out extended ASCII chars

```bash
❯❯ alias extendedascii=\'for i in {C..F}{{0..9},{A..F}}; do printf "$i \\x$i\\n"; done ; echo\'
```

- A few people have asked about my urxvt settings, so I'll share my Xdefaults file

```bash
❯❯ http://t.co/leYjmU8GFQ
```

- Spice up your excessive usage of [Ctrl-C]

```bash
❯❯ trap "echo;ack-grep --bar | sed \'y/ge/ta/\'" SIGINT
```

- Confuse people SSHing to your host with a redirect back to theirs

```bash
❯❯ socat -d -d TCP-L:22,reuseaddr,fork SYSTEM:"nc \\$SOCAT_PEERADDR 22
```

- Convert a string in quotes to its hexadecimal codes in ASCII

```bash
❯❯ ascii -s "show me the hex codes" | awk \'{print $3}\'
```

- Automatically installs your public key to the remote host (this is included in the openssh package)

```bash
❯❯ ssh-copy-id 'user@remotehost'
```

- In vim, depending on whether your terminal background is dark or light, setting this will help with color syntax

```bash
❯❯ :set background=dark
```

- status=none allows you to suppress the ending status info if you don't want it

```bash
❯❯ dd status=none if=/dev/zero of=bigfile bs=1k count=1M
```

- Quickly find out how much data space is left on the partition that the current directory you are in resides

```bash
❯❯ df -h .
```

- Display an ASCII art cat. There, after 4 years I finally posted an ack command

```bash
❯❯ ack-grep --thpppt
```

- New rot546 is super strong encryption

```bash
❯❯ rot546(){ s=$@;for ((r=0;r<43;r++)){ s=$(tr A-Za-z N-ZA-Mn-za-m  < "$s"|base64);};echo "$s"; }
```

- Nobody will criticize your ideas again

```bash
❯❯ echo "XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X" > > .signature
```

- Poor man's auto updating slideshow image

```bash
❯❯ while true;do for i in ~/Pictures/*.jpg ;do cp "$i" ~/slideshow.jpg ;sleep 5;done; done
```

- See how many references to pi are made in the Linux version 3.14 patch

```bash
❯❯ xzgrep -E -o "\\bpi\\b" patch-3.14.xz | wc -w
```

- See the BUGS part of the mutt man page. Thx mof18202  (check man man for 'col -b' trick)

```bash
❯❯ man mutt | col -b | sed -n '/^BUGS/,+10p'
```

- Linux manpages. :3

```bash
❯❯ RT @mof18202: "BUGS: More than you can imagine." I like honest
```

- Upgrade new

```bash
❯❯ sed -i \'s/{% url \\([a-z_]*\\) /{% url "\\1" /\' $(find . -name "*.html")
```

- Spinning ASCII art globe

```bash
❯❯ curl -s http://artscene.textfiles\\.com/vt100/globe.vt | pv -L9600 -q
```

- Divide files by the column count in each line. Thx @unfo

```bash
❯❯ awk -F\';\' \'{ fname=sprintf("lines_with_%s_columns.txt", NF); print > > fname }\'
```

- If you encounter a file that is hard to type/tab complete, try using a ? to replace the characters you can't type

```bash
❯❯ mplayer M?rklintage*
```

- The pee command can run head and tail on same input. sponge waits for all the data first

```bash
❯❯ ping -c100 4.2.2.2 | sponge | pee head tail
```

- Exploding cow animation I found in old e-mail

```bash
❯❯ curl -s www.climagic\\.org/ascii/explodingcow-animation-1995.gz |zcat |pv -L2400 -q
```

- Today's famous birthdays

```bash
❯❯ elinks -no-numbering -dump-width $COLUMNS $(date +"http://t.co/8PCWfAtTFP")|sed \'/Births/,/Deaths/!d\'|grep \\*
```

- reptyr can be used to reattach a program on another tty to the current tty so you can transfer it into screen/tmux

```bash
❯❯ reptyr <pid >
```

- Using -e multiple times for multiple expressions is possible and a bit more readable

```bash
❯❯ grep -e string1 -e string2 -e regex1 file
```

- Someone made a clone of 2048 in only 278 lines of bash script. Sorry about your time. Thx @PBirkants

```bash
❯❯ https://t.co/bgcwCShaCR
```

- pi_backup is a new command that simply returns an index number where your data is stored within pi. See also, pi_restore

```bash
❯❯ pi_backup /
```

- Req. ImageMagick

```bash
❯❯ convert -size 413x314 xc:tan -fill red -pointsize 200 -gravity center -draw "text 0,0 \'3.14\'" -flop pie.png
```

- EFF! Thx @Matteotom

```bash
❯❯ dig -t NAPTR +short http://t.co/EXIR3mAPn9 | sort
```

- Show a count of the number of sent messages by day through your mail server

```bash
❯❯ grep status=sent /var/log/maillog | cut -c1-7 | uniq -c
```

- isintime 8am 5pm && update Thx @brimston3

```bash
❯❯ isintime(){ s=$(date +%s);[ $(date -d "$1" +%s) -lt $s ] && [ $s -lt  $(date -d "$2" +%s) ]; }
```

- Run update every 5min between 8am and 5pm

```bash
❯❯ while true; h=$(date +%_H); [[ $h -ge 8 && $h -lt 17 ]] && update; sleep 5m; done
```

- Only run update every 5min between 8am and 5pm

```bash
❯❯ while true; h=$(date +%_H); [ $h -ge 8 && $h -lt 17 ] && update; sleep 5m; done
```

- You can specify alternate rpm db paths if you want. You can even do this on non-rpm based systems

```bash
❯❯ rpm --dbpath=~/backup-rpm-dir -qi httpd
```

- climagic

```bash
❯❯ I still haven't figured out a way to notify you when Twitter is down from the shell yet. Maybe just 'weechat irc.freenode\\.org/
```

- % Pkt loss

```bash
❯❯ elinks -no-numbering -no-references internetpulse\\.net/?Metric=PL |egrep --color=no -e \'Dest|Gener\' -e "NTT.*XO" -e " 0 .* 0
```

- PWD is ~/.config/xfce4/xfconf/xfce-perchannel-xml and I needed to copy from a xfce4-backup dir I made

```bash
❯❯ cp -a ${PWD/xfce4/xfce4-backup}/* .
```

- A text mode file manager similar to mc, but isn't as cumbersome as mc IMHO. View, play, manage media files quickly. Thx @mtelesha

```bash
❯❯ ranger
```

- See what the word inconceivable really means

```bash
❯❯ dict inconceivable
```

- Check what databases are stored inside a simple compressed mysql dump file

```bash
❯❯ zgrep "^CREATE DATABASE" dbbackups.mysql.gz
```

- thedownside it means I have to reboot my computers

```bash
❯❯ Moving into a bigger cube is nice, but on
```

- You can use rev to reverse a word or sentence

```bash
❯❯ rev  < "Naomi, sex at noon taxes I moan
```

- Find out if xfce4-terminal uses the libvte library or not. Check your own terminal program

```bash
❯❯ ldd /usr/bin/xfce4-terminal | grep libvte
```

- Find out if the terminator terminal uses the libvte library or not. Check your own terminal program

```bash
❯❯ ldd /usr/bin/terminator | grep libvte
```

- Print the line if it has a 6th column of text in it

```bash
❯❯ awk '$6' scan.txt
```

- Move a directory while you're inside it. Only works if on same partition

```bash
❯❯ mkdir sub1 sub2; cd sub1 ; mv ../sub1 ../sub2 ; cd . ; pwd
```

- Climagic video demonstrating gnome-terminal's scrollback being written to disk

```bash
❯❯ http://t.co/wDRy0UO5G4
```

- Still a problem after 2 years. Don't use libvte based terms (gnome-terminal, Terminator, xfce4-term, etc.)

```bash
❯❯ http://t.co/WWKCZU75fh
```

- Quickly find the largest 5 files in a directory tree on a single file system

```bash
❯❯ find . -xdev -ls 2 > /dev/null | sort -k7nr | head -5
```

- Random color per log line

```bash
❯❯ tail -F syslog |while read -r line;do printf "\\e[38;5;%dm%s\\e[0m\\n" $(($RANDOM%255)) "$line";done
```

- Stump your friends. How many months had only 19 days? Answer: 1 (The Month the United States switched to Gregorian)

```bash
❯❯ cal 9 1752
```

- Sleep infinitely or until the next shutdown, whichever comes first

```bash
❯❯ sleep infinity
```

- Yes this works and sleeps for 255 seconds. (doesn't work on all versions of sleep)

```bash
❯❯ sleep 0xFF
```

- List the contents of each gz compressed file, including the compression ratio/uncompressed size. Doesn't work on stdin- >gzip

```bash
❯❯ gzip -l *.gz
```

- Copy file to the previous directory you were in. See "tilde expansion" in bash man page. Thx @gumnos

```bash
❯❯ cp file.txt ~-/
```

- Remove the previous word on the command line (before the cursor). This is highly useful when reusing old commands

```bash
❯❯ <Ctrl-w >
```

- This is usually equivilent to running 'clear'.  Its usually quicker and doesn't leave the command in your command line history

```bash
❯❯ <Ctrl-l >
```

- Manual lists this as Ctrl-_ but Ctrl-- usually works too. Incremental undo of command line edits

```bash
❯❯ <Ctrl-- >
```

- Insert the last argument from the previous line in the command history into the current line. Different from !$

```bash
❯❯ <Meta-. >
```

- Move your cursor to the end of the line. Faster than holding down right arrow

```bash
❯❯ <Ctrl-e >
```

- Move your cursor to the beginning of the line. Faster than holding down left arrow. In screen, you need to press `<Ctrl-a a >`

```bash
❯❯ <Ctrl-a >
```

- Reverse search through your command history for 'string'. Press Ctrl-r again to continue searching backwards. ESC when done

```bash
❯❯ <Ctrl-r >string
```

- description. The

```bash
❯❯ Just a reminder about the format of climagic tweets: command
```

- (With no arguments) Takes you back to your home directory

```bash
❯❯ cd
```

- Takes you back to the previous directory you were in. Good to know if you don't already

```bash
❯❯ cd -
```

- Date the system booted last. Uses Perl regex (zero-width look behind assertion)

```bash
❯❯ date -d "now - $( uptime | grep -o -P "(?<=up )[^,]+" )
```

- Thx @gumnos

```bash
❯❯ look .|awk \'/^[a-g]{3,}$/{print gensub("."," pl &3","g",toupper($0))}\'|while read w;do echo $w;play -n synth $w fade h 0 2;done
```

- Download a series of timed images from a site with 1 second delay between

```bash
❯❯ wget -w1 http://www.example\\.com/{00..23}h{00,15,30,45}m.png
```

- Find 4+ letter words that are spelled using only musical note letters

```bash
❯❯ look . | egrep "^[a-g]{4,}$
```

- Stack a lot of files Thx @amenthes_de

```bash
❯❯ convert -size 1920x1080 `find . -iname "*test*" | sed "s/^/ -page +0+0 /"` -layers flatten stack.png
```

- Find a file with a newline or carriage return characters in its name. Req by @peelman

```bash
❯❯ find . -name '*['$'\\r'$'\\n'']*'
```

- Swap integer values without intermediary variable using XOR Equals (As long as they aren't too big). Thx @spikygeek

```bash
❯❯ ((A^=B,B^=A,A^=B))
```