#!/bin/bash
#Configured for ubuntu server 18.04
#Version 0.1

echo "Downloading scripts to configure your Secret Node."
wget "https://raw.githubusercontent.com/secretnodes/scripts/master/install-docker.sh"
wget "https://raw.githubusercontent.com/secretnodes/scripts/master/install-sgx.sh"

echo "Downloading Discovery-Docker-Network."
git clone https://github.com/enigmampc/discovery-docker-network.git

echo "<3 from https://secretnodes.org"