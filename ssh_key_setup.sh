#!/bin/bash

# Disable password authentication
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "SSH key-based authentication setup completed."

