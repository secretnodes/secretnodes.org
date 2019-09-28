# Deploy a Secret Node on your NUC
Guide Version 0.33 | Date Sep 27, 2019 | Pre-Genesis Games Edition

This guide will cover how to install the prerequisite software needed for your SGX compatible NUC. Once completed your Secret Node will be prepared for the Genesis Games.

> Note: This launches a devnet on SGX compatible hardware. If you complete this guide successfully then your machine can run a Secret Node. The Genesis Games have not begun yet and there is no need to run the node for anything other than testing purposes. This note will be updated at a future date when the games have begun.

# Intel NUC Overview

The "Next Unit of Computing (NUC)" is a line of small-form-factor barebone computer kits designed by Intel. While [Enigma](https://enigma.co) has [partnered with Intel](https://blog.enigma.co/announcing-enigmas-collaboration-with-intel-43bbf73a86a7) to work on SGX integration, it is not a requirement that you use an Intel NUC for your Secret Node.

**Intel NUC Models Tested**
1. `Intel NUC 8i7BEK`

If this guide works for you, please report which NUC you used [here](https://t.me/secretnodes).

# Part 1 - Enabling SGX in the BIOS

1. When booting your NUC press the "F2" key.

2. Navigate to "Advanced" > "Security" > "Security Features" > "Intel Software Guard Extension (SGX)" and toggle it to "Enabled".

3. Press "ESC" key & save be sure to save your settings.

> If you can't find this in your bios, just search the term "SGX".

# Part 2 - Installing Ubuntu Server 18.04 LTS on the NUC
Whenever configuring a Secret Node on your NUC you'll either have to buy the unit with Ubuntu 18.04 Server preinstalled, or you'll have to install Ubuntu manually. If you're using Windows, OSX, or Linux and want general guidance on how to create a flash drive you can use to install Ubuntu, then we recommend the following.
1. First [Download Ubuntu Server 18.04 LTS ISO](https://ubuntu.com/download/server/thank-you?version=18.04.3&architecture=amd64)
2. Download and install [this tool](https://www.balena.io/etcher/) to create the bootable Ubuntu Installer.
3. Run the Etcher software.
4. In the Etcher software for the option "Select Image", Please select the Ubuntu ISO you downloaded.
5. Now in Etcher for the "Select target" option, please select the flash drive you want to turn into a bootable Ubuntu Installer.
6. Lastly, in Etcher click the "Flash" button.
7. You now have a USB bootable Ubuntu Server 18.04 Installer.

## Tell your NUC to boot from your USB drive.

If you created a USB bootable Ubuntu Installer and want to tell your NUC to boot from the newly created drive do as follows.

1. Press "F2" while booting your NUC to enter the bios.
2. Select your newly created flash drive in the "Boot Order"
3. Select "No" when asked if you want to save changes.

> If you can't find this in your bios, just search the term "boot".

# Part 3 - Remote into your Secret Node

If you wish to remotely manage your NUC from another machine while on your network, here's how you can.

2. If you're using Windows 10 64-bit or newer, launch PuTTY then enter the IP address of your Secret Node into the "Host Name" field. Then click open.

If you don't already have putty then download it.
* Go to [Putty.org](https://www.putty.org/)
* Click "here" where it says "You can download PuTTY here."
* Below the "Package Files" section, see "MSI (‘Windows Installer’)" and download the most recent 64-bit version of Putty.
* Run the Installer.
* Run Putty.
* Enter the IP address of your Secret Node into the "Host Name" field. Then click open.
* Login using the password created while installing Ubuntu.


3. On OSX, or Linux open Terminal and login to your node.

```bash
ssh root@<your-nodes-ip>
```
> NOTE: (1) Be sure to replace <your-nodes-ip> with your nodes IP address. (2) If asked to add an ECDSA fingerprint, answer yes.

# Part 4 - Creating non-root User

Create a non-root user. Here we will create a user named nsn (nuc secret node), you can substitute this for anything.
```bash
USERNAME=nsn
```

This will permission this user to access log files and sudo.
```bash
useradd -m -s /bin/bash -G adm,systemd-journal,sudo $USERNAME && passwd $USERNAME
```

Now exit your terminal session and start a new one, this time login with the new user you created with the password you set.
```bash
ssh nsn@<your-nodes-ip>
```
Next, proceed to Part 4.

> Note: Going forward, do everything with your newly created user.

# Part 5 - Package Installation and Initial Configuration

Here we will download the Discovery Docker Network, scripts for configuring and installing Docker & Docker Compose, and files for installing the Intel SGX Driver. Running this one script will automate the process. Please pay attention to the notes.

```bash
wget https://raw.githubusercontent.com/secretnodes/scripts/master/nuc-general/sendnodes.sh
```

Run the bash script.
```bash
bash sendnodes.sh
```

Notes while running the script.
1. The install-sgx.sh script will download and install all relevant SGX files and drivers.
2. The install-docker.sh script will download and install Docker & Docker Compose.
3. The install-enigma-node.sh script will download and install relevant enigma node software.
4. The Install-fixes.sh script will download relevant fixes for different devices. Report issues [here](https://t.me/secretnodes)
5. The upgrade.sh script will update the ubuntu operating system packages.
3. While running the script, respond "y" or "yes" to all prompts.
4. When prompted "Do you want to install in current directory? [yes/no]" respond with "no" then say you want to install it in the "isgx" directory.

# Part 6 - Deploy Secret Node

Running this script will start 9 enigma workers on the enigma devnet.

Run the bash script.
```bash
bash start.sh
```

Congratulations! 🎉 You are now prepared for the Genesis Games. Please note until the networked version of testnet is launched of the enigma network, there is no need to leave this node running. You now know how easy it will be to deploy on your NUC and can start again when the time comes.