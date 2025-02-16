#!/bin/bash

# Allow SSH (22) and HTTP (80)
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp

# Deny all other incoming traffic
sudo ufw default deny incoming

# Enable UFW firewall
sudo ufw enable

echo "Firewall rules configured."

#check open port
sudo netstat -tulnp

