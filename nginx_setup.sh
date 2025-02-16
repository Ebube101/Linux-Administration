#!/bin/bash

# Install Nginx
sudo apt update
sudo apt-get install nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Start Nginx
sudo systemctl start nginx

# Check if Nginx is running
sudo systemctl status nginx --no-pager

echo "Nginx setup completed."

