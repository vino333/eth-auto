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

cp -r $eth_auto"/files/smartcheck" $home
chmod 777 $home"/smartcheck"

if ! command -v smartcheck > /dev/null
then
	print_blue "Installing smartcheck"
	npm install -g @smartdec/smartcheck
fi
print_green "Smartcheck installed"

