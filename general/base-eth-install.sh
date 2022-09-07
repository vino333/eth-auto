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

cd $home

print_blue "Install Ethereum Tools:"

if ! command -v python3 > /dev/null
then
	print_blue "Installing python3"
	apt-get install python3
fi
print_green "Python3 installed"

if ! command -v pip3 > /dev/null
then
	print_blue "Installing pip3"
	apt install -y python3-pip
fi
print_green "Pip3 installed"

if ! command -v curl > /dev/null
then
	print_blue "Installing curl"
	apt install -y curl
fi
print_green "Curl installed"

if ! command -v node > /dev/null
then
	print_blue "Download nodejs & npm"
	curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

	print_blue "Installing nodejs & npm"
	apt-get install -y nodejs
fi
print_green "Node & npm installed"

if ! command -v truffle > /dev/null
then
	print_blue "Installing truffle"
	npm install -g truffle
fi
print_green "Truffle installed"

if ! command -v truffle-flattener > /dev/null
then
	print_blue "Installing truffle-flattener"
	npm install -g truffle-flattener
fi
print_green "Truffle-flattener installed"

if ! command -v solc-select > /dev/null
then
	print_blue "Installing solc-select"
	pip3 install solc-select
fi
print_green "Solc-select installed"

if [ ! -d $home"/openzeppelin-contracts" ]
then
	print_blue "Cloning openzeppelin-contracts"
	git clone https://github.com/openzeppelin/openzeppelin-contracts
fi
print_green "Openzeppelin-contracts cloned"

