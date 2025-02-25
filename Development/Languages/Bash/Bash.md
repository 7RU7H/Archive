# Bash 

Condensing everything I know and learn about bash scripting from Tryhackme, XinYminutes, Offensive Security pwk100, pwk200, writing my own scripts and copious amazing StackOverflow answers.

```bash
#!/bin/bash

echo "#!/bin/bash is called shebang or absolute path for the interpreter to run the script"
echo

echo "All Linux modules can be used in Bash Scripting!"

name="mrBASH is a variable name"

echo "$name using the dollar/pound sign to substitute var $ + name" 
echo
echo "Use $ and () or backticks(legacy way) to output a command or multiple to a variable with ="
echo
echo "Numbers are strings if they are enclosed with double quotations(single quotes are not interpretered!) and numeric variables are not - integers only!"
echo
echo "Varibales declared outside of functions have global scope, BEWARE"
echo

```

#### Special Bash Variables:
```bash
$0 			# The name of the Bash script
$1 - $9 	# The first 9 arguments to the Bash script
$# 			# Number of arguments passed to the Bash script
$@ 			# All arguments passed to the Bash script
$? 			# The exit status of the most recently run process
$$ 			# The process ID of the current script
$USER 		# The username of the user running the script
$HOSTNAME 	# The hostname of the machine
$RANDOM 	# A random number
$LINENO 	# The current line number in the script
```

#### Reading User Input
```bash
read var		
read -p	'Your input: ' var		#specify a prompt
read -sp 'Your silent input: ' var 	#specify prompt for silent input
```

#### Conditional Statements
```bash
if [ evaluation ]
then
  echo "do something"
elif [ another evaluation ]
then
  echo "do this instead"
 elif [[ evaluation == $evaluation_double_char_require_double_square ]]
  echo "check xinybash"
else 
  echo "do something else" 
fi
```
 
#### Operators
```bash
# Logical Operators
&& AND		# is boolean operator! Executed based previous output...
|| OR 		# of a ...command succeeding(or returned True or 0), ...
| PIPE		# failures return non-zero.

# Conditional Operators
expression ? expression : expression	# conditional operator
!EXPRESSION 							# The EXPRESSION is false.

# String Operators
-n STRING 				# STRING length is greater than zero
-z STRING 				# The length of STRING is zero (empty)
STRING1 != STRING2 		# STRING1 is not equal to STRING2
STRING1 = STRING2 		# STRING1 is equal to STRING2

# Integer Operators
INTEGER1 -eq INTEGER2 	# INTEGER1 is equal to INTEGER2
INTEGER1 -ne INTEGER2 	# INTEGER1 is not equal to INTEGER2
INTEGER1 -gt INTEGER2 	# INTEGER1 is greater than INTEGER2
INTEGER1 -lt INTEGER2 	# INTEGER1 is less than INTEGER2
INTEGER1 -ge INTEGER2 	# INTEGER1 is greater than or equal to INTEGER 2
INTEGER1 -le INTEGER2 	# INTEGER1 is less than or equal to INTEGER 2

# File Operators
-d FILE 	# FILE exists and is a directory
-e FILE 	# FILE exists
-r FILE 	# FILE exists and has read permission
-s FILE 	# FILE exists and it is not empty
-w FILE 	# FILE exists and has write permission
-x FILE 	# FILE exists and has execute permission

# Arithmetical Operators
$(( $MATHSGOESHERE ))	 	# Arithemetic expansion
$[ $MATHSGOESHERE ]			# Another way to do arithemetic expansion
expr						# Legacy let or declare
let				
delcare 
id++, id–					# variable post-increment, post-decrement
++id, –id					# variable pre-increment, pre-decrement
-, +						# unary minus, plus
!, ~						# logical and bitwise negation
**							# exponentiation
*, /, %						# multiplication, division, modulo
+, -						# addition, subtraction
«, »						# left and right bitwise shifts
<=, >=, <, >				# comparison
==, !=						# equality, inequality
&							# bitwise AND
^							# bitwise XOR
|							# bitwise OR

# Assignment(ARITHMETIC) Operators
=, *=, /=, %=, +=, -=, «=, »=, &=, ^=, |= # For Arithmetic
```

#### For loop structure
```bash
for var-name in <list>
do
  <action to perform>
done
#for loop with range of 1 to 10
for i in {1..10}; do echo 10.11.1.$i;done
#While loop structure
while [ <some test> ]
do
  <perform an actioin>
done
#While loop with a counter
counter=1

while [ $counter -lt 10 ]
do
  echo "10.11.1.$counter"
  ((counter++))
done
# In a array
for i in "${array0[@]}"; do
    echo "$i"
done

```
[More from askubuntu](https://askubuntu.com/questions/1057870/bash-script-for-i-in-x-y#1057897)
```bash
for ((i=$x;i<=$y;i++))
```
Before using the following functions, read below !For a sequence of numbers, you might use `seq`:
```bash
for i in $(seq $x $y); do $CMD; done
```
If you really need brace expansion, you can use `eval`:
```bash
for i in $(eval echo {$x..$y})
```

#### Using Files
```bash
FILENAME=file.txt
LINES=$(cat $FILENAME)
for LINE in $LINES
do
	echo "$LINE"
done
```

#### Function definition 
You don't have to use the function keyword like C.
```bash
function testfunc () #compond_cmd [>,<,>>] file
{
	echo "Arguments work just like script arguments: $@"
	echo "And: $1 $2..."
    	echo "This is a function"
    	returnValue=0    # Variable values can be returned
   	return $returnValue
}

testfunc () 
{
	echo "C-like function definition"
}

```
Declare a function with 
```bash
testfunc ## arg1 arg2 .. 
```

#### Case statements
These are like switch statements 
```bash
case "$Variable" in
    # List patterns for the conditions you want to meet
    0) echo "There is a zero.";;
    1) echo "There is a one.";;
    *) echo "It is not null.";;  # match everything
esac
```
[string variant](https://stackoverflow.com/questions/2283640/case-statements-evaluate-to-strings#2283814)

#### Parametre Expansion: indirection, listing and length
```bash
param="advanced"; parade="bash";
name=(gnu not unix)
${!} # Indirect expansion
${!pa*} # List names matching prefix
${!name[*]} # List keys in an array
${#param} # Expand to length

# Parametre Expansion: Pattern Subsitution: pattern 'a?', string is '1337' 
${param/pattern/string}
${param//pattern/string}
# Subsitution at left edge:
${param/#pattern/string}
# Substitute at right edge:
${param/%pattern/string}

# Get all the ports in a comma delimited list for nmap scans -p 0,1,2,3 - without last ,
LIST=$(cat masscan/masscan.log | grep -v "#" | awk '{print $7}' | cut -d "/" -f1 | tr -s '\n' ', ')
LENLIST=${#LIST}-1
DECOMMA=${LIST:0:LENLIST}
echo $DECOMMA
```

#### Arrays
```bash
array=(zero one two );
array+=( three )
array=("${array[@]// /_}") # recreate array with spaces in elements as underscores
array=( "${array[@]:2:3}" )
echo "${array[1]}"
echo ${!array[@]}

# Print all elements each of them on new line.
for item in "${array[@]}"; do
    echo "$item"
done
```

#### Session portability
```bash
sudo bash -c ""
$(declare -p parametres; declare -f functions) # put code here run code"
ssh remotehost "
$(declare -p parametres; declare -f functions) # put code here run code"
```

#### Arguments and Usage
```bash
if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <excepted> <arguments>"
	exit
fi
```

#### Host IPv4 address Generator And Recon Hosts
[Inspired by StackOverflow answer](https://stackoverflow.com/questions/43805963/how-to-iterate-a-for-loop-and-create-a-customized-string?rq=3)
```bash
threeoctets="10.0.3."; for (( i = 0; i <= 255; ++i )); do echo "$threeoctets$i"; done
# Requires netcat
threeoctets="10.0.3."; for (( i = 0; i <= 255; ++i )); do ip="$threeoctets$i";nc -nvv -w 1 -z $ip 22; done
```
#### Simple Port Scanner
```bash
#!/bin/bash
# Takes an IP as an argument
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <excepted> <arguments>"
	exit
fi
host=$1
for port in {1..65535}; do
    timeout .1 bash -c "echo >/dev/tcp/$host/$port" &&
        echo "port $port is open"
done
echo "Done"
```


#### Check if root or `sudo` used
From [StackOverFlow](https://stackoverflow.com/questions/42875809/checking-sudo-in-bash-script-with-if-statements)
```bash
if [[ "$EUID" = 0 ]]; then
    echo "(1) Currently root"
else
    sudo -k # make sure to ask for password on next sudo
    if sudo true; then
        echo "(2) Correct password"
    else
        echo "(3) Incorrect password"
        exit 1
    fi
fi
```

#### Binary to Decimal Conversion

```bash
onebyte=10100101
echo "$((2#$onebyte))"
```

#### Recursive Directory Making

```bash
mkdir -p ~/parent-directory/{child-directory-1,child-directory-2,child-directory-3}
```

#### Colouring  `stdout`

```bash
BOLD="\e[1m"  
NORMAL="\e[0m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
purple="\033[1;35m"
cyan="\033[1;36m"
grey="\033[0;37m"
reset="\033[m"
${BOLD}[+]USAGE:${NORMAL} ./search.sh  (OPTIONS)
```


## References

[More from askubuntu](https://askubuntu.com/questions/1057870/bash-script-for-i-in-x-y#1057897)
[StackOverFlow](https://stackoverflow.com/questions/42875809/checking-sudo-in-bash-script-with-if-statements)
[string variant](https://stackoverflow.com/questions/2283640/case-statements-evaluate-to-strings#2283814)
[StackOverflow answer inspiration for Host IPv4 address Generator](https://stackoverflow.com/questions/43805963/how-to-iterate-a-for-loop-and-create-a-customized-string?rq=3)