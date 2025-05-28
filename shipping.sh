# Sources the common functions script to use shared utilities.
source ./common.sh

# Sets the application name to "rabbitmq" for consistent logging and validation.
app_name="shipping"

# Checks if the script is being run with root privileges, exits if not.
check_root
echo "Enter mysql root password"
read -s MYSQL_ROOT_PASSWORD

# Sets up the roboshop application by creating a user, preparing the directory, downloading, and extracting the application files.
setup_app

# Installs maven by enabling the correct module and validating the installation.
setup_maven

# Sets up systemd service by copying, reloading daemon, and validating.
setup_systemd 

# Enables and starts the given system service, with validation.
setup_service "shipping"

#Installing mysql 
dnf install mysql -y 
VALIDATE $? "Installing mysql ......"

mysql -h mysql.srivenkata.shop -u root -p$MYSQL_ROOT_PASSWORD -e 'use cities' &>>$LOG_FILE

if [ $? -ne 0 ]
then

    mysql -h mysql.srivenkata.shop -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/schema.sql &>>$LOG_FILE
    mysql -h mysql.srivenkata.shop -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/app-user.sql  &>>$LOG_FILE
    mysql -h mysql.srivenkata.shop -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/master-data.sql &>>$LOG_FILE
    VALIDATE $? "Loading data into MySQL"
else
    echo -e "Data is already loaded into MySQL ... $Y SKIPPING $N"
fi

systemctl restart shipping &>>$LOG_FILE
VALIDATE $? "Restart shipping"

print_time