#!/bin/bash

base_dir=$(dirname $0)/..
source $base_dir/utils/prints.sh

home="/home/"$SUDO_USER

# verifing sudo mode
if [ $(id -u) -ne 0 ]
then
	print_red "Please run as root!"
	exit;
fi

./$base_dir/general/base-eth-install.sh

if ! command -v smartcheck > /dev/null
then
	print_blue "Installing smartcheck"
	npm install -g @smartdec/smartcheck
fi
print_green "Smartcheck installed"

