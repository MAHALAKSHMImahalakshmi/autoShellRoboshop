# Sources the common functions script to use shared utilities.
source ./common.sh

# Sets the application name to "frontend" for consistent logging and validation.
app_name="frontend"

#Disabling of pre-verson of nodejs ,enabling and installing required version of nginx
dnf module disable nginx -y &>>$LOG_FILE
VALIDATE $? "Disabling nginx"
dnf module enable nginx:1.24 -y &>>$LOG_FILE
VALIDATE $? "enabling nginx:1.24"
dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "instaling nginx:1.24"

# Enables and starts the given system service, with validation
setup_service "nginx"

#Remove the default content that web server is serving.
rm -rf /usr/share/nginx/html/*  &>>$LOG_FILE
VALIDATE $? "Removing the default content that web server is serving." 
#Download the frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOG_FILE
VALIDATE $? "Downloding frotend code to temp dir"

#Extract the frontend content.
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "extractin ziped dir"


rm -rf /etc/nginx/nginx.conf &>>$LOG_FILE
VALIDATE $? "Remove default nginx conf"

cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "Copying nginx.conf"

#Restart Nginx Service to load the changes of the configuration.
systemctl restart nginx 
VALIDATE $? "Restarting Nginx Service to load the changes of the configuration"

print_time