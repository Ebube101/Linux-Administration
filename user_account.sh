#!/bin/bash

#Create a group for developers
sudo groupadd developers

# Create user accounts and add them to the developers group
for user in frank larry price choice dave; do
    sudo useradd -m -G developers $user
    echo "User $user created and added to developers group."
done

# Set permissions for /var/www/project
sudo mkdir /var/www/project
sudo chown -R root:developers /var/www/project
sudo chmod -R 750 /var/www/project  # Read & execute for group, no write permission

# Restrict SSH access for dev4 and dev5 (local login only)
echo "DenyUsers frank choice" | sudo tee -a /etc/ssh/sshd_config

# Restart SSH service
sudo systemctl restart sshd

echo "User and role setup completed."

