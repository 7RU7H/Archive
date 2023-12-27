Not to be confused with [[VS-Code]] ... it hurts.

Add Extensions:
`Extensions -> Manage Extensions -> Search -> $oneyouwant -> Download`

1. `Open Project`
1. `Build -> Configuration Manager`
1. `Active solution configuration list` choose `<New...>` 
1. Name it
1. `New Solution Platform dialog box` choose correct architecture
1. Play button

`File -> Save` - Save your work

Create new Project
`Create NewProject  -> Console App -> Name`

Lose the Solution Explorer?
`Debug -> $nameofproject Debug Properties` at the very bottom of the drop down.

Change Target Framework, because...
`[Right Click]` the `[C#] $projectname` in `Solution Explorer` go to `Properties -> Target Framework`

Configure precompiation headers
`Project -> $NAME Properties -> Precompiled Headers -> Do not use precompiled headers`


Compile 
`Build -> Build Solution` 
`[CTRL] + B`

[Override the  Language Version](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version), because...
- Manually edit your [project file](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#edit-the-project-file).
- Set the language version [for multiple projects in a subdirectory](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#configure-multiple-projects).
- Configure the [**LangVersion** compiler option](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/language#langversion).

Get implementations from Libraries
`CTRL + Right-Click` on a name to find symbol results: `struct IMAGE_DOS_HEADER {}` and VS will find how it is defined 

## References

[Microsoft Official Walkthrough-building-an-application](https://learn.microsoft.com/en-us/visualstudio/ide/walkthrough-building-an-application?view=vs-2022)
[Override the  Language Version](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version), because...
[Manually edit your project file](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#edit-the-project-file).
[Set the language version for multiple projects in a sub-directory](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#configure-multiple-projects).
[Configure the **LangVersion** compiler option](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/language#langversion).
[Microsoft.Learn - Visual Studio: Finding and Using Extensions](https://learn.microsoft.com/en-us/visualstudio/ido/finding-and-using-visual-studio-extensions?view=vs-2022)