#!/bin/bash
#Configured for ubuntu server 18.04
#Version 0.75 | Dec 27, 2019
#Tested on 8i7BEK
#Should work for SGX compatible intel NUCs, Vultr Bare Metal, (more to come)
#Confirmed working on enigma.co testnet

echo $(date -u) "Updating enigma node software." >> sendlogs.txt
echo "Discovery Testnet Beta."
docker pull enigmampc/external_worker_hw:testnet >> sendlogs.txt
sleep 1
