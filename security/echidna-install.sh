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

./$base_dir/security/slither-install.sh

if [ ! -f $home"/echidna-test" ]
then
	print_blue "Downloading echidna"
	curl https://github.com/crytic/echidna/releases/download/v2.0.2/echidna-test-2.0.2-Ubuntu-18.04.tar.gz -L --output echidna.tar.gz
	tar xzf echidna.tar.gz -C $home
	rm echidna.tar.gz -f
fi
print_green "Echidna installed"

print_blue "Echidna Machine Installation Completed!"

