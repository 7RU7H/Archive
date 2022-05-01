# Basic Powershell
[xinyMinutes]()

## Basics

#### Variables
```powershell
$varOne = "power"
$varTwo = "shell"
$varOne.GetType()
[int]$varOne 	#type conversion
$Error 			#contains an array of error objects.
$Host 			#contains information about the current hosting application.
$Profile 		#contains the path to the current user profile for PowerShell.
$PID  			#contains the process ID of current PowerShell session.
$PSUICulture  	#contains the UI culture or the regional language of the user interface.
# Boolean are primitives!
$NULL  			#contains the value of NULL.
$False 			#contains the value of False.
$True 			#contains the value of True.
```

#### Operators

```powershell
$cmdletArray = "Start", "Stop", "Read", "Write", "New", "Out"
$Assignment-Operators = "=" , "+=", "-=", "*=", "/=", "%="
$Bitwise-Operators = "-band", "-bor", "-bxor", "-bnot", "-shl", "-shr"
$Arithmetic-Operators = "+", "-", "*", /, "%"
$Logical-Operators = "-and", "-or", "-xor", "-not", "!"
$Redirection-Operators = ">", ">>", "2>", "2>>", "2>&1"
$String-Operators = "-split", "-join"
```

TODO [busywork](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2)

Compararison-Operators 
```powershell
# Operator-Type   Operator        Definition
Equality      	-eq      	Equal
Equality   		-ne      	Not Equal
Equality        -gt      	Greater than
Equality      	-ge      	Greater than or Equal to
Equality        -lt      	Less than
Equality      	-le      	Less than or Equal to
Matching        -like      	compares strings using regular expression
Matching      	-notlike    compares strings using regular expression
Matching      	-match      compares strings using regular expression
Matching      	-notmatch   compares strings using regular expression
Containment     -contains   searches if value exists or not
Containment     -in    	    searches if value exists or not
Containment     -notcontains    searches if value exists or not
Containment     -notin    	searches if value exists or not
Replacement     -replace    replaces part or all of the value
Comparison      -is     	compares data types (not values)
Comparison      -isnot  	compares data types (not values)


# Light-weight Commands - No output formatting, parsing or error presentation
# Piped OBJECT from one cmdlet to the next, like Bash BUT OBJECTS NOT OUTPUT!
# Add all formatting, etc at the end of the chain
```

[For a list of types](https://docs.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-7.2)

#### Conditions

```powershell
if ($value) {
	Write-Output 'True'
}
elif ($value -eq "Something else") {
	Write-Output "Something else"
}
else {
	Write-Output 'False'
}

```

#### Loops

```powershell
# Traditional for loop
for($i=0; $i -le $iterable.Count-1; $i++){
}
# Foreach is like range in Golang or Python
foreach ($var in ("iterables", "are ", "RESEARCH REQUIRED")) {
}
# While loops
while ($x -lt 10) {
}

```

#### Handle exceptions with a try/catch block

```powershell
try {
    # Use "throw" to raise an error
    throw "This is an error"
}
catch {
    Write-Output $Error.ExceptionMessage
}
finally {
    Write-Output "We can clean up resources here"
}
```

#### Properties and Methods
```powershell
$variable | Get-Member
$variable.Member # Member can be methods, properties
```

#### PS Modules
These are collections of functions.
```powershell
. .\module.ps1
Import-Module module.ps1 
```

#### Functions