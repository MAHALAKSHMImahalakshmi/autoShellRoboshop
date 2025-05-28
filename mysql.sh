# Sources the common functions script to use shared utilities.
source ./common.sh

# Sets the application name to "mysql" for consistent logging and validation.
app_name="mysql"

# Checks if the script is being run with root privileges, exits if not.
check_root
 
# input statement for passward changing in line 20
echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD

#installing mysql-server
dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "Installing mysql-server ....."

# Enables and starts the given system service, with validation.
setup_service "$app_name"

#We need to change the default root password in order to start using the database service. Use password RoboShop@1 or any other as per your choice.
mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>$LOG_FILE
VALIDATE $? "Changing the default root password in order to start using the database service.By using password RoboShop@1"

# Prints the total execution time of the script.
print_time