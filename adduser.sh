#!/bin/bash

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
    # Copy Private Key
    sudo cp /home/$username/.ssh/id_rsa  /home/$whomai/id_rsa_$username
    # Pipe  public key to authorized_keys
    # /home/mike/.ssh/id_rsa.pub
    #sudo chown -R $username:$username /home/$username/.ssh 
    echo "User $username has been created"

 fi


