# x64dbg


[x64dbg](https://x64dbg.com/) is an open-source x64/x32 debugger for windows; for the official [Documentation](https://help.x64dbg.com/en/latest/). 

After opening a executable the debugger will attach itself to the spawned process and pause it before it starts.

Automatic Breakpoints
- `Options -> Preferences -> Events (Tick or Untick)`

Find stuff with Search For
- `CPU -> Right-Click -> Search For -> $various`


#### Tabs

- [CPU](https://help.x64dbg.com/en/latest/gui/views/CPU.html)  is registers view, the disassembly view, the dump view and the watch view, the stack view, and the info box. 
	- Control Flow buttons from left-to-right
		- Restart
		- Close
		- Run
		- Pause
		- Step into
		- Step over
		- Trace To
		- Trace Over
		- Execute Till
		- Run to user code
	- Defang a binary
		- `Right Click -> Binary -> Edit`
		-  `Right Click -> Binary -> Fill...`
		-  `Right Click -> Binary -> Fill with NOPs`
	- Manipulate Registers
		- `Right Click -> Modify Value`
		- Double Click a 0 or a 1 to change to the alternative
- [Graph](https://help.x64dbg.com/en/latest/gui/views/Graph.html) shows control flow graph.
- [Log](https://help.x64dbg.com/en/latest/gui/views/Log.html) displays all the log messages.
- [Notes](https://help.x64dbg.com/en/latest/gui/views/Notes.html) structured as two text fields to edit, one globally and one for the debuggee for future sessions
- [Call Stack](https://help.x64dbg.com/en/latest/gui/views/CallStack.html) displays the call stack of the current thread as Address, To, From, Size, Comment, Party columns
	- When **Show suspected call stack frame** option in the context menu in call stack view is active, it will search through the entire stack for possible return addresses
	- When inactive it will use standard stack walking algorithm to get the call stack.
- [Trace](https://help.x64dbg.com/en/latest/gui/views/Trace.html)  view a history of stepped instructions.
	- Start and Stop recording of a trace.
	- Search for user-specified constant in entire trace
	- Togglable Auto Disassembly Scroll if active will automatically follow the EIP or RIP of selected instruction in trace view.
	- `Double Click [Column]`:
		- Index: follow in disassembly.
		- Address: toggle RVA display mode.
		- Opcode: toggle breakpoint.
		- Disassembly: follow in disassembly.
		- Comments: set comments.


## References

[x64dbg](https://x64dbg.com/)
[x64dbg Official Documentation](https://help.x64dbg.com/en/latest/)
[THM Dynamic Analysis: Debugging Room](https://tryhackme.com/room/advanceddynamicanalysis)