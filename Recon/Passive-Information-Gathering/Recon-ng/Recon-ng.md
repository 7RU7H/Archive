# Recon-ng
RECON-NG
```bash
workspaces create name
db shema #
db insert tablename # i.e blueteamshouse.there
```

## Marketplace

From tryhackme:
"Before you install modules using the marketplace, these are some useful commands related to marketplace usage:

```bash
marketplace search KEYWORD # to search for available modules with keyword.
marketplace info MODULE 	 # to provide information about the module in question.
marketplace install MODULE # to install the specified module into Recon-ng.
marketplace remove MODULE # to uninstall the specified module."
```

## Modules:

```bash
modules search  # to get a list of all the installed modules
modules load MODULE # to load a specific module to memory

options list # to list the options that we can set for the loaded module.
options set $option $value # to set the value of the option."
```

## Keys:

From tryhackme:
"Some modules cannot be used without a key for the respective service API. K indicates that you need to provide the relevant service key to use the module in question.
```bash
keys list # lists the keys
keys add KEY_NAME KEY_VALUE #  adds a key
keys remove KEY_NAME # removes a key
```
Once you have the set of modules installed, you can proceed to load and run them.
```bash
modules load MODULE loads an installed module
# CTRL + C unloads the module.
modules info # to review the loaded module’s info.
options list # lists available options for the chosen module.
options set NAME VALUE
run # to execute the loaded module.
```