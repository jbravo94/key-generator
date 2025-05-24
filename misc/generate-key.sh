#!/bin/bash -e

read -p "Enter passphrase: " PASSWORD
openssl genrsa -aes256 -passout pass:$PASSWORD -out private.key 2048
openssl rsa -in private.key -passin pass:$PASSWORD -pubout -out public.key
