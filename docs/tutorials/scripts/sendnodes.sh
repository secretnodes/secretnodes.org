#!/bin/bash
#Configured for ubuntu server 18.04
#Version 0.15 | Sep 22, 2019

echo "Downloading scripts to configure your Secret Node."
wget -O "https://raw.githubusercontent.com/secretnodes/scripts/master/install-docker.sh"
wget -O "https://raw.githubusercontent.com/secretnodes/scripts/master/install-sgx.sh"
wget -O "https://raw.githubusercontent.com/secretnodes/scripts/master/start.sh"
wget -O "https://raw.githubusercontent.com/secretnodes/scripts/master/upgrade.sh"

echo "Downloading Discovery-Docker-Network."
git pull https://github.com/enigmampc/discovery-docker-network.git
sleep 2

echo "Change permissions for scripts."
chmod u+x ~/install-sgx.sh
chmod u+x ~/install-docker.sh
chmod u+x ~/start.sh
chmod u+x ~/upgrade.sh

echo "<3 from https://secretnodes.org"