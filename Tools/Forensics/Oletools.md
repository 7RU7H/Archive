# Oletools

`oleid`
```bash
# Get basic information 
oleid $maldoc
```
`olebrowse`   
```

```
`oledir` 
```

```
 `oledump.py`
```bash
# Get the Streams 
oledump.py $maldoc
# Best practice seems to be go string by string till you hit a good line
oledump.py -s $int $maldoc
oledump.py -s $specialLineNum -S $maldoc
```
 `olefile`    
```

```
 `olemap`
```

```
`olemeta`     
```bash
# Documents have metadata
olemeta $maldoc
```
`oleobj`
```bash

```
`oletimes`
```bash
# Time-related malware shinagans exist to ruin your timelining olemeta will give false positive
oletimes $maldoc
```
`olevba`
```bash
# Get the type of Subs
olevba
```