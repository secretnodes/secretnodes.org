# Deploy a Secret Node on Vultr
Guide Version 0.25 | Date Dec 27, 2019 | Pre-Genesis Games Edition
Difficulty Level : Noob Friendly!

> If you've configured your node with a previous version of this guide please run the following command to refresh the scripts on your node. You should only need to run this once. "wget -N https://raw.githubusercontent.com/secretnodes/scripts/master/refresh-scripts.sh" then proceed from step 6 on this guide.

**Estimated Time | 15 - 30 Minutes depending on experience.**

This guide will cover how to install the prerequisite software needed for your SGX compatible hardware. Once completed your Secret Node will be prepared for the Genesis Games.

> Note : This launches a devnet on SGX compatible hardware. If you complete this guide successfully then your machine can run a secret nodes. The Genesis Games have not begun yet and there is no need to run the node for anything other than testing purposes at this point in time. This note will be updated at a future date when the games have begun.

> Note: Please understand that the support secretnodes.org offers is community driven and volunteer based. Ultimately you are responsible for keeping your Secret Node running.

# Part 1 - Setting up your VPS.
Getting the right configuration on Vultr.

1. Sign up for an account at Vultr.com.

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

First get the password for your VPS from the server page.

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

# Part 5 - Package Installation and Initial Configuration

Here we will download the Discovery Docker Network, scripts for configuring and installing Docker & Docker Compose, and files for installing the Intel SGX Driver. Running this one script will automate the process. Please pay attention to the notes.

```bash
wget -N https://raw.githubusercontent.com/secretnodes/scripts/master/sendnodes.sh
```

Run the bash script.
```bash
bash sendnodes.sh
```

Notes while running the script.
1. The install-sgx.sh script will download and install all relevant SGX files and drivers.
2. The install-docker.sh script will download and install Docker & Docker Compose.
3. The install-enigma-node.sh script will download and install relevant enigma node software.
4. The Install-fixes.sh script will download relevant fixes for different devices. Report issues [here](https://forum.enigma.co/c/enigma-nodes)
5. The cli.sh script merely launches the CLI.
6. The upgrade.sh script will update the ubuntu operating system packages.
7. While running the script, respond "y" or "yes" to all prompts.
8. When prompted "Do you want to install in current directory? [yes/no]" respond with "no" then say you want to install it in the "isgx" directory.

# Part 6 - Deploy Secret Node

Running this script start an enimga worker. It will also make sure the enigma node software is up to date.

Run the bash script.
```bash
bash start.sh
```

# Part 7 - Start the cli

Leave the first open and running then open a new terminal window and run this script in it to start the CLI.

```bash
bash cli.sh
```

# Part 8 - From within the CLI

Note: If you do not have test ENG then you cannot proceed past this point successfully. Test ENG has not been widely distributed yet and enigma will do so at a future date. This notice will be updated once that happens.

Please report any issues in a new thread [here](https://forum.enigma.co/c/enigma-nodes). Please do not ask for CLI support at this time.
