#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILES="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python" "nginx" "httpd")

mkdir -p $LOGS_FOLDER
echo "Script Started Executing at:: $(date)" &>>$LOG_FILES

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILES
    exit 1
else
    echo "You are running with root access" | tee -a $LOG_FILES
fi #IF I am not root → show error and stop. Otherwise → continue.

VALIDATE(){
    if [ "$1" -eq 0 ]
    then 
        echo -e "Installing $2 is ... $G SUCCESS $N" | tee -a $LOG_FILES
    else 
        echo -e "Installing $2 is ... $R FAILURE $N" | tee -a $LOG_FILES
        exit 1
    fi
}

for package in ${PACKAGE[@]}
do
    dnf list installed $package &>>$LOG_FILES
    if [ $? -ne 0 ] #$? The exit status of the most recently executed command
    then
        echo -e "$R $package is not installed $N ... $G going to install it $N" | tee -a $LOG_FILES
        dnf install $package -y &>>$LOG_FILES
        VALIDATE "$?" "$package"
    else
        echo -e "$Y $package is already installed $N ... Nothing to do" | tee -a $LOG_FILES
        # exit 0
    fi
done
#Manikantha