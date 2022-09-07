#!/bin/bash

eth_auto=$(dirname $0)/..
source $eth_auto/utils/prints.sh

home="/home/"$SUDO_USER

# verifing sudo mode
if [ $(id -u) -ne 0 ]
then
	print_red "Please run as root!"
	exit;
fi

./$eth_auto/general/base-eth-install.sh

cp -r $eth_auto"/files/slither" $home
chmod 777 $home"/slither"

if ! command -v slither > /dev/null
then
	print_blue "Installing slither"
	cd $home"/slither"
	git clone https://github.com/crytic/slither.git
	cd slither
	python3 setup.py install
	cd ..
	rm -rf slither
	cd $home
fi
print_green "Slither installed"

