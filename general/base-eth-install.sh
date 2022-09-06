#!/bin/bash

path=$(pwd)

RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

print_color() {
	echo -e $@$NC
}
print_blue() {
	print_color $BLUE$@
}
print_red() {
	print_color $RED$@
}
print_green() {
	print_color $GREEN$@
}

# verifing sudo mode
if [ $(id -u) -ne 0 ]
then
	print_red "Please run as root!"
	exit;
fi

cd $path

print_blue "Install Echidna Machine:"

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

