# Vulnerable PHP functions

[mccabe615](https://gist.github.com/mccabe615/b0907514d34b2de088c4996933ea1720)


One I found 

scandir(getcwd())

## include()
Takes all code, text, markup in file and loads it into memory.



## exec()

## shell_exec

## popen()

## passthru()

## system()


## strcmp() - in context

Although not directly vulnerable if the function is passed `$comparethis` which is compared against `$compareagainst` it will produce a boolean true instead of type checking `$comparethis` or transforming the array to string. Poor Login.php
```php
strcmp($compareagainst, $comparethis)
```