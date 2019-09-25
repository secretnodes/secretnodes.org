# Deploy a Secret Node on Vultr
Guide Version 0.17 | Date Sep 22, 2019 | Pre-Genesis Games Edition
Difficulty Level : Noob Friendly!

**Estimated Time | 15 - 30 Minutes depending on experience.**

This guide will cover how to install the prerequisite software needed for your SGX compatible hardware. Once completed your Secret Node will be prepared for the Genesis Games.

> Note : This launches a devnet on SGX compatible hardware. If you complete this guide successfully then your machine can run a secret nodes. The Genesis Games have not begun yet and there is no need to run the node for anything other than testing purposes at this point in time. This note will be updated at a future date when the games have begun.

# Part 1 - Setting up your VPS.
Getting the right configuration on Vultr.

1. Sign up for an account at Vultr.com. [Help support secretnodes.org and get $50 to try Vulr by using our affiliate link.](https://www.vultr.com/?ref=8267597-4F)

2. Deploy New Instance

3. Choose Server : Bare Metal

4. Server Location : Any location near you.

5. Server Type : 64 bit OS : Ubuntu 18.04 x64

6. Disk Configuration : RAID 1

7. Server Hostname & Label : What ever you want!

# Part 2 - Enabling SGX in the BIOS

1. Select your newly created server. Hint : You can easily spot it named as the server hostname you selected in the previous step.

> Note : Take note of the password vultr sets for root on the server page.

2. Select "View Console".

3. During bootup press “Del” to get into the bios.

Navigate through the bios as follows.
*  Advanced
* Chipset Configuration
* System Agent (SA) Configuration
* Activate "SW Guard Extensions (SGX)"

Now exit and save the settings.

# Part 3 - Remote into your Secret Node

1. Get the password for your VPS from the server page.

## Windows Users
If you're using Windows 10 64-bit or newer, launch PuTTY then enter the IP address of your Secret Node into the "Host Name" field. Then click open. This will allow you to remote administrate your Secret Node from a windows machine.

If you don't already have putty then download it.
* Go to [Putty.org](https://www.putty.org/)
* Click "here" where it says "You can download PuTTY here."
* Below the "Package Files" section, see "MSI (‘Windows Installer’)" and download the most recent 64-bit version of Putty.
* Run the Installer.
* Run Putty.
* Enter the IP address of your Secret Node into the "Host Name" field. Then click open.

> NOTE: If asked to add an ECDSA fingerprint, answer yes.

## OSX & Linux Users
On OSX, or Linux open Terminal and login to your node. (Skip if using Windows.)
 This will allow you to remote administrate your Secret Node from an Apple or Linux machine.

* Open a terminal session.
```bash
ssh root@<your-nodes-ip>
```
> NOTE: (1) Be sure to replace <your-nodes-ip> with your nodes ip address. (2) If asked to add an ECDSA fingerprint, answer yes.

# Part 4 - Creating non-root User

While you have remote access to your Secret Node as the root user, create a non-root user.

1. Create a non-root User. Here we will create a user named asn, you can substitute this for anything.
```bash
USERNAME=asn
```

2. This will permission this user to access log files and sudo.
```bash
useradd -m -s /bin/bash -G adm,systemd-journal,sudo $USERNAME && passwd $USERNAME
```

3. Now exit your remote session and start a new one, this time login with the new user you created with the password you set.
```bash
ssh asn@<your-nodes-ip>
```

Going forward, when logging in use the newly created non-root user.
Next proceed to Part 5.

# Part 5 - Package Installation and Initial Configuration

Here we will download the Discovery Docker Network, scripts for configuring and installing Docker & Docker Compose, and files for installing the Intel SGX Driver. Running this one script will automate the process. Please pay attention to the notes.

```bash
wget https://raw.githubusercontent.com/secretnodes/scripts/altmethod/sendnodes.sh
```

Run the bash script.
```bash
bash sendnodes.sh
```

Notes while running the script.
1. The install-sgx.sh script will download and install all relevant SGX files and drivers.
2. The install-docker.sh script will download and install Docker & Docker Compose.
3. While running the script, respond "y" or "yes" to all prompts.
4. When prompted "Do you want to install in current directory? [yes/no]" respond with "no" then say you want to install it in the "isgx" directory.

# Part 6 - Deploy Secret Node

Running this script will start 9 enigma workers.

> Note: 9 is the max number of workers.

Run the bash script.
```bash
bash start.sh
```

Congratulations! 🎉 Your Secret Node is now prepared for the Genesis Games. Please note until the networked version of testnet is launched of the enigma network, your node will be in non-networked mode.