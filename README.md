# 🤖 autoShellRoboshop – Next-Gen Roboshop Automation 🚀

Welcome to my **autoShellRoboshop** project!  
This repo is my upgraded journey in automating the Roboshop microservices e-commerce app for the IBM project, now with **super-efficient scripting** and **modular code**.  
I’ve reduced code duplication, improved maintainability, and made debugging a breeze – all skills that make me a strong DevOps/Cloud Engineer candidate! 💼✨

---

## 🌟 What’s New & Better?

- **🧩 Modular Scripting:** All repeated logic is now in `common.sh` – less code, fewer bugs, easier updates!
- **📝 Cleaner Scripts:** Each service script is short, readable, and focused on just the unique steps.
- **⚡ Faster Debugging:** Centralized logging and validation functions.
- **📉 Reduced Lines:** Compare with my [old Roboshop repo](https://github.com/MAHALAKSHMImahalakshmi/roboshop.git) – you’ll see the difference!
- **🎨 Easy to Maintain:** Update one place, affect all scripts.

---

## 📁 Folder Structure & File Descriptions

| File/Script         | Description                                                                                   |
|---------------------|----------------------------------------------------------------------------------------------|
| `common.sh`         | 🧠 **The brain of automation!** Contains reusable functions for logging, validation, user checks, app setup, service management, and more. All other scripts source this file for efficiency. |
| `cart.sh`           | 🛒 Sets up the Cart service. Calls `common.sh` for user creation, app download, Node.js install, and service setup. |
| `catalogue.sh`      | 📦 Sets up the Catalogue service. Uses `common.sh` for MongoDB client, app setup, and service management. |
| `user.sh`           | 👤 Sets up the User service. Leverages `common.sh` for Node.js, app, and service setup.      |
| `shipping.sh`       | 🚚 Sets up the Shipping service. Uses `common.sh` for Maven/Java, MySQL client, app, and service. |
| `payment.sh`        | 💳 Sets up the Payment service. Uses `common.sh` for Python, app, and service setup.         |
| `frontend.sh`       | 🎨 Automates Nginx frontend setup. Uses `common.sh` for Nginx install, config, and service.  |
| `mongodb.sh`        | 🍃 Sets up MongoDB server. Uses `common.sh` for repo, install, config, and service.          |
| `mysql.sh`          | 🐬 Sets up MySQL server. Uses `common.sh` for install, root password, and service.           |
| `redis.sh`          | 🟥 Sets up Redis server. Uses `common.sh` for install, config, and service.                  |
| `rabbitmq.sh`       | 🐇 Sets up RabbitMQ server. Uses `common.sh` for repo, install, user, and service.           |
| `roboshop.sh`       | ☁️ Provisions AWS EC2 instances and updates Route 53 DNS for all services.                   |
| `*.service`         | ⚙️ Systemd service files for each microservice.                                              |
| `nginx.conf`        | 🔁 Nginx reverse proxy config for frontend.                                                   |
| `mongo.repo`/`rabbitmq.repo` | 📦 YUM repo configs for MongoDB and RabbitMQ.                                       |

---

## 🧠 How `common.sh` Makes Everything Efficient

- **Centralized Functions:**  
  - `check_root`: Ensures scripts run as root.
  - `VALIDATE`: Logs success/failure of each step.
  - `setup_app`: Handles user creation, app download, and extraction.
  - `setup_nodejs`, `setup_python`, `setup_maven`: Language-specific installs.
  - `setup_systemd`, `setup_service`: Service management.
  - `print_time`: Shows script execution time.
- **Result:**  
  - All service scripts are now just a few lines, calling these functions!
  - Any update (like better logging) is made once in `common.sh` and benefits all scripts.
  - **Less code, fewer mistakes, easier onboarding for new team members!**

---

## 🆚 Comparison: Old vs New

| Aspect         | Old Roboshop Repo ([link](https://github.com/your-old-roboshop-link)) | autoShellRoboshop (This Repo) |
|----------------|:---------------------------------------------------------------------:|:-----------------------------:|
| Code Duplication | ❌ High (same logic in every script)                                | ✅ Minimal (all in `common.sh`)|
| Maintenance     | ❌ Tedious, error-prone                                               | ✅ Easy, one place to update   |
| Debugging       | ❌ Scattered, inconsistent logs                                       | ✅ Centralized, clear logs     |
| Script Length   | ❌ Long, repetitive                                                   | ✅ Short, readable             |
| Professionalism | ❌ Basic scripting                                                    | ✅ Modular, real-world ready   |

---

## 🖼️ How to Add Images to Your README

Want to show off your project visually? Here’s how:

1. **Move your image** to an `images/` folder in your repo.
2. **Commit the image**:
   ```bash
   git add images/your-image.png
   git commit -m "Add image for README"
   git push
   ```
3. **Reference in README**:
   ```markdown
   ![Alt Text](images/your-image.png)
   ```
4. **Check on GitHub** to make sure it displays!

---

## 🛠️ Debugging & Troubleshooting Tips

- **Common Mistakes I Made (and Fixed!):**
  - Forgot to update IP in Route 53 after EC2 restart ➡️ Use `nslookup` to verify DNS.
  - Missed updating backend IPs in `nginx.conf` for reverse proxy ➡️ Always check and reload Nginx.
  - Forgot to restart services after config changes ➡️ Always run `systemctl restart <service>`.
- **Handy Commands:**
  - `netstat -lntp` – See which ports are open and which process is using them.
  - `telnet <domain/ip> <port>` – Test if a service is reachable.
  - `nslookup <domain>` – Check DNS resolution.
  - `systemctl status <service>` – Check service health.
- **Pro Tip:**  
  Centralized logging in `common.sh` means you can always check `/var/log/roboshop-logs/<service>.log` for errors!

---

## ☁️ Steps to Create AWS EC2 Instances

1. Login to AWS Console → EC2 Dashboard.
2. Launch Instance (Amazon Linux 2/Ubuntu).
3. Configure details, storage, tags (e.g., `roboshop-cart`).
4. Open required ports in Security Group.
5. Launch and associate Elastic IP (optional).
6. Update Route 53 DNS to point to your instance.

---

## 🎉 Why This Project Makes Me Job-Ready

- **Real-world DevOps skills:** Modular scripting, cloud automation, systemd, logging, debugging.
- **Team-friendly:** Easy for others to read, extend, and maintain.
- **Cloud-native:** AWS provisioning and DNS automation.
- **Continuous improvement:** I learned from my old repo and made this one better!

---

## 🔗 Previous Roboshop Repo

Check out my original, more verbose version here:  
[Old Roboshop GitHub Repo](https://github.com/MAHALAKSHMImahalakshmi/roboshop.git)

---

## 🙌 Thanks for Visiting!

If you like my work or want to collaborate, connect with me!  
**Happy Automating!** 🚀

---

> “The best code is the code you never have to write twice.” – Me, after refactoring with `common.sh` 😄
