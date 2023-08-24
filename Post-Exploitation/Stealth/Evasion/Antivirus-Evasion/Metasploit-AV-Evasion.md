
# Metasploit AV-Evasion


A [[MSFVenom-Payloads]] are blank executables that are injected with shellcode.

```bash
# Find the 
msfvenom -l encoder | grep x$BIT
--enc  
-i # iterations of encoding

# Specify a custom executable 
# Either it will overwrite the entry point of the file
# Or...
# Use non-Microsoft binaries 
# Microsoft probably does not want their .exe to be backdoored
-x, --template
# Prevent crashing of binary 
EXITFUNC=thread
# Show Advanced 
PREPENDMIGRATE=true
PREPENDMIGRATEPROC=$bin.exe
```

At the multi/handler:
```ruby
show advanced
# For meterpreter usage
# Disable the STD API - less options, but still good
set autoloadstdapi false 

set PrependMigrate $file.exe

# For runtime temporal actualities
AutoRunScript post/windows/manage/migrate
```



## References


[Alh4zr3d]() - Watched Live, find VOD or youtube