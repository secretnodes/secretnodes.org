# Deploy a Secret Node on your NUC
Guide Version 0.42 | Date Dec 22, 2019 | Discovery Testnet Beta

This guide is a beta guide and could break at any time.

> ALL ENG AND ETH IN THIS GUIDE IS REFERRING TO TEST TOKENS. DO NOT USE REAL ETH OR ENG FOR ANY OF THESE ADDRESSES. YOU WILL BE VERY SORRY IF YOU USE REAL CRYPTO HERE!!!!!

# Intel NUC Overview

The "Next Unit of Computing (NUC)" is a line of small-form-factor barebone computer kits designed by Intel. While [Enigma](https://enigma.co) has [partnered with Intel](https://blog.enigma.co/announcing-enigmas-collaboration-with-intel-43bbf73a86a7) to work on SGX integration, it is not a requirement that you use an Intel NUC for your Secret Node.

**Intel NUC Models Confirmed Compatible**
1. `Intel NUC 8i7BEK`, `NUC8I3BEK`, `NUC6i5SYH`, `8i5BEh4`

Secretnodes.org Recommended Models
8i3BEH, 8i5BEH, 8i7BEH.

If this guide works for you, please report which NUC you used [here](https://forum.enigma.co/c/enigma-nodes) and we'll add it to the list.

# Part 1 - Enabling SGX in the BIOS

1. When booting your NUC press the "F2" key.

2. Navigate to "Advanced" > "Security" > "Security Features" > "Intel Software Guard Extension (SGX)" and toggle it to "Enabled".

3. Press "ESC" key & save be sure to save your settings.

> If you can't find this in your bios, just search the term "SGX".

# Part 2 - Installing Ubuntu Server 18.04 LTS on the NUC
Whenever configuring a Secret Node on your NUC you'll either have to buy the unit with Ubuntu 18.04 Server preinstalled, or you'll have to install Ubuntu Server 18.04 LTS from Ubuntu manually. If you already have Ubuntu installed but it is not Ubuntu Server 18.04 LTS or you are unsure if it's a vinalla install then proceed with the understanding that this guide should still work but you may need to do additional work that's outside the scope of this guide. If you're using Windows, OSX, or Linux and want general guidance on how to create a flash drive you can use to install Ubuntu, then we recommend the following.
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

If you wish to remotely manage your NUC from another machine within your network, here's how you can.

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

Create a non-root user. Here we will create a user named "nsn" (nuc secret node), you can substitute this "nsn" for anything then run the below command.
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
wget https://raw.githubusercontent.com/secretnodes/scripts/master/nuc-discovery-testnet/sendnodes.sh
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
5. The upgrade.sh script will update the ubuntu operating system packages.
3. While running the script, respond "y" or "yes" to all prompts.
4. When prompted "Do you want to install in current directory? [yes/no]" respond with "no" then say you want to install it in the "isgx" directory.

# Part 6 - Deploy Secret Node

Running this script will start 9 enigma workers on the enigma devnet.

Run the bash script.
```bash
bash start.sh
```

# Part 7 - Start the cli

Running this script will start the CLI.

Run the bash script.
```bash
bash cli.sh
```

# Part 8 - From within the CLI

Once you have the CLI running do as follows.

First thing you must do is send 0.1 ETH to the "Node Ethereum Address" displayed in the CLI.

> NOTE : you must have 0.1 kETH to proceed.

```run in CLI
generate set-address
```
Save all the output as you will need it later in the guide to send a custom transaction.

```run in CLI
generate approve 1000
```
Save all the output as you will need it later in the guide to send a custom transaction.

```run in CLI
generate deposit 1000
```
Save all the output as you will need it later in the guide to send a custom transaction.

# Part 9 - From Myetherwallet.com

Go to https://www.myetherwallet.com/interface/send-transaction while on the Kovan network.

NOTE : MEW IS BUGGY SO DO THE FOLLOWING IN THIS ORDER EXACTLY.

1. For amount leave it at "0"
2. Towards the bottom of the screen there is a "Data & Gas Limit Toggle" turn this on.
3. In the "add data" field paste in the data from the output when you ran "generate set-address" in the cli.
4. In the "To Address" put in "0x8FDbB8BA27d122BE10bfA63B8F0FD2676d083e" (NOTE IF ENIGMA REDEPLOYS THIS CONTRACT WILL CHANGE)
5. At the bottom click "Send Transaction" and proceed as you normally would to finish the transaction.
6. Prepare to send a 2nd transaction.
7. In the "add data" field paste in the data from the output when you ran "generate approve 1000" in the cli.
8. In the "To Address" put in "0x8FDbB8BA27d122BE10bfA63B8F0FD2676d083e" (NOTE IF ENIGMA REDEPLOYS THIS CONTRACT WILL CHANGE)
9. At the bottom click "Send Transaction" and proceed as you normally would to finish the transaction.
10. Prepare to send a 3rd transaction.
11. In the "add data" field paste in the data from the output when you ran "generate deposit 1000" in the cli.
12. In the "To Address" put in "0x8FDbB8BA27d122BE10bfA63B8F0FD2676d083e" (NOTE IF ENIGMA REDEPLOYS THIS CONTRACT WILL CHANGE)
13. At the bottom click "Send Transaction" and proceed as you normally would to finish the transaction.

Congratulations! 🎉 You may or may not have done this successfully. If you did not, don't worry as things are still in beta. Please report any issues to me [moonstash](https://t.me/moonstash)
