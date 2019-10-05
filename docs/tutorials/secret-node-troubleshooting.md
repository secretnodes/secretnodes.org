# Need help troubleshooting your Secret Node?

This is a resource for known issues with configuring a Secret Node from our guides.

**Ubuntu Install won't recognize my drive?**

If your NUC has an Intel NVMe drive in it, sometimes the Ubuntu Installer won't recognize it during install. This is not an issue we can directly fix but we do have a workaround. For the workaround you will need the following items 2 x USB flash drives at least 32GB each, and patience.

Steps for workaround.

1. Download this clonezilla image from clonezilla. [Clonezilla Image](https://clonezilla.org/downloads/download.php?branch=stable) for options 1-3 on the site please select amd64, iso, auto.
2. Download and install [this tool](https://www.balena.io/etcher/) to create a bootable clonezilla drive.
3. Run the Etcher software.
4. In the Etcher software for the option "Select Image", Please select the clonezilla ISO you downloaded.
5. Now in Etcher for the "Select target" option, please select the flash drive you want to turn into a bootable clonezilla drive.
6. Lastly, in Etcher click the "Flash" button.
7. You now have a USB bootable clonezilla.


Next Steps
1. With the USB ubuntu installer you created in the NUC guide, proceed to install Ubuntu Server 18.04 onto an empty USB flash drive (minimum 32GB).
2. Once Ubuntu is confirmed installed and working, boot into clonezilla from the bootable clonezilla drive you created in this guide.
3. While in clonezilla, clone the drive with ubuntu on it over to the NVMe drive on the nuc.
4. Once complete reboot the system, remove the usb drives, and it should power on into Ubunut as normal.


> Note : This guide is incomplete, it's up for a specific test and gathering feedback.

