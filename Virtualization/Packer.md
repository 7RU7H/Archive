## Introduction

*Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration. Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel.*

It can used with Containers, Cloud Infrastructures and local Virtualisation Setups.

### Installation

To download see your OS relevant installation instructions here: https://developer.hashicorp.com/packer/downloads?host=www.packer.io. There is CLI installation and downloadable binaries.

### Builders

You then require the relevant *builder* to build an image. Builders *are components of Packer that are able to create a machine image for a single platform. Builders read in some configuration and use that to run and generate a machine image. A builder is invoked as part of a build in order to create the actual resulting images. Example builders include VirtualBox, VMware, and Amazon EC2. Builders create machines and generate images from those machines for various platforms. Packer also has some builders that perform helper tasks, like running provisioners.* 

- Packer runs a localhost http webserve to serve its the build components! 
1. It takes `.json` or `.hcl2` as input as specification of what to build or configure if it is pre-existing. 
2. Installs the build
3. Exports it to the self distributable format.

### Building Images

Write a packer template for your setup, which is a configuration file that defines the image you want to build and how to build it. Packer templates use the Hashicorp Configuration Language (HCL).


## References

[Hashicorp](https://developer.hashicorp.com/packer/docs/intro)
[Conda Packer Video](https://www.youtube.com/watch?v=T-nhDIfMoL8&list=PLDrNMcTNhhYoEjHYs0ZBfcSE7Hw46BeTA&index=2)
[Packer Terminology](https://developer.hashicorp.com/packer/docs/terminology)
[Packer Builders](https://developer.hashicorp.com/packer/docs/builders)