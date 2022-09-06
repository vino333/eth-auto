#!/bin/bash

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
