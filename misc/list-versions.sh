#!/bin/bash -e

echo "> Kernel"
uname -r

echo -e "\n> Operating System"
lsb_release -d | cut -f 2

echo -e "\n> Packages"
apt-cache policy openssl qrencode imagemagick zbar-tools | grep -E "^(\w|\s+Installed)"
