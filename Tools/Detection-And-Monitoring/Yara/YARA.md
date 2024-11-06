# YARA

Yet Another Ridiculous Acronym (YARA) is considered *"The pattern matching swiss knife for malware researchers (and everyone else)"*. More precisely YARA can identify information based on both binary and textual patterns, such as hexadecimal and strings contained within a file. [VirusTotal Github Repository](https://github.com/VirusTotal/yara) states: *"YARA is a tool aimed at (but not limited to) helping malware researchers to identify and classify malware samples. With YARA you can create descriptions of malware families (or whatever you want to describe) based on textual or binary patterns. Each description, a.k.a. rule, consists of a set of strings and a boolean expression which determine its logic."*

For the [YARA Documentation](https://yara.readthedocs.io/en/stable/)

## YARA Rules

Rules are used to label these pattern to later identification.

To use a YARA rule every `yara` command requires two arguments to be valid, these are:  
**1)** The rule file we create  
**2)** Name of file, directory, or process ID to use the rule for.

####  Keywords

[YARA keywords](https://yara.readthedocs.io/en/stable/writingrules.html#table-1) are reserved and cannot be used as an identifier:
all, and, any, ascii, at, base64, base64wide, condition, contains, endswith, entrypoint, false, filesize, for, fullword, global, import, icontains, iendswith, iequals, in, include, int16, int16be, int32, int32be, int8, int8be, istartswith, matches, meta,nocase, none, not
of, or, private, rule, startswith, strings, them, true, uint16, uint16be, uint32, uint32be, uint8, uint8be, wide, xor, define

#### Anatomy of a YARA Rule

[Securitybreak.io Medium](https://blog.securitybreak.io/security-infographics-9c4d3bd891ef#18dd)
![](anatomyofyararules.png)

#### Cheatsheet Example Rule Syntax

This is a cheatsheet of keywords, syntax and discourse of file, beware:
- json is used a markdown coloring for visual pop, nothing more
- **Making rules with massive variable sets and conditions is an anti-pattern (bad idea)** - consider [[Refactoring]] - the below is an *Example of use in a pseudo-context*
	- Ideally for ease of compression and to avoid logical weirdness having massive lists of conditions is the pyramid of doom in debugging, and lmassive list of strings unsegemented may lead to mixing of patterns that occur only in some cases
- YARA handles undefined values in various complex ways that are kind of un-scopable for examplary purposes - [visit](https://yara.readthedocs.io/en/stable/writingrules.html#undefined-values-1)
- It is not functional is anyway
```json
import "ModuleNamehere" // Must be place outside of Rule {}
// ... and this is single-line comment
//global rule GlobalRuleExample // would be globalise
//private rule PrivateRuleExample // not reported with private
//localised to this file:
rule ExampleRule : Tag1 Tag2 // `: Tag Tag ` for later filtering with YARA 
{
	meta:
	//Provide additional data about you r rule here
	id_1 = "This is a example rule"
    strings:
	    // nocase for case insensitive
        $my_text_string = "text here" nocase 
        $my_hex_string = { E2 34 A1 C8 23 FB }
        // wide: 2 byte prt character - ascii is assuming it is also ascii
        $wide_and_ascii_string = "Borland" wide ascii
        // xor with single byte keys
        $xor_string = "This program cannot" xor
        $b64 = "This program cannot" base64
nd still be looking for a game o        $a = { E8 00 00 00 00 } // Entrypoint string
        // Regular expression
        // can be followed with nocase, ascii, wide, fullword
        // `.` can match new-line characters
        $re1 = /md5: [0-9a-fA-F]{32}/
        // private - never to be included in output
        $text_string = "foobar" private
/*
    This is a multi-line comment ...
*/
    condition:
	     // external variable - define rule from value external to the rule
	    ext_var == 69
	    ThisARuleReference // Reference another rule
        any of them // or singularly or multiple with Conditions:
        // $my_text_string or $my_hex_string
        2 of ($my_text_string, $my_hex_string, $xor_string) // sets
        1 of them ($xor_string, $b64) //sets with them
        //1 of them // Use anonymous strings:
	    $a at 100 and $b at 200 // at offset 100, 200
	    $a in (0..100) and $b in (100..filesize) // at in offsete ranges
	    filesize > 200KB
	    $a at entrypoint
	    $a in (entrypoint..entrypoint + 10) // raw offset of executable's entrypoint 
	    // Applying the same condition to many strings
	    for any of ($a,$b,$c) : ( $ at pe.entry_point  )
	    // iterating over sting occurences - with for, for..of
	    for all i in (1,2,3) : ( @a[i] + 10 == @b[i] )
	    uint32(uint32(0x3C)) == 0x00004550 // use (un)signed-integer read offsets 
}
```

#### Conditions
![](yaraconditions.png)

#### YARA Regex

YARA’s regular expressions recognise the following metacharacters:
```json
`\` Quote the next metacharacter
`^` Match the beginning of the file or negates a character class when used as the first character after the opening bracket
`$` Match the end of the file
`.` Matches any single character except a newline character
`|` Alternation
`()` Grouping
`[]` Bracketed character class
// The following quantifiers are recognised as well:
`*` Match 0 or more times
`+` Match 1 or more times
`?` Match 0 or 1 times
`{n}` Match exactly n times
`{n,}` Match at least n times
`{,m}` Match at most m times
`{n,m}` Match n to m times
// All these quantifiers have a non-greedy variant, followed by a question mark (?):
`*?` Match 0 or more times, non-greedy
`+?` Match 1 or more times, non-greedy
`??` Match 0 or 1 times, non-greedy
`{n}?` Match exactly n times, non-greedy
`{n,}?` Match at least n times, non-greedy
`{,m}?` Match at most m times, non-greedy
`{n,m}?` Match n to m times, non-greedy
// The following escape sequences are recognised:
`\t` Tab (HT, TAB)
`\n` New line (LF, NL)
`\r` Return (CR)
`\f` Form feed (FF)
`\a` Alarm bell
`\xNN` Character whose ordinal number is the given hexadecimal number
// These are the recognised character classes:
`\w` Match a _word_ character (alphanumeric plus “_”)
`\W` Match a _non-word_ character
`\s` Match a whitespace character
`\S` Match a non-whitespace character
`\d` Match a decimal digit character
`\D` Match a non-digit character
// Starting with version 3.3.0 these zero-width assertions are also recognized:
`\b` Match a word boundary
`\B` Match except at a word boundary
```

## YARA Modules

- [Cuckoo Sandbox](https://cuckoosandbox.org/)

- [Python's PE Module](https://pypi.org/project/pefile/) 


## YARA Useful Auxiliary Toolset

[Yara-CI](https://yara-ci.cloud.virustotal.com/): *"YARA-CI helps you to keep your [YARA](https://virustotal.github.io/yara/) rules in good shape. It can be integrated into any GitHub repository containing YARA rules, and it will run automated tests every time you make some change."*

[yarGen](https://github.com/Neo23x0/yarGen) - *"is a generator for YARA rules"*

```bash 
# -m file to generate rules from
# --excludegood : force to exclude all goodware strings
# -o outpath
python3 yarGen.py -m $inputFile --excludegood  -o $outputFile
```

Consult:
-   [https://www.bsk-consulting.de/2015/02/16/write-simple-sound-yara-rules/](https://www.bsk-consulting.de/2015/02/16/write-simple-sound-yara-rules/)  
-   [https://www.bsk-consulting.de/2015/10/17/how-to-write-simple-but-sound-yara-rules-part-2/](https://www.bsk-consulting.de/2015/10/17/how-to-write-simple-but-sound-yara-rules-part-2/)
-   [https://www.bsk-consulting.de/2016/04/15/how-to-write-simple-but-sound-yara-rules-part-3/](https://www.bsk-consulting.de/2016/04/15/how-to-write-simple-but-sound-yara-rules-part-3/)

[Yextend](https://github.com/BayshoreNetworks/yextend): *"YARA integrated software to handle archive file data."*

[Loki](https://github.com/Neo23x0/Loki)  is a *"Simple IOC and Incident Response Scanner"*. Detection is based on:
1. File Name IOC - Regex match on full file path/name
2. YARA Rule Check - YARA signature match on file data and process memory
3. Hash Check - Compares known malicious hashes (MD5, SHA1, SHA256) with scanned files
4. C2 Back Connect Check - Compares process connection endpoints with C2 IOCs (new since version v.10)

[Thor](https://www.nextron-systems.com/thor-lite/) - multi-platform IOC AND YARA scanner for corporate customers.

[FENRIR](https://github.com/Neo23x0/Fenrir) - Simple Bash IOC Scanner

[YAYA](https://github.com/EFForg/yaya) - Yet Another YARA Automaton - Automatically curate open source YARA rules and run scans

[VALHALLA](https://www.nextron-systems.com/valhalla/)  -  boosts your detection capabilities with the power of thousands of hand-crafted high-quality [YARA](https://virustotal.github.io/yara/) and [Sigma](https://github.com/SigmaHQ/sigma) rules.

#### Community Rules, Projects, Extras

[awesome-yara](https://github.com/InQuest/awesome-yara) - A curated list of awesome YARA rules, tools, and resources
[Yara-Rules Porject](https://github.com/Yara-Rules) and their [rule Repository](https://github.com/Yara-Rules/rules)

## References

[Virustotal., 2020](https://virustotal.github.io/yara/)
[VirusTotal Github Repository](https://github.com/VirusTotal/yara)
[YARA keywords](https://yara.readthedocs.io/en/stable/writingrules.html#table-1)
[Securitybreak.io Medium](https://blog.securitybreak.io/security-infographics-9c4d3bd891ef#18dd)
