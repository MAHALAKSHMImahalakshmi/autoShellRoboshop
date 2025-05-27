#!/bin/bash
START_TIME=$(date +%s)

USERID=$(id -u)
R="\e[31m"

G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

LOG_FOLDER="/var/log/roboshop-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f 1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"  
SCRIPT_DIR=$PWD #To know the current directory usefull when copy file 
mkdir -p $LOG_FOLDER

echo "Script started executing at: $(date)" | tee -a $LOG_FILE


setup_python(){

    dnf install python3 gcc python3-devel -y &>>$LOG_FILE
    VALIDATE $? "Installing python3 ......."

    cd /app 
    pip3 install -r requirements.txt &>>$LOG_FILE
    VALIDATE $? "Installing requirements ......."

}

setup_maven(){

    dnf install maven -y &>>$LOG_FILE
    VALIDATE $? "Installing maven ......"

    cd /app 
    mvn clean package &>>$LOG_FILE
    VALIDATE $? "cleaning maven package ......"

    mv target/shipping-1.0.jar shipping.jar &>>$LOG_FILE
    VALIDATE $? "Moving and renaming file from target/shipping-1.0.jar  to  shipping.jar  ......"

}

setup_systemd(){
    # Sets up systemd service by copying, reloading daemon, and validating.
    cp $SCRIPT_DIR/$app_name.service /etc/systemd/system/$app_name.service &>>$LOG_FILE
    VALIDATE $? "Copying $app_name service file to /etc/systemd dir "

    systemctl daemon-reload &>>$LOG_FILE
    VALIDATE $? "Service daemon-reloaded "


}

setup_nodejs(){
    # Installs Node.js by enabling the correct module and validating the installation.

    dnf module disable nodejs -y &>>$LOG_FILE
    VALIDATE $? "Disabling nodejs"

    dnf module enable nodejs:20 -y &>>$LOG_FILE
    VALIDATE $? "Enabling nodejs:20 version"

    dnf install nodejs -y &>>$LOG_FILE
    VALIDATE $? "Installing nodejs:20 version"

    npm install &>>$LOG_FILE
    VALIDATE $? "Installing Dependencies"

}


setup_app(){

    # Sets up the roboshop application by creating a user, preparing the directory, downloading, and extracting the application files.

    id roboshop &>>LOG_FILE
    if [ $? -ne 0 ]
    then
        useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>>$LOG_FILE
        VALIDATE $? "$B Creating roboshop system user$N"
    else
        echo -e " $B appuser already created ... $Y SKIPPING$N" 
    fi
        mkdir -p /app 
        VALIDATE $? "Creating app directory "

        curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip 
        VALIDATE $? "Downloading $app_name zip to tmp dir "

        rm -rf /app/*

        cd /app 
        unzip /tmp/catalogue.zip
        VALIDATE $? "unzipping $app_name"

        

}


setup_service(){
# Enables and starts the given system service, with validation
systemctl enable $1 &>>$LOG_FILE
VALIDATE $? "System service enable for $1"
systemctl start $1 &>>$LOG_FILE
VALIDATE $? "System service start for $1"
}


VALIDATE(){

    # Validates the success or failure of the previous command and logs the result.
    if [ $1 -ne 0 ]
    then
        echo -e " $2 is  ...$R FAILURE: $B check once using $Ycat /var/log/roboshop-logs/$app_name.log $N " | tee -a $LOG_FILE
        exit 1 #give other than 0 upto 127
    else
        echo -e  "$2 is ... $G SUCCESS $N " | tee -a $LOG_FILE
    fi
}


# check the user has root priveleges or not
check_root(){
    # Checks if the script is being run with root privileges, exits if not.
    if [ $USERID -ne 0 ]
    then
        echo -e "$R ERROR:: Please run this script with root access $N " | tee -a $LOG_FILE
        exit 1 #give other than 0 upto 127
    else
        echo -e  "You are running with $G root access $N " | tee -a $LOG_FILE
    fi
}

print_time(){
    # Calculates and prints the total time taken to execute the script.
    END_TIME=$(date +%s)
    TOTAL_TIME=$((END_TIME-START_TIME))
    echo -e "Script executed successfully, $Y Time taken: $TOTAL_TIME seconds $N"
}