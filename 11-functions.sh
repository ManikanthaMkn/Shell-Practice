#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1
else
    echo "You are running with root access"
fi #IF I am not root → show error and stop. Otherwise → continue.

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
        echo "Installing $2 is ... SUCCESS"
    else 
        echo "Installing $2 is ... FAILURE"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo "MySQL is not installed ... going to install it"
    
    dnf install mysql -y

    VALIDATE $? "MySQL"
else
    echo "MySQL is already installed ... Nothing to do"
    # exit 0
fi

if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo "nginx is not installed ... going to install it"
    
    dnf install nginx -y

    VALIDATE $? "ngnix"
else
    echo "nginx is already installed ... Nothing to do"
    # exit 0
fi

if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo "python3 is not installed ... going to install it"
    
    dnf install python3 -y

    VALIDATE $? "python3"
else
    echo "python3 is already installed ... Nothing to do"
    # exit 0
fi