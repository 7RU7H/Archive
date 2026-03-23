# Browsers

Much like the Vim/Emacs or the X vs Y Programming Language and or Paradigm, internet discourse containing the inflated meme usage of the word *war* also continues in the domain of which browser someone uses. Although more statistical decisive per time period, which browser you use depends really on your preferences. The page is just here to mostly because I just found [caniuse](https://caniuse.com/ciu/about) that compares and provides up-to-date browser support tables for support of front-end web technologies on desktop and mobile web browsers. It will never be because I have favourite. I remember a time where `bing` was considered a joke and now with the year of writing being early 2024 - the universe would just be that humbling that `bing` like time has made fools of us all - for time being. I await AI to read  emails and reports to make me better at living with services that are just not digestible to humans. 

#### Developer Tools 

Developer Tools Hotkeys
- [[Firefox]], press `Ctrl + Shift + K`
- Google Chrome, press `Ctrl + Shift + J`
- Safari, press `Command + Option + J`

#### `caniuse`

 [caniuse](https://caniuse.com/ciu/about) provides up-to-date browser support tables for support of front-end web technologies on desktop and mobile web browsers.

## Developer Console 

Amazing [lissy93](https://notes.aliciasykes.com/40065/50-awesome-dev-tool-tips) blog on Dev-Tool tips

#### Snippets

Use bang `!` operator from the command pallet to save code for later to then execute it or extract it 

#### Live Expressions

[lissy93](https://notes.aliciasykes.com/40065/50-awesome-dev-tool-tips): Monitor live changes to a webpage with:
- Execute a command and pit using the `Eye` icon 

#### Source Changes

[Changes Tab](https://developer.chrome.com/docs/devtools/changes/) will so changes you have made not what has changed, useful if you overwrite or delete something by accident with a badly place copy and paste.

#### Console Shorthand

- `$()` - Short-hand for [Document.querySelector()](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector) (to select DOM elements, jQuery-style!)
- `$$()` - Same as above, but for `selectAll` for when returning multiple elements in an array
- `$_` - Returns value of last evaluated expression
- `$0` - Returns the most recently selected DOM element (in the inspector)
- `$1`...`$4` can also be used to grab previously selected UI elements
- `$x()` - Lets you select DOM elements using an Xpath query
- `keys()` and `values()` - Shorthand for `Object.getKeys()`, will return an array of either obj keys or values
- `copy()` - Copies stuff to the clipboard
- `monitorEvents()` - Run command each time a given event is fired
- For certain common console commands (like `console.table()`), you don't need to type the preceding `console.`, just run `table()`
- You can clear the console at anytime using Ctrl + L, using the clear button, or by running `clear()`

#### Find Unused Code 

[Coverage](https://developer.chrome.com/docs/devtools/coverage/) tool

## TODO - https://notes.aliciasykes.com/40065/50-awesome-dev-tool-tips, there is so much...I feel older

## References

[caniuse](https://caniuse.com/ciu/about)
[THM XSS Room](https://tryhackme.com/r/room/axss)