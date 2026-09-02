#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N"
    exit 1
else
    echo "You are running with root access"
fi #IF I am not root → show error and stop. Otherwise → continue.

VALIDATE(){
    if [ "$1" -eq 0 ]
    then 
        echo -e "Installing $2 is ... $G SUCCESS $N"
    else 
        echo -e "Installing $2 is ... $R FAILURE $N"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo -e "$R MySQL is not installed $N ... $G going to install it $N"
    
    dnf install mysql -y

    VALIDATE "$?" "MySQL"
else
    echo -e "$Y MySQL is already installed $N ... Nothing to do"
    # exit 0
fi

dnf list installed nginx
if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo "nginx is not installed ... going to install it"
    
    dnf install nginx -y

    VALIDATE "$?" "ngnix"
else
    echo -e "$Y nginx is already installed $N ... Nothing to do"
    # exit 0
fi

dnf list installed python3
if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo "python3 is not installed ... going to install it"
    
    dnf install python3 -y

    VALIDATE "$?" "python3"
else
    echo -e "$Y python3 is already installed $N ... Nothing to do"
    # exit 0
fi
#Manikantha