#!/bin/bash
#Configured for ubuntu server 18.04
#Version 0.75 | Dec 27, 2019
#Tested on 8i7BEK
#Should work for SGX compatible intel NUCs, Vultr Bare Metal, (more to come)
#Confirmed working on enigma.co testnet
#Forked from https://github.com/clcain/sgx-auto-install/

echo "- - - Installing packages - - - "
sudo apt-get install -y build-essential ocaml ocamlbuild automake autoconf libtool wget python libssl-dev
sudo apt-get install -y libssl-dev libcurl4-openssl-dev protobuf-compiler libprotobuf-dev debhelper cmake
echo

echo "- - - Cloning sgx-software-enable repository - - -"
cd ../
git clone https://github.com/intel/sgx-software-enable.git
cd sgx-software-enable/
echo

echo "- - - Making sgx-software-enable - - -"
make
echo

echo "- - - Running sgx-software-enable - - -"
sudo ./sgx_enable
echo

echo "- - - Checking SGX status - - -"
sudo ./sgx_enable --status
echo

echo "- - - Installing headers - - -"
sudo apt-get install -y linux-headers-$(uname -r)
echo

echo "- - - Cloning linux-sgx-driver repository - - -"
cd ../
git clone https://github.com/intel/linux-sgx-driver.git
cd linux-sgx-driver/
echo

echo "- - - Building SGX driver - - -"
sudo make
echo

echo "- - - Installing SGX driver - - -"
sudo mkdir -p "/lib/modules/"`uname -r`"/kernel/drivers/intel/sgx"
sudo cp isgx.ko "/lib/modules/"`uname -r`"/kernel/drivers/intel/sgx"
sudo sh -c "cat /etc/modules | grep -Fxq isgx || echo isgx >> /etc/modules"
sudo /sbin/depmod
sudo /sbin/modprobe isgx
echo

echo "SGX driver installation complete."

echo "- - - Cloning linux-sgx repository - - -"
cd ../
git clone https://github.com/intel/linux-sgx
cd linux-sgx/
git checkout sgx_2.7.1

echo "- - - Downloading binaries - - -"
./download_prebuilt.sh
echo

echo "- - - Compiling SGX SDK - - -"
make -j 4 sdk
echo

cd linux/installer/bin/

echo "- - - Building SGX SDK installer - - -"
./build-installpkg.sh sdk
echo

echo "- - - Running SGX SDK installer - - -"
echo yes | ./sgx_linux_x64_sdk_2.7.101.3.bin
if ! grep "source $PWD/sgxsdk/environment" ~/.bashrc
then
    echo "source $PWD/sgxsdk/environment" >> ~/.bashrc
fi
. ~/.bashrc
echo

cd ../../../

echo "SGX installation complete."

echo "<3 from https://secretnodes.org"
