#!/bin/bash
#  Sources the common functions script to use shared utilities.
source ./common.sh

app_name="redis"

# Sets the application name to "redis" for consistent logging and validation.
check_root
# Disabling redis module 
dnf module disable redis -y
VALIDATE $? "Disabling redis module ..."

# Enabling redis module ver:7
dnf module enable redis:7 -y
VALIDATE $? "Enabling redis module ver:7 ..."

# Installing redis module ver:7
dnf install redis -y 
VALIDATE $? "Installing redis module ver:7 ..."

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "Enabling Redis"

systemctl start redis  &>>$LOG_FILE
VALIDATE $? "Started Redis"

print_time