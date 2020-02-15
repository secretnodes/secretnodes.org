# Prepare your host machine to run a full node on EnigmaChain
Guide Version 0.05 | Date Feb 15, 2020

# Installing Ubuntu Server 18.04 LTS
The first step to configuring a Secret Node is making sure your hardware or VPS is running Ubuntu Server 18.04 LTS. If you already have Ubuntu installed but it is not Ubuntu Server 18.04 LTS or you are unsure if it's a vinalla install then proceed with the understanding that this guide should still work but you may need to do additional work that's outside the scope of this guide. If you're using Windows, OSX, or Linux and want general guidance on how to create a flash drive you can use to install Ubuntu, then we recommend the following.
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
