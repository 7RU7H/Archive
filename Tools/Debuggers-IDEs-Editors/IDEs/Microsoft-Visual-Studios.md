Not to be confused with [[VS-Code]] ... it hurts.

## Compiling Exploits

For legacy `.NET` [c-sharpcorner](https://www.c-sharpcorner.com/article/open-legacy-projects-4-5-framework-in-visual-studio-2022/)

Downloading [microsoft.netframework.referenceassemblies.net45](https://www.nuget.org/packages/microsoft.netframework.referenceassemblies.net45)

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

Compile 
`Build -> Build Solution` 

[Overide the  Language Version](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version), because...
- Manually edit your [project file](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#edit-the-project-file).
- Set the language version [for multiple projects in a subdirectory](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#configure-multiple-projects).
- Configure the [**LangVersion** compiler option](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/language#langversion).

## References

[Microsoft official walkthrough-building-an-application](https://learn.microsoft.com/en-us/visualstudio/ide/walkthrough-building-an-application?view=vs-2022)

[Overide the  Language Version](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version), because...
[Manually edit your project file](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#edit-the-project-file).
[Set the language version for multiple projects in a subdirectory](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version#configure-multiple-projects).
[Configure the **LangVersion** compiler option](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/compiler-options/language#langversion).