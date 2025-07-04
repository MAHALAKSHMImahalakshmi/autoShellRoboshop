#!/bin/bash
#  Sources the common functions script to use shared utilities.
source ./common.sh

app_name="user"

# Sets the application name to "user" for consistent logging and validation.
check_root

# Sets up the roboshop application by creating a user, preparing the directory, downloading, and extracting the application files.
setup_app


# Installs Node.js by enabling the correct module and validating the installation.
setup_nodejs

# Sets up systemd service by copying, reloading daemon, and validating.
setup_systemd


# Enables and starts the given system service, with validation.
setup_service "user" 

# Prints the total execution time of the script.
print_time