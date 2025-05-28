# Sources the common functions script to use shared utilities.
source ./common.sh

# Sets the application name to "rabbitmq" for consistent logging and validation.
app_name="rabbitmq"

# Checks if the script is being run with root privileges, exits if not.
check_root

# input statement for passward changing in line 20
echo "Please enter password for accessing rabbitmq"
read -s RABBITMQ_ROOT_PASSWORD

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "Adding rabbitmq repo ......"

# Installing rabbitmq server 
dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "Installing rabbitmq server ......"

# Enables and starts the given system service, with validation.
setup_service "rabbitmq-server"


#RabbitMQ comes with a default username / password as guest/guest.
#But this user cannot be used to connect. Hence, we need to create one user for the application.
rabbitmqctl add_user roboshop $RABBITMQ_ROOT_PASSWORD &>>$LOG_FILE
VALIDATE $? "Verified password ......"
#Setting permissions 
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
VALIDATE $? "ALL permissions set ......"

print_time