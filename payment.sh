#!/bin/bash
# Sources the common functions script to use shared utilities.
source ./common.sh

# Sets the application name to "payment" for consistent logging and validation.
app_name="payment"

# Checks if the script is being run with root privileges, exits if not.
check_root

# Sets up the roboshop application by creating a user, preparing the directory, downloading, and extracting the application files.
setup_app


# Installs python by enabling the correct module and validating the installation.
setup_python

# Sets up systemd service by copying, reloading daemon, and validating.
setup_systemd 

# Enables and starts the given system service, with validation.
setup_service "$app_name"
