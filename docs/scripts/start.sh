#!/bin/bash
#Configured for ubuntu server 18.04
#Version 0.75 | Dec 27, 2019
#Tested on 8i7BEK
#Should work for SGX compatible intel NUCs, Vultr Bare Metal, (more to come)
#Confirmed working on enigma.co testnet

echo $(date -u) "Launch discovery testnet worker." >> sendlogs.txt
cd discovery-testnet
sleep 1
sudo docker-compose up
sleep 1

echo $(date -u) "Next launch the command-line interface (CLI) for your node" >> sendlogs.txt
echo "by opening a new terminal window and running cli.sh"
