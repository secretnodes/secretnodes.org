# How to deploy a Secret Node on Vultr
Guide Version 0.1 | Date Sep 22, 2019 | Draft

This guide will cover how to install the prerequisite software needed for your SGX compatible hardware. Once completed your Secret Node will be prepared for the Genesis Games.

# Part 1 - Setting up your VPS.
Getting the right configuration on Vultr.

1. Sign up for an account at [Vultr.com](https://www.vultr.com). [Help support secretnodes.org by using our affiliate link.](https://www.vultr.com/?ref=8255176)

2. Deploy New Instance

3. Choose Server : Bare Metal

4. Server Location : Any location near you.

5. Server Type : 64 bit OS : Ubuntu 18.04 x64

6. Disk Configuration : RAID 1

7. Server Hostname & Label : What ever you want!

## Enabling SGX in the BIOS

1. Select your newly created server. Hint : You can easily spot it named as the server hostname you selected in the previous step.

Note : Take note of the password vultr sets as root on the server page.

2. Select "View Console".

3. During bootup press “Del” to get into the bios.

Navigate through the bios as follows.
*  Advanced
* Chipset Configuration
* System Agent (SA) Configuration
* Activate "SW Guard Extensions (SGX)"

Now exit and save the settings.

# Part 2 - Remote into your Secret Node

1. Get the password for your VPS from the server page.

2. On OSX, or Linux open Terminal and login to your node. 

```bash
ssh root@"your nodes ip address without the quotes"
```

NOTE: If asked to add an ECDSA fingerprint, answer yes.

# Part 3 - Creating non-root User

Create a non-root User. Here we will create a user named asn, you can substitute this for anything.
```bash
USERNAME=asn
```

This will permission this user to access log files and sudo.
```bash
useradd -m -s /bin/bash -G adm,systemd-journal,sudo $USERNAME && passwd $USERNAME
```

# Part 4 - Package Installation and Initial Configuration

Here we will need to install Docker, Docker Compose, the Discovery Docker Network, and The Intel SGX Driver. Running this script will automate the process.

```bash
wget https://raw.githubusercontent.com/secretnodes/scripts/master/sendnodes.sh
```

Run the bash script.
```bash
sudo bash sendnodes.sh
```

## Install SGX

Download and install relevant SGX files and drivers. This is a prerequisite needed for running a Secret Node.

Run the bash script.
```bash
sudo bash install-sgx.sh
```

## Install Docker & Docker Compose

Download and install Docker & Docker Compose. This is a prerequisite needed for running a Secret Node.

Run the bash script.
```bash
sudo bash install-docker.sh
```

# Part 5 - Deploy Secret Node

Run script with max workers.

Run the bash script.
```bash
sudo bash start.sh
```