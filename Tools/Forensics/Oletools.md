# Oletools

Is used in [[MalDoc-Analysis]] to analyse specifically malicious [[Visual-Basic]]. Although it is just a tool is very effective at finding [true horrors](https://www.youtube.com/watch?v=xydcP31wVRk), a brain is still required as with all tooling; `tool ^ tool =  tool^2` and `brain + tool = success(Nth*brain) float`

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
# Get the Streams - M denotes stream that contain Macros; -i provides byes breakdown, very useful!
oledump.py -i $maldoc
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

## References

[Youtube - Excel Macros and the true horrors that dwell within meme](https://www.youtube.com/watch?v=xydcP31wVRk)