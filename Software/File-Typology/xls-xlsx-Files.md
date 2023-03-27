
## CLI XLS and XLSX File Analysis

On Linux:
```bash
# Backup and create a .zip copy for extracting all the content of the original file
mkdir Hacking-The-XLSX
cp $file.xlsx $file.zip
# Disassemble the file
unzip $file.xlsx
# At this point it depends on objectives and context -
tree # View now expanded file tree that was encapsulated by the .xlsx file
# Hack the xlsx 
# Reassemble an altered version:
zip -r $alteratedFile.xlsx .
# View the altered version like a typical GUI user
libreoffice $alteratedFile.xlsx
```