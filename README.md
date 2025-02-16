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
🔹 It creates a **developers** group.  
🔹 It adds users to that group.  
🔹 It sets the correct permissions on `/var/www/project`.  
🔹 It blocks **SSH access** for two users.  

```bash
#!/bin/bash

echo "📢 Setting up user accounts..."

# Create a group for developers
sudo groupadd developers

# List of new users
users=("dev1" "dev2" "dev3" "dev4" "dev5")

# Loop through each user and create them
for user in "${users[@]}"; do
    sudo useradd -m -G developers "$user"
    echo "$user:password123" | sudo chpasswd
    echo "✅ Created user: $user"
done

# Ensure project directory exists
sudo mkdir -p /var/www/project
sudo chown root:developers /var/www/project
sudo chmod 750 /var/www/project  # Read & Execute for developers, no write

# Restrict SSH access for dev4 and dev5
echo "DenyUsers dev4 dev5" | sudo tee -a /etc/ssh/sshd_config

# Restart SSH service to apply changes
sudo systemctl restart sshd

echo "🎉 User management setup complete!"
```

---

### **How to Run the Script**
1. Copy the script into a file:  
   ```bash
   nano user_management.sh
   ```
2. Paste the script and save (CTRL+X → Y → Enter).  
3. Give the script **execute** permission:  
   ```bash
   chmod +x user_management.sh
   ```
4. Run the script:  
   ```bash
   sudo ./user_management.sh
   ```

After running, you can check the users:  
```bash
cat /etc/passwd | grep dev
```

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

---

## **5️⃣ Application Management (Nginx Installation)**  

We’ll install **Nginx**, ensure it starts **automatically on boot**, and restart it if needed.

### **📥 Install & Start Nginx**  
```bash
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
```

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

## **8️⃣ Screenshots (Optional)**
If possible, **include screenshots** of commands and outputs.

---

## **9️⃣ How to Run the Scripts**
1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourgithub/linux-admin-project.git
   cd linux-admin-project
   ```
2. **Run the user management script:**
   ```bash
   sudo ./user_management.sh
   ```
3. **Run other commands as needed.**

---

## **🔟 License & Credits**
📜 **License:** MIT  
👤 **Author:** [Your Name]  
📧 **Contact:** [Your Email]  

---

🚀 **This documentation is beginner-friendly and ready to be published on GitHub!** 🚀  
Let me know if you need changes. 😃
