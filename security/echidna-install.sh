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

./$eth_auto/security/slither-install.sh

cp -r $eth_auto"/files/echidna" $home
chmod 777 $home"/echidna"

if [ ! -f $home"/echidna/echidna-test" ]
then
	print_blue "Downloading echidna"
	curl https://github.com/crytic/echidna/releases/download/v2.0.2/echidna-test-2.0.2-Ubuntu-18.04.tar.gz -L --output echidna.tar.gz
	tar xzf echidna.tar.gz -C $home"/echidna"
	rm echidna.tar.gz -f
fi
print_green "Echidna installed"

