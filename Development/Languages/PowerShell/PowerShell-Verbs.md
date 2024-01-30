# Powershell Verbs
For [[PowerShell]] general use follow the link.
A listing of powershell verbs, to grep and lookup. [Reference](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.2)

## Common Verbs
PowerShell uses the `System.Management.Automation.VerbsCommon` enumeration class to define generic actions that can apply to almost any cmdlet. The following table lists most of the defined verbs
```powershell

# Common Verbs
Verb (alias) 	Action 	Synonyms to avoid
Add (a) 	Adds a resource to a container, or attaches an item to another item. For example, the Add-Content cmdlet adds content to a file. This verb is paired with Remove. 	Append, Attach, Concatenate, Insert
Clear (cl) 	Removes all the resources from a container but does not delete the container. For example, the Clear-Content cmdlet removes the contents of a file but does not delete the file. 	Flush, Erase, Release, Unmark, Unset, Nullify
Close (cs) 	Changes the state of a resource to make it inaccessible, unavailable, or unusable. This verb is paired with Open. 	
Copy (cp) 	Copies a resource to another name or to another container. For example, the Copy-Item cmdlet copies an item (such as a file) from one location in the data store to another location. 	Duplicate, Clone, Replicate, Sync
Enter (et) 	Specifies an action that allows the user to move into a resource. For example, the Enter-PSSession cmdlet places the user in an interactive session. This verb is paired with Exit. 	Push, Into
Exit (ex) 	Sets the current environment or context to the most recently used context. For example, the Exit-PSSession cmdlet places the user in the session that was used to start the interactive session. This verb is paired with Enter. 	Pop, Out
Find (fd) 	Looks for an object in a container that is unknown, implied, optional, or specified. 	Search
Get (g) 	Specifies an action that retrieves a resource. This verb is paired with Set. 	Read, Open, Cat, Type, Dir, Obtain, Dump, Acquire, Examine, Find, Search
Hide (h) 	Makes a resource undetectable. For example, a cmdlet whose name includes the Hide verb might conceal a service from a user. This verb is paired with Show. 	Block
Join (j) 	Combines resources into one resource. For example, the Join-Path cmdlet combines a path with one of its child paths to create a single path. This verb is paired with Split. 	Combine, Unite, Connect, Associate
Lock (lk) 	Secures a resource. This verb is paired with Unlock. 	Restrict, Secure
Move (m) 	Moves a resource from one location to another. For example, the Move-Item cmdlet moves an item from one location in the data store to another location. 	Transfer, Name, Migrate
New (n) 	Creates a resource. (The Set verb can also be used when creating a resource that includes data, such as the Set-Variable cmdlet.) 	Create, Generate, Build, Make, Allocate
Open (op) 	Changes the state of a resource to make it accessible, available, or usable. This verb is paired with Close. 	
Optimize (om) 	Increases the effectiveness of a resource. 	
Pop (pop) 	Removes an item from the top of a stack. For example, the Pop-Location cmdlet changes the current location to the location that was most recently pushed onto the stack. 	
Push (pu) 	Adds an item to the top of a stack. For example, the Push-Location cmdlet pushes the current location onto the stack. 	
Redo (re) 	Resets a resource to the state that was undone. 	
Remove (r) 	Deletes a resource from a container. For example, the Remove-Variable cmdlet deletes a variable and its value. This verb is paired with Add. 	Clear, Cut, Dispose, Discard, Erase
Rename (rn) 	Changes the name of a resource. For example, the Rename-Item cmdlet, which is used to access stored data, changes the name of an item in the data store. 	Change
Reset (rs) 	Sets a resource back to its original state. 	
Resize(rz) 	Changes the size of a resource. 	
Search (sr) 	Creates a reference to a resource in a container. 	Find, Locate
Select (sc) 	Locates a resource in a container. For example, the Select-String cmdlet finds text in strings and files. 	Find, Locate
Set (s) 	Replaces data on an existing resource or creates a resource that contains some data. For example, the Set-Date cmdlet changes the system time on the local computer. (The New verb can also be used to create a resource.) This verb is paired with Get. 	Write, Reset, Assign, Configure
Show (sh) 	Makes a resource visible to the user. This verb is paired with Hide. 	Display, Produce
Skip (sk) 	Bypasses one or more resources or points in a sequence. 	Bypass, Jump
Split (sl) 	Separates parts of a resource. For example, the Split-Path cmdlet returns different parts of a path. This verb is paired with Join. 	Separate
Step (st) 	Moves to the next point or resource in a sequence. 	
Switch (sw) 	Specifies an action that alternates between two resources, such as to change between two locations, responsibilities, or states. 	
Undo (un) 	Sets a resource to its previous state. 	
Unlock (uk) 	Releases a resource that was locked. This verb is paired with Lock. 	Release, Unrestrict, Unsecure
Watch (wc) 	Continually inspects or monitors a resource for changes. 	
```

## Communications Verbs
PowerShell uses the System.Management.Automation.VerbsCommunications class to define actions that apply to communications. The following table lists most of the defined verbs.
```powershell

Communications Verbs
Verb (alias) 	Action 	Synonyms to avoid
Connect (cc) 	Creates a link between a source and a destination. This verb is paired with Disconnect. 	Join, Telnet
Disconnect (dc) 	Breaks the link between a source and a destination. This verb is paired with Connect. 	Break, Logoff
Read (rd) 	Acquires information from a source. This verb is paired with Write. 	Acquire, Prompt, Get
Receive (rc) 	Accepts information sent from a source. This verb is paired with Send. 	Read, Accept, Peek
Send (sd) 	Delivers information to a destination. This verb is paired with Receive. 	Put, Broadcast, Mail, Fax
Write (wr) 	Adds information to a target. This verb is paired with Read. 	Put, Print
```
## Data Verbs

PowerShell uses the System.Management.Automation.VerbsData class to define actions that apply to data handling. The following table lists most of the defined verbs.
```powershell

Data Verbs
Verb Name (alias) 	Action 	Synonyms to avoid
Backup (ba) 	Stores data by replicating it. 	Save, Burn, Replicate, Sync
Checkpoint (ch) 	Creates a snapshot of the current state of the data or of its configuration. 	Diff
Compare (cr) 	Evaluates the data from one resource against the data from another resource. 	Diff
Compress (cm) 	Compacts the data of a resource. Pairs with Expand. 	Compact
Convert (cv) 	Changes the data from one representation to another when the cmdlet supports bidirectional conversion or when the cmdlet supports conversion between multiple data types. 	Change, Resize, Resample
ConvertFrom (cf) 	Converts one primary type of input (the cmdlet noun indicates the input) to one or more supported output types. 	Export, Output, Out
ConvertTo (ct) 	Converts from one or more types of input to a primary output type (the cmdlet noun indicates the output type). 	Import, Input, In
Dismount (dm) 	Detaches a named entity from a location. This verb is paired with Mount. 	Unmount, Unlink
Edit (ed) 	Modifies existing data by adding or removing content. 	Change, Update, Modify
Expand (en) 	Restores the data of a resource that has been compressed to its original state. This verb is paired with Compress. 	Explode, Uncompress
Export (ep) 	Encapsulates the primary input into a persistent data store, such as a file, or into an interchange format. This verb is paired with Import. 	Extract, Backup
Import (ip) 	Creates a resource from data that is stored in a persistent data store (such as a file) or in an interchange format. For example, the Import-CSV cmdlet imports data from a comma-separated value (CSV) file to objects that can be used by other cmdlets. This verb is paired with Export. 	BulkLoad, Load
Initialize (in) 	Prepares a resource for use, and sets it to a default state. 	Erase, Init, Renew, Rebuild, Reinitialize, Setup
Limit (l) 	Applies constraints to a resource. 	Quota
Merge (mg) 	Creates a single resource from multiple resources. 	Combine, Join
Mount (mt) 	Attaches a named entity to a location. This verb is paired with Dismount. 	Connect
Out (o) 	Sends data out of the environment. For example, the Out-Printer cmdlet sends data to a printer. 	
Publish (pb) 	Makes a resource available to others. This verb is paired with Unpublish. 	Deploy, Release, Install
Restore (rr) 	Sets a resource to a predefined state, such as a state set by Checkpoint. For example, the Restore-Computer cmdlet starts a system restore on the local computer. 	Repair, Return, Undo, Fix
Save (sv) 	Preserves data to avoid loss. 	
Sync (sy) 	Assures that two or more resources are in the same state. 	Replicate, Coerce, Match
Unpublish (ub) 	Makes a resource unavailable to others. This verb is paired with Publish. 	Uninstall, Revert, Hide
Update (ud) 	Brings a resource up-to-date to maintain its state, accuracy, conformance, or compliance. For example, the Update-FormatData cmdlet updates and adds formatting files to the current PowerShell console. 	Refresh, Renew, Recalculate, Re-index
```

## Diagnostic Verbs

PowerShell uses the System.Management.Automation.VerbsDiagnostic class to define actions that apply to diagnostics. The following table lists most of the defined verbs.
```powershell

Diagnostic Verbs
Verb (alias) 	Action 	Synonyms to avoid
Debug (db) 	Examines a resource to diagnose operational problems. 	Diagnose
Measure (ms) 	Identifies resources that are consumed by a specified operation, or retrieves statistics about a resource. 	Calculate, Determine, Analyze
Repair (rp) 	Restores a resource to a usable condition 	Fix, Restore
Resolve (rv) 	Maps a shorthand representation of a resource to a more complete representation. 	Expand, Determine
Test (t) 	Verifies the operation or consistency of a resource. 	Diagnose, Analyze, Salvage, Verify
Trace (tr) 	Tracks the activities of a resource. 	Track, Follow, Inspect, Dig
```

## Lifecycle Verbs

PowerShell uses the System.Management.Automation.VerbsLifeCycle class to define actions that apply to the lifecycle of a resource. The following table lists most of the defined verbs.
```powershell

Lifecycle Verbs
Verb (alias) 	Action 	Synonyms to avoid
Approve (ap) 	Confirms or agrees to the status of a resource or process. 	
Assert (as) 	Affirms the state of a resource. 	Certify
Build (bd) 	Creates an artifact (usually a binary or document) out of some set of input files (usually source code or declarative documents.) This verb was added in PowerShell 6. 	
Complete (cp) 	Concludes an operation. 	
Confirm (cn) 	Acknowledges, verifies, or validates the state of a resource or process. 	Acknowledge, Agree, Certify, Validate, Verify
Deny (dn) 	Refuses, objects, blocks, or opposes the state of a resource or process. 	Block, Object, Refuse, Reject
Deploy (dp) 	Sends an application, website, or solution to a remote target[s] in such a way that a consumer of that solution can access it after deployment is complete. This verb was added in PowerShell 6. 	
Disable (d) 	Configures a resource to an unavailable or inactive state. For example, the Disable-PSBreakpoint cmdlet makes a breakpoint inactive. This verb is paired with Enable. 	Halt, Hide
Enable (e) 	Configures a resource to an available or active state. For example, the Enable-PSBreakpoint cmdlet makes a breakpoint active. This verb is paired with Disable. 	Start, Begin
Install (is) 	Places a resource in a location, and optionally initializes it. This verb is paired with Uninstall. 	Setup
Invoke (i) 	Performs an action, such as running a command or a method. 	Run, Start
Register (rg) 	Creates an entry for a resource in a repository such as a database. This verb is paired with Unregister. 	
Request (rq) 	Asks for a resource or asks for permissions. 	
Restart (rt) 	Stops an operation and then starts it again. For example, the Restart-Service cmdlet stops and then starts a service. 	Recycle
Resume (ru) 	Starts an operation that has been suspended. For example, the Resume-Service cmdlet starts a service that has been suspended. This verb is paired with Suspend. 	
Start (sa) 	Initiates an operation. For example, the Start-Service cmdlet starts a service. This verb is paired with Stop. 	Launch, Initiate, Boot
Stop (sp) 	Discontinues an activity. This verb is paired with Start. 	End, Kill, Terminate, Cancel
Submit (sb) 	Presents a resource for approval. 	Post
Suspend (ss) 	Pauses an activity. For example, the Suspend-Service cmdlet pauses a service. This verb is paired with Resume. 	Pause
Uninstall (us) 	Removes a resource from an indicated location. This verb is paired with Install. 	
Unregister (ur) 	Removes the entry for a resource from a repository. This verb is paired with Register. 	Remove
Wait (w) 	Pauses an operation until a specified event occurs. For example, the Wait-Job cmdlet pauses operations until one or more of the background jobs are complete. 	Sleep, Pause
```

## Security Verbs

PowerShell uses the System.Management.Automation.VerbsSecurity class to define actions that apply to security. The following table lists most of the defined verbs.
```powershell

Security Verbs
Verb (alias) 	Action 	Synonyms to avoid
Block (bl) 	Restricts access to a resource. This verb is paired with Unblock. 	Prevent, Limit, Deny
Grant (gr) 	Allows access to a resource. This verb is paired with Revoke. 	Allow, Enable
Protect (pt) 	Safeguards a resource from attack or loss. This verb is paired with Unprotect. 	Encrypt, Safeguard, Seal
Revoke (rk) 	Specifies an action that does not allow access to a resource. This verb is paired with Grant. 	Remove, Disable
Unblock (ul) 	Removes restrictions to a resource. This verb is paired with Block. 	Clear, Allow
Unprotect (up) 	Removes safeguards from a resource that were added to prevent it from attack or loss. This verb is paired with Protect. 	Decrypt, Unseal
```

## Other Verbs

PowerShell uses the System.Management.Automation.VerbsOther class to define canonical verb names that do not fit into a specific verb name category such as the common, communications, data, lifecycle, or security verb names verbs.
```powershell

Other Verbs
Verb (alias) 	Action 	Synonyms to avoid
Use (u) 	Uses or includes a resource to do something. 	
```