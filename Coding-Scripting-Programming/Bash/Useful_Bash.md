# Bash Condensed

Condensing everything I know and learn about bash scripting from Tryhackme, XinYminutes, Offensive Security pwk100,pwk200, writing my own scripts and copious amazing stackoverflow answers.

```bash
#!/bin/bash

echo "#!/bin/bash is called shebang or absolute path for the interpreter to run the script"
echo

echo "All Linux modules can be used in Bash Scripting!"

name="mrBASH is a variable name"

echo "$name using the dollar/pound sign to substitute var \$ + name" 
echo
echo "Use \$ and () or backticks(legacy way) to output a command or multiple to a variable with ="
echo
echo "Numbers are strings if they are enclosed with double quotations(single quotes are not interpretered!) and numeric variables are not - integers only!"
echo
echo "Varibales declared outside of functions have global scope, BEWARE"
echo

```

# Special Bash Variables:
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

# Reading User Input
```bash
read var		
read -p	'Your input: ' var		#specify a prompt
read -sp 'Your silent input: ' var 	#specify prompt for silent input
```

# Conditional Statements
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

# Operators
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

# For loop structure
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
```
for ((i=$x;i<=$y;i++))
```
Before using the following functions, read below !For a sequence of numbers, you might use `seq`:
```
for i in $(seq $x $y)
```
If you really need brace expansion, you can use `eval`:
```
for i in $(eval echo {$x..$y})
```

# Using Files
```bash
FILENAME=file.txt
LINES=$(cat $FILENAME)
for LINE in $LINES
do
	echo "$LINE"
done
```

# Function definition 
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
	echo "C-like function defintition"
}

```
Declare a function with 
```bash
testfunc ## arg1 arg2 .. 
```

# Case statements
These are like switch statements 
```bash
case "$Variable" in
    # List patterns for the conditions you want to meet
    0) echo "There is a zero.";;
    1) echo "There is a one.";;
    *) echo "It is not null.";;  # match everything
esac

status=$(
  case "$status" in
    ("foo") echo "bar" ;;
    ("baz") echo "buh" ;;
    (*) echo "$status" ;;
  esac)
```
[string variant](https://stackoverflow.com/questions/2283640/case-statements-evaluate-to-strings#2283814)

# Parametre Expansion: indirection, listing and length
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
```

# Arrays
```bash
array=(zero one two );
array+=( three )
array=("${array[@]// /_}") # recreate array with spaces in elements as underscores
array=( "${array[@]:2:3}" )
echo "${array[1]}"
echo ${!array[@]}
```

# Session portability
```bash
sudo bash -c ""
$(declare -p parametres; declare -f functions) # put code here run code"
ssh remotehote "
$(declare -p parametres; declare -f functions) # put code here run code"
```

# Arguments and Usage
```bash
if [ "$#" -ne $ARGTOTAL ]; then
	echo "Usage: $0 <excepted> <arguments>"
	exit
fi
```