# Sources the common functions script to use shared utilities.
source ./common.sh

# Sets the application name to "mongodb" for consistent logging and validation.
app_name="mongodb"

# Checks if the script is being run with root privileges.
check_root

# Copies the MongoDB repository configuration file to the YUM repositories directory.
cp $SCRIPT_DIR/mongod.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Copying mongoDB repo"

# Installs the MongoDB server package using the DNF package manager.
dnf install mongodb-org -y 
VALIDATE $? "Installing mongodb server"

# Enables and starts the MongoDB service using the setup_service function.
setup_service "mongod" 

# Modifies the MongoDB configuration file to allow remote connections by changing the bind IP.
sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf 
VALIDATE $? "Editing MongoDB conf file for remote connections"

# Restarts the MongoDB service to apply the configuration changes.
systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "Restarting MongoDB"

# Prints the total execution time of the script.
print_time