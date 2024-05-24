# VS Code | Codium Debugging

[[VS-Code]] or Codium or any other alternatives that exist are IDEs used to debug source code for a program, script, etc.


1. Run and Debug `Ctrl + Shift + D`


Configure or auto-generate available with some extensions; file found at `.vscode/launch.json` for both Linux and Windows in user directory.
```json
{
  // ...
  "configuration": [
    {
      // ...
      "program": "${workspaceRoot}",
      // ...
    }
  ]
}
```
[code.visualstudio - Debugging](https://code.visualstudio.com/Docs/editor/debugging): *"VS Code will try to automatically detect your debug environment, but if this fails, you will have to choose it manually.."*

Mandatory configurations attributes:
- `name`: the name of your configuration as it appears in the drop-down in the Run view.
- `type`: the debugging type VS Code uses to decide which debugging extension should be used. Always leave this set to `"go"`.
- `request`: `launch` (a new process) or `attach` (to a currently running process).

[code.visualstudio - Debugging](https://code.visualstudio.com/Docs/editor/debugging): *"You can use IntelliSense suggestions (`Ctrl+Space`) to find out which attributes exist for a specific debugger."*

 Full list of all configuration attribute: [GitHub - List of VScode launch.json configuration attributes](https://github.com/golang/vscode-go/blob/master/docs/debugging.md#launchjson-attributes)

`F5` to launch debugging session with a configuration or use the *Command Palette (`Ctrl+Shift+P`) by filtering on Debug: Select and Start Debugging or typing `'debug '` and selecting the configuration you want to debug.* 

2. Set Breakpoints and use Brain 
	- Debugging panel with: the follow is from [kittipat1413 - Golang Debugging Blog:](https://dev.to/kittipat1413/golang-debugging-in-visual-studio-code-1afd)
		- Continue / Pause `F5`
		- Step Over (aka `next` in Delve) `F10`
		- Step Into (aka `step` in Delve) `F11`
		- Step Out (aka `stepout` in Delve) `Shift+F11` or ⇧`F11`
		- Restart (currently this is "Stop + Start") `Ctrl+Shift+F5` or ⇧⌘`F5`
		- Stop (terminate the debugger. Available in Launch request) Shift+`F5` or ⇧`F5`
	- `F5` to run till next breakpoint



## References

[kittipat1413 - Golang Debugging Blog:](https://dev.to/kittipat1413/golang-debugging-in-visual-studio-code-1afd)
[GitHub - List of VScode launch.json configuration attributes](https://github.com/golang/vscode-go/blob/master/docs/debugging.md#launchjson-attributes)
[digitalocean - debugging go code with visual studio code](https://www.digitalocean.com/community/tutorials/debugging-go-code-with-visual-studio-code)
[medium.com/@troynjohnson6 - A comprehensive guide to debugging in Visual Studios Code](https://medium.com/@troynjohnson6/a-comprehensive-guide-to-debugging-in-visual-studio-code-vscode-cce885f19c1a)