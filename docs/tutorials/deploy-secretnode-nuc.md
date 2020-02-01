# Deploy a Secret Node on your NUC
Guide Version 0.6- | Date Feb 1st, 2020 | Discovery Testnet Beta

!> This guide is a beta guide and could break at any time. If you are reading this, you are a brave beta tester!

!> All tokens discussed here are test tokens on the Kovan network. Do not send any real tokens using this guide! Also please understand this guide was tested on a NUC and only with the stock Ubuntu Server 18.04 LTS ISO. If you use anything else your results may differ.

**Estimated Time | 30 - 60 Minutes depending on experience.**

# Intel NUC Overview

The "Next Unit of Computing (NUC)" is a line of small-form-factor barebone computer kits designed by Intel. While [Enigma](https://enigma.co) has [partnered with Intel](https://blog.enigma.co/announcing-enigmas-collaboration-with-intel-43bbf73a86a7) to work on SGX integration, it is not a requirement that you use an Intel NUC for your Secret Node.

**Intel NUC Models Confirmed Compatible**
1. `Intel NUC 8i7BEK`, `NUC8I3BEK`, `NUC6i5SYH`, `8i5BEh4`

Secretnodes.org Recommended Models
8i3BEH, 8i5BEH, 8i7BEH.

If this guide works for you, please report which NUC you used [here](https://forum.enigma.co/c/enigma-nodes) and we'll add it to the list.

# Part 1 - Enabling SGX & Disabling Secure boot in the BIOS

1. When booting your NUC press the "F2" key.

2. Navigate to "Advanced" > "Security" > "Security Features" > "Intel Software Guard Extension (SGX)" and toggle it to "Enabled".

3. Navigate to "Advanced" > "Boot" > "Security Boot" > "Secure Boot" and uncheck the box if it's checked.

4. Press "ESC" key & save be sure to save your settings.

> If you can't find this in your bios, just search the term "SGX" or "Secure Boot".

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

# Part 4 - Package Installation and Initial Configuration

Here we will download everything required to run a secret node. That includes scripts to; install Docker, docker compose, the Intel SGX Driver, parity node software for kovan ETH node, and various other scripts to help empower you as a node runner. Please pay attention as the script runs, read any notices it posts, and respond "y" or "yes" to all prompts.

```bash
wget https://raw.githubusercontent.com/secretnodes/scripts/canary/provision.sh
```

Run the bash script.
```bash
bash provision.sh
```

# Part 5 - Deploy Secret Node

Running this script start an enimga worker.

Run the bash script.
```bash
bash eng-start.sh
```

# Part 6 - Start the cli

Leave the first script open and running then open a new terminal window and run this script in it to start the CLI.

```bash
bash eng-cli.sh
```

>Note: There is NOTHING you can do in the CLI right now. This notice will be updated when further instructions are provided by enigma.

# Part 7 - Configure and launch a Kovan ETH node.

Leave the previous scripts open and running then open a new terminal window and run this script in it to configure a koven ETH node.

```bash
bash eth-kovan.sh
```

Please report any issues on github by clicking "New Issue" [here](https://github.com/secretnodes/scripts/issues). Be sure to share any errors you are encountering. This has only been tested on an Intel NUC 8i3BEH & 8i7BEK.
