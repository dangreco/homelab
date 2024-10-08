#!/bin/sh

if [[ ! -f ./id_rsa ]]; then
    echo "Creating SSH key..."
    ssh-keygen -t rsa -b 4096 -C "homelab" -N "" -f ./id_rsa
fi