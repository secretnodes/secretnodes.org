#!/bin/bash
#Configured for ubuntu server 18.04

echo "===> Running step 1"
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

echo "===> Running step 2"
sudo chmod +x /usr/local/bin/docker-compose

echo "===> Running Step 4"
sudo apt update

echo "===> install prerequisite packages which let apt use packages over HTTPS"
sudo apt install apt-transport-https ca-certificates curl software-properties-common

echo "===> Add the GPG key for the official Docker repository to your system"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "===> Add the Docker repository to APT sources"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

echo "===> update the package database with the Docker packages from the newly added repo"
sudo apt update
sudo apt upgrade

echo "===>  install from the Docker repo instead of the default Ubuntu repo"
apt-cache policy docker-ce

echo "===> Install Docker"
sudo apt install docker-ce

echo "===> Verify Docker Compose installation was successful."
echo "===> type : docker-compose --version"
echo "===> Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it’s running"
echo "===> type : sudo systemctl status docker"
echo "<3 from https://secretnodes.org"