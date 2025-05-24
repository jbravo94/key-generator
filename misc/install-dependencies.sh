#!/bin/bash -e

sudo apt update
sudo apt install -y openssl qrencode imagemagick zbar-tools > /dev/null

# Allow convert tool to generate PDFs
sudo sed -i 's+<policy domain="coder" rights="none" pattern="PDF" />+<policy domain="coder" rights="read|write" pattern="PDF" />+g' /etc/ImageMagick-6/policy.xml
