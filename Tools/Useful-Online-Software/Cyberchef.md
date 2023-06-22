# Cyberchef

It’s the Cyber Swiss Army Knife.

[Cyberchef](https://cyberchef.org/) is *"simple, intuitive web app for analysing and decoding data without having to deal with complex tools or programming languages. CyberChef encourages both technical and non-technical people to explore data formats, encryption and compression....*
...*The interface is designed with simplicity at its heart. Complex techniques are now as trivial as drag-and-drop. Simple functions can be combined to build up a "recipe", potentially resulting in complex analysis, which can be shared with other users and used with their input."*

CyberChef Open-Sourced through [GitHub](https://github.com/gchq/CyberChef)


## Phishing Email Analysis

From [[Phishing-Email-Header-Analysis]] and extracting the attachment with one of the [[Phishing-Analysis-Tools]] preferable to analyst and [[Cyberchef]].

1. Import file with drag and drop or specify path with the File as Input Icon
2. Extract Strings
	1. `Search -> 'Strings' -> Drag Strings to Recipe Listing -> Chane Match -> All Printable Characters U` - use unicode to prevent malformed character bypasses
	2. `Change 'Minimum String Length' -> 258 or greater`
3. Remove Obsucation Patterns
	1. `Search -> Find/Replace`
	2. Remember to escpae characters with `\`
4. Drop Bytes to access Encoded strings
	1. `Search -> 'Drop Bytes'`
	2. Increase Length until the top bytes are removed
5. Decode any encodings 
	1. `Search -> 'Decode'`
	2. Select an encoding - try various!
6. Find and Remove Common Patterns - if there are any repeated characters - using [[Regular-Expressions]] may help
7. Extract URLs
	1. `Search  -> 'Extract URLs'`
8. Defnag URLs
	1. `Search -> 'Defang URLs'`