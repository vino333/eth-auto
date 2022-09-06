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
	print_blue "Install python3"
	apt-get install python3
fi
print_green "Python3 installed"

if ! command -v pip3 > /dev/null
then
	print_blue "Install pip3"
	apt install -y python3-pip
fi
print_green "Pip3 installed"

if ! command -v curl > /dev/null
then
	print_blue "Install curl"
	apt install -y curl
fi
print_green "Curl installed"

if ! command -v node > /dev/null
then
	print_blue "Download nodejs & npm"
	curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

	print_blue "Install nodejs & npm"
	apt-get install -y nodejs
fi
print_green "Node & npm installed"

if ! command -v truffle > /dev/null
then
	print_blue "Install truffle"
	npm install -g truffle
fi
print_green "Truffle installed"

if ! command -v truffle-flattener > /dev/null
then
	print_blue "Install truffle-flattener"
	npm install -g truffle-flattener
fi
print_green "Truffle-flattener installed"

if ! command -v slither > /dev/null
then
	print_blue "Install slither"
	git clone https://github.com/crytic/slither.git
	cd slither
	python3 setup.py install
	cd ..
fi
print_green "Slither installed"

if ! command -v solc-select > /dev/null
then
	print_blue "Install solc-select"
	pip3 install solc-select
	fi
print_green "Solc-select installed"

if ! [ -f "~/echidna-test" ]
then
	print_blue "Install echidna"
	curl https://github.com/crytic/echidna/releases/download/v2.0.2/echidna-test-2.0.2-Ubuntu-18.04.tar.gz -L --output echidna.tar.gz
	tar xvzf echidna.tar.gz
fi
print_green "Echidna installed"

print_blue "Echidna Machine Installation Completed!"
