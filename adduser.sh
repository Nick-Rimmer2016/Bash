#!/bin/bash
# Ensure that Putty Tools Have been installed
# sudo add-apt-repository universe
# sudo apt update
# sudo apt install putty
#
# Script to Create Users
username=$1
whoami=$(whoami)
date=$(date)

echo "You are creating user ${username} and logged on as ${whoami} on  ${date}"
echo "Checking if user exists..."

 if id -u "$username" >/dev/null 2>&1; then
    echo "User $username already exists."
    exit 0
 else
    echo "User missing, will create the user $username"

    sudo useradd -m  $username
    sudo mkdir /home/$username/.ssh
    sudo touch /home/$username/.ssh/authorized_keys    

    # Create key pair
    ssh-keygen -t rsa -b 2048 -f /home/$username/.ssh/id_rsa -N ''
    # Move Private Key for download
    sudo mv /home/$username/.ssh/id_rsa  /home/$username/.ssh/id_rsa_$username
    # Pipe  public key to authorized_keys
    cat /home/$username/.ssh/id_rsa.pub >> /home/$username/.ssh/authorized_keys
    # Convert Private key to PPK for use in Putty
    puttygen /home/$username/.ssh/id_rsa_$username -o /home/$username/.ssh/$username.ppk
    # Change ownership of the .ssh folder for security
    sudo chown -R $username:$username /home/$username/.ssh 
            
    echo "User $username has been created, download the following key for the user /home/$username/.ssh/$username.ppk"

 fi


