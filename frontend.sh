#!/bin/bash

# Load common functions and utilities
source ./common.sh

# Ensure the script is run as root
check_root

# Variables
app_name="frontend"
frontend_url="https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip"
temp_zip="/tmp/frontend.zip"
nginx_conf_path="/etc/nginx/nginx.conf"

# Step 1: Disable default Nginx module and enable the required version
dnf module disable nginx -y &>>$LOG_FILE
VALIDATE $? "Disabling Default Nginx Module"

dnf module enable nginx:1.24 -y &>>$LOG_FILE
VALIDATE $? "Enabling Nginx:1.24"

# Step 2: Install Nginx
dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "Installing Nginx"

# Step 3: Enable and start Nginx service
systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "Enabling Nginx Service"

systemctl start nginx &>>$LOG_FILE
VALIDATE $? "Starting Nginx Service"

# Step 4: Remove default Nginx content
rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
VALIDATE $? "Removing Default Content in /usr/share/nginx/html"

# Step 5: Download frontend content
curl -o $temp_zip $frontend_url &>>$LOG_FILE
if [ $? -ne 0 ]; then
    echo -e "$R Error: Failed to download frontend from $frontend_url $N" | tee -a $LOG_FILE
    exit 1
fi
VALIDATE $? "Downloading Frontend Content"

# Step 6: Extract frontend content
cd /usr/share/nginx/html
unzip $temp_zip &>>$LOG_FILE
VALIDATE $? "Extracting Frontend Content"

# Step 7: Remove default Nginx configuration
rm -rf $nginx_conf_path &>>$LOG_FILE
VALIDATE $? "Removing Default Nginx Configuration"

# Step 8: Copy custom Nginx configuration
cp $SCRIPT_DIR/nginx.conf $nginx_conf_path &>>$LOG_FILE
VALIDATE $? "Copying Custom Nginx Configuration"

# Step 9: Restart Nginx to apply changes
systemctl restart nginx &>>$LOG_FILE
VALIDATE $? "Restarting Nginx to Apply Configuration Changes"

# Step 10: Print total execution time
print_time
