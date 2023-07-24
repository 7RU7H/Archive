# Managing Nix For Active Directory Help sheet

## Check list

From the local [[Question-Based-Hacking-Methodology]]

Have you checked?:
- Step -1): Are *you* mentally prepared and ready to deal with the issue abound... 
- Step 0): is `/etc/hosts` configured `$DCipv4Address dc.$domain.$tld $domain.$tld` in this order!
- Step 1): Continuously re-synced to the DC: `sudo ntpdate -s $targetDC.$domain.$tld
			- temporal synced to target domain controller required for [[Attacking-Kerberos]] or any [[Active-Directory-Kerberos-Authenication-Defined]] 
- Step 2): Is Kinit configured properly?
- Step 3): Do you need to **(re)**TGT after re-synced to the DC: go to Step 1)
- Step 4): Are you running latest Tool versions!

## Everything is weird 

The [Venn Diagram](https://en.wikipedia.org/wiki/Venn_diagram) of troubleshooting hell: Linux and Active Directory and Open Source Offensive tooling is stressful - relax, but go in knowing what you may have to deal with and mindset of if does not work well I will understand one of the three more. 

## Sync the Time

Continuously re-synced to the DC: `sudo ntpdate -s $targetDC.$domain.$tld`  is required for accessing resources in a Active Directory domain, very important in Kerberos ticketing - beware the edge strategic cases.

## /etc/hosts

`/etc/hosts` needs to configured `$DCipv4Address dc.$domain.$tld $domain.$tld` as the domain controller is important in how many offensive tools negotiate DNS and Kerberos 

## Kinit

Simple script to replace a default realm with a target realm and replace it back.

manageKRB5Conf.sh
```bash
#!/bin/bash

# Author: 7ru7h

if [ "$#" -ne 4 ]; then
        echo "Usage: $0 <cmd: add / remove>/ setup <realm> <kdc> <admin_server>"
        echo "run \`sudo apt-get install krb5-user\' - put: \`KALI\` as default in all capitals, no \` for adding and removing a default realm"
        exit
fi

CMD=$1

function addToKRB5Conf ()
{
        REALM=$1
        KDC=$2
        ADM=$3
        echo "Adding: $@"
        # add realm
        sudo sed -i 's/default_realm = KALI/default_realm = $REALM/g' /etc/krb5.conf
        sudo sed -i 's/\n\tKALI = {\n\t\tkdc = KALI\n\t\tadmin_server = KALI\n\t}/\n\t$REALM = {\n\t\tkdc = $KDC\n\t\tadmin_server = $ADM\n\t}/g' /etc/krb5.conf
        cat /etc/krb5.conf
        return
}

function removeFromKRB5Conf ()
{
        REALM=$1
        KDC=$2
        ADM=$3
        echo "Remove and replacing back to default KALI every field: $@"
        sudo sed -i 's/default_realm = $REALM/default_realm = KALI/g' /etc/krb5.conf
        sudo sed -i 's/\n\t$REALM = {\n\t\tkdc = $KDC\n\t\tadmin_server = $ADM\n\t}/\n\tKALI = {\n\t\tkdc = KALI\n\t\tadmin_server = KALI\n\t}/g' /etc/krb5.conf
        cat /etc/krb5.conf
        return
}

case $CMD in
        "add") addToKRB5Conf $2 $3 $4 ;;
        "remove") removeFromKRB5Conf $2 $3 $4 ;;
        "setup") echo "run \`sudo apt-get install krb5-user\' - put: KALI as default in all capitals for adding and removing a  default realm"
        *) echo $CMD " is invalid" ;;
esac
exit
```

## References

[Venn Diagram](https://en.wikipedia.org/wiki/Venn_diagram)