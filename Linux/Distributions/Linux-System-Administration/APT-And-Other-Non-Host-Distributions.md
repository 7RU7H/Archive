
# APT and other Non-Host Distributions

The article discusses the ways to use packages from other distributions with `apt`. `apt` can manage  coexistence of mixing packages from different distributions very well and limits risks very effectively (provided that the package dependencies are accurate). Everything is reliant on apt consideration of packages by values that are great than or equal the install currently packages (assuming that `/etc/apt/preferences` has not been used to force priorities higher than 1000 for some packages). 

```bash
apt-cache policy # display default priority
apt install $package/$substate_of_distribution
# if it fails due to unsatisfiable dependencies use:
-t $substate_of_distribution
```