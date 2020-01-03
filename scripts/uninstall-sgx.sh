#!/bin/bash
#Configured for ubuntu server 18.04
#Version 0.75 | Dec 27, 2019
#Tested on 8i7BEK
#Should work for SGX compatible intel NUCs, Vultr Bare Metal, (more to come)
#Confirmed working on enigma.co testnet
#Forked from https://github.com/clcain/sgx-auto-install/

echo $(date -u) "Uninstalling the SGX Driver." >> sendlogs.txt
rm -rf ../sgx-software-enable

cd ../linux-sgx-driver/

echo "- - - Uninstalling SGX driver - - -"
sudo /sbin/modprobe -r isgx
sudo rm -rf "/lib/modules/"`uname -r`"/kernel/drivers/intel/sgx"
sudo /sbin/depmod
sudo /bin/sed -i '/^isgx$/d' /etc/modules
echo

echo "- - - Removing linux-sgx-driver repository - - -"
cd ../
sudo rm -rf linux-sgx-driver/
echo

echo "SGX driver uninstalled."

echo "- - - Uninstalling SGX PSW - - -"
sudo /opt/intel/sgxpsw/uninstall.sh
echo

echo $(date -u) "SGX should now be successfully removed." >> sendlogs.txt
echo "<3 from https://secretnodes.org"
