#!/bin/bash
# Sources the common functions script to use shared utilities.
source ./common.sh

# Sets the application name to "catalogue" for consistent logging and validation.
app_name="catalogue"

# Checks if the script is being run with root privileges, exits if not.
check_root

# Sets up the roboshop application by creating a user, preparing the directory, downloading, and extracting the application files.
setup_app 

# Installs Node.js by enabling the correct module and validating the installation.
setup_nodejs

# Sets up systemd service by copying, reloading daemon, and validating.
setup_systemd 

# Enables and starts the given system service, with validation.


systemctl enable catalogue &>>$LOG_FILE
VALIDATE $? "System service enable for catalogue"
systemctl start catalogue &>>$LOG_FILE
VALIDATE $? "System service start for catalogue"

# Copies the MongoDB repository configuration file to the YUM repositories directory.
cp $SCRIPT_DIR/mongod.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
VALIDATE $? "Copying mongoDB repo"

# Installs the MongoDB client (mongosh) and validates the installation.
dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "Installing  mongodb-client"



# Checks if the "catalogue" database exists on the MongoDB server.
STATUS=$(mongosh --host mongodb.srivenkata.shop --eval 'db.getMongo().getDBNames().indexOf("catalogue")')

# If the "catalogue" database does not exist, load the master data from the script.
if [ $STATUS -lt 0 ]
then
# Loads the master data for the list of products into the MongoDB database.
    mongosh --host mongodb.srivenkata.shop </app/db/master-data.js &>>$LOG_FILE
    VALIDATE $? "Loading Master Data of the List of products"
else
  
    # Prints a message indicating that the master data is already loaded and skips the process.
    echo -e "$B Already Loaded Master Data of the List of products ..... $Y SKIPPING $N" 


fi

# Prints the total execution time of the script.
print_time



