## **1️⃣ Project Overview**  

**Title:** Linux Administration - User Management, System Monitoring, and Security  
**Author:** Ebubechukwu Ogubunka  
**Description:**  
This project automates the process of **creating users, managing permissions, monitoring system health, securing network configurations, and deploying Nginx** on a Linux server.  

Tasks:  
✔ Create and manage users  
✔ Monitor system performance   
✔ Install and configure Nginx  
✔ Secure SSH and firewall settings  

**Environment:** Kali Linux  

---

## **2️⃣ System Setup**  

Before diving into the tasks, let’s make sure our system is up-to-date and ready.  

### **Check Linux Version**  
Run the following command to see which Linux version you are using:  
```bash
lsb_release -a
```
### **Update Your System**  
Before installing any software, update your package list:  
```bash
sudo apt update && sudo apt upgrade -y
```

### **Install Required Tools**  
We'll use a few tools to help with monitoring and security. Install them by running:  
```bash
sudo apt install net-tools ufw htop -y
```
- `net-tools` → To check open network ports  
- `ufw` → Simple firewall management  
- `htop` → Real-time process monitoring  

---

## **3️⃣ User and Roles Management (Automated with a Script)**  

Your company hired **five new developers** who need access to the **development server**.  
👉 Our goal is to:  
✅ Create user accounts for them  
✅ Add them to the `developers` group  
✅ Allow them to read and execute files in `/var/www/project`, but not modify them  
✅ Restrict SSH access for two developers, so they can log in **only locally**  

---

### **👨‍💻 Script: `user_management.sh`**  

This script automates user creation and permission settings.  
```bash
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

# Restrict SSH access for frank and choice (local login only)
echo "DenyUsers frank choice" | sudo tee -a /etc/ssh/sshd_config

# Restart SSH service
sudo systemctl restart sshd

echo "User and role setup completed."
```

---
After running, you can check the users:  
```bash
cat /etc/passwd
```
[role_managent](!https://github.com/Ebube101/Linux-Administration/blob/main/screenshots/role_management.png)
---

## **4️⃣ System Monitoring & Performance Analysis**  

### **🕵️ Identifying High Resource Usage**  
If your server is **slow**, find out which process is consuming the most resources:  

```bash
top
```
or  
```bash
htop  # (If installed)
```

### **🗄️ Checking Disk Usage**  
If logs are filling up your storage, check disk usage with:  
```bash
df -h
```

### **🔍 Monitoring Logs in Real-Time**  
To find out what’s happening inside your system, monitor logs:  
```bash
sudo tail -f /var/log/syslog
```
[system_monitorig](!https://github.com/Ebube101/Linux-Administration/blob/main/screenshots/system_monitoring.png)
---

## **5️⃣ Application Management (Nginx Installation)**  

We’ll install **Nginx**, ensure it starts **automatically on boot**, and restart it if needed.

### **📥 Install & Start Nginx**  
```bash
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
```
[nginx](!https://github.com/Ebube101/Linux-Administration/blob/main/screenshots/nginx_setup.png)

### **✅ Check if Nginx is Running**  
```bash
sudo systemctl status nginx
```

### **🔄 Restart Nginx if it Crashes**  
```bash
sudo systemctl restart nginx
```

---

## **6️⃣ Networking & Security Hardening**  

Security is **critical** in Linux administration!  
Let’s **block all incoming traffic** except **SSH (port 22)** and **HTTP (port 80)**.  

### **🛡️ Set Firewall Rules**
```bash
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw enable
```
[firewall](!https://github.com/Ebube101/Linux-Administration/blob/main/screenshots/firewall.png)

### **🌍 Check Open Ports**
```bash
sudo netstat -tulnp
```

### **🔐 Setup SSH Key-Based Authentication**
Instead of using **passwords**, we’ll set up **SSH key authentication** for better security.

1. **Generate an SSH Key (on client machine):**  
   ```bash
   ssh-keygen -t rsa -b 4096
   ```
2. **Copy the Key to the Server:**  
   ```bash
   ssh-copy-id user@server_ip
   ```
3. **Disable Password Authentication (on the server):**  
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
   Find and set:  
   ```
   PasswordAuthentication no
   ```
4. **Restart SSH Service:**  
   ```bash
   sudo systemctl restart sshd
   ```
[ssh_key_gen](!https://github.com/Ebube101/Linux-Administration/blob/main/screenshots/ssh_key.png)
---

## **7️⃣ Troubleshooting & Debugging**  

### **🐞 Nginx Fails to Start?**  
```bash
sudo journalctl -xeu nginx
```
or  
```bash
sudo netstat -tulnp | grep :80
```
If Apache is running, **stop it**:  
```bash
sudo systemctl stop apache2
```
Then restart Nginx:  
```bash
sudo systemctl restart nginx
```

### **🔧 SSH Service Fails?**  
```bash
sudo systemctl status sshd
sudo journalctl -xeu ssh
```

If `/run/sshd` is missing:  
```bash
sudo mkdir -p /run/sshd
sudo systemctl restart sshd
```
---

## **9️⃣ How to Run the Scripts**
1. **Clone the repository:**
   ```bash
   git clone https://github.com/Ebube101/linux-administration.git
   cd linux-admin-project
   ```
2. **Run the user management script:**
   ```bash
   sudo ./user_management.sh
   ```
   >> To change permission <<
   ```bash
   sudo chmod +x file_name
   ```
3. **Run other commands as needed.**

