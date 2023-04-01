# Atomic Red Team

[Atomic Red Team](https://github.com/redcanaryco/atomic-red-team) is a *"Small and highly portable detection tests based on MITRE's ATT&CK."* It is used to simulate TTPs that are mapped to the [MITRE ATT&CK®](https://attack.mitre.org/) framework and the platforms they support. It is avalible for almost all cloud infrastructure and services, kubernetes and Windows, Linux, macOS operating systems.  [Atomic Red Team Documentation](https://github.com/redcanaryco/atomic-red-team/wiki/). 


Executors
- To mimic activity Executors are either Manual or Terminal and Shell-based 

Atomics
- Refer to standalone mock versions of [MITRE ATT&CK®](https://attack.mitre.org/) techniques that can emulated - see brief article locally [[MITRE-ATT&CK]], each Atomic is comprised of two files:
	- a Markdown (.md) information file
	- a YAML file (.yaml) configuration file
		- attack_technique - MITRE ATT&CK Technique ID
		- display_name - The technique name
		- atomic_tests - List of atomic tests detailing how each test is executed
		- name - description of how it tests the technique. 
		- auto_generated_guid - Unique identifier of the specific test.
		- description - A longer form of the test details and can be written in a multi-line format.
		- supported_platforms - platform - Linux, Windows...
		- input_arguments - Required values during the execution - default values are present in the file.
		- dependency_executor_name - Option on how the prerequisites will be validated. The possible values for this field are similar to the Executor field. 
		- dependencies
			- prereq_command - Commands to check if the requirements for running this test are met. 
			- get_prereq_command - Commands to meet this prerequisite or a message describing how to meet this requirement.
		- executor
			- name - Name of the Executor
			- command - Exact command to emulate the technique.
			- cleanup_command - Commands for cleaning up the previous atomic test
			- elevation_required - A boolean value that dictates if an admin privilege is required.


[invoke-atomicredteam](https://github.com/redcanaryco/invoke-atomicredteam) *"Invoke-AtomicRedTeam is a PowerShell module to execute tests as defined in the [atomics folder]([https://github.com/redcanaryco/atomic-red-team/tree/master/atomics](https://github.com/redcanaryco/atomic-red-team/tree/master/atomics)) of Red Canary's Atomic Red Team project."* [Link for Usage and installation instuction](https://github.com/redcanaryco/invoke-atomicredteam/wiki)

[atomicredteam.io](https://atomicredteam.io/atomics/#collection) shows the available Tactics and Atomics combined with [MITRE ATT&CK® Navigator](https://mitre-attack.github.io/attack-navigator/) - or article here [[MITRE-ATT&CK-Navigator]]

```powershell
powershell -ExecutionPolicy bypass
# Load Module
Import-Module "C:\Tools\invoke-atomicredteam\Invoke-AtomicRedTeam.psd1" -Force
# Create a path when located in default location.
$PSDefaultParameterValues = @{"Invoke-AtomicTest:PathToAtomicsFolder"="C:\Tools\AtomicRedTeam\atomics"}
# Help
help Invoke-AtomicTest
# Details a MITRE TTPs and AtomicRT Atomics and Executors
Invoke-AtomicTest TXXXX -ShowDetails -ShowDetailsBrief
# To get prerequisites requires internet
Invoke-AtomicTest TXXXX -GetPrereqs -CheckPrereqs 

# From Atomics Directory find and run invoke-atomictest for ART 
PS: $PATH\atomics

Where-Object Name -Match "T1566.001|T1203|T1059.003|T1083|T1082|T1016|T1049|T1007|T1087.001"

'T1566.001','T1059.003','T1083','T1082','T1016','T1049','T1007','T1087.001' | ForEach-Object {echo "Enumerating $_"; Invoke-AtomicTest $_ -ShowDetailsBrief }

```

## References

[THM Room Atomic Read Team](https://tryhackme.com/room/atomicredteam)
[Atomic Red Team Github](https://github.com/redcanaryco/atomic-red-team) 
[Atomic Red Team Wiki](https://github.com/redcanaryco/atomic-red-team/wiki/).
[MITRE ATT&CK®](https://attack.mitre.org/)
[invoke-atomicredteam](https://github.com/redcanaryco/invoke-atomicredteam)
[Link for Usage and installation instuction](https://github.com/redcanaryco/invoke-atomicredteam/wiki)