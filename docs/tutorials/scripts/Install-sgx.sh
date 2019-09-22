    #!/bin/bash
    #Tested on ubuntu server 18.04
    #Version 0.1

    echo "apt-get dpkg & update"
    sudo apt-get update
    sleep 5
    sudo apt install dpkg

    echo "To install the Intel® SGX PSW, first install the following tools"
    sudo apt-get install libssl-dev libcurl4-openssl-dev libprotobuf-dev

    echo "To install the Intel® SGX SDK, install the following:"
    sudo apt-get install build-essential python

    echo "Downloading the required SGX files."
    wget "https://download.01.org/intel-sgx/linux-2.6/ubuntu18.04-server/libsgx-enclave-common-dev_2.6.100.51363-bionic1_amd64.deb"
    sleep 2
    wget "https://download.01.org/intel-sgx/linux-2.6/ubuntu18.04-server/libsgx-enclave-common_2.6.100.51363-bionic1_amd64.deb"
    sleep 2
    wget "https://download.01.org/intel-sgx/linux-2.6/ubuntu18.04-server/sgx_linux_x64_driver_2.5.0_2605efa.bin"
    sleep 2
    wget "https://download.01.org/intel-sgx/linux-2.6/ubuntu18.04-server/sgx_linux_x64_sdk_2.6.100.51363.bin"

    echo "Setting permissions for driver & SDK."
    chmod +x ./sgx_linux_x64_driver_2.5.0_2605efa.bin
    sleep 2
    chmod +x ./sgx_linux_x64_sdk_2.6.100.51363.bin
    sleep 1

    echo "Installing SGX driver."
    sudo ./sgx_linux_x64_driver_2.5.0_2605efa.bin
    sleep 4

    echo "Installing psw"
    sudo dpkg -i ./libsgx-enclave-common_2.6.100.51363-bionic1_amd64.deb
    sleep 2
    sudo dpkg -i ./libsgx-enclave-common-dev_2.6.100.51363-bionic1_amd64.deb
    sleep 1

    echo "===> Running step 7 - installing sdk"
    sudo ./sgx_linux_x64_sdk_2.6.100.51363.bin
    sleep 2

    echo "===> Installed SGX on Linux. Chose to install SGX in current directory, respond with 'yes'."
    echo "Setting LD LIBRARY PATH"
    echo "<3 from https://secretnodes.org"
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib