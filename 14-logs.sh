#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILES="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER # -p creates the directory if it doesn't exist and doesn't throw an error if it already exists.
echo "Script Started Executing at:: $(date)" &>>$LOG_FILES # &>> adds both normal output and error messages to the log file without overwriting it.

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

dnf list installed mysql &>>$LOG_FILES

if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo -e "$R MySQL is not installed $N ... $G going to install it $N" | tee -a $LOG_FILES
    dnf install mysql -y &>>$LOG_FILES
    VALIDATE "$?" "MySQL"
else
    echo -e "$Y MySQL is already installed $N ... Nothing to do" | tee -a $LOG_FILES
    # exit 0
fi

dnf list installed nginx &>>$LOG_FILES
if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo -e "$R nginx is not installed $N ... $G going to install it $N" | tee -a $LOG_FILES
    dnf install nginx -y &>>$LOG_FILES
    VALIDATE "$?" "ngnix"
else
    echo -e "$Y nginx is already installed $N ... Nothing to do" | tee -a $LOG_FILES
    # exit 0
fi

dnf list installed python3 &>>$LOG_FILES
if [ $? -ne 0 ] #$? The exit status of the most recently executed command
then
    echo -e "$R python3 is not installed $N ... $G going to install it $N" | tee -a $LOG_FILES
    dnf install python3 -y &>>$LOG_FILES
    VALIDATE "$?" "python3"
else
    echo -e "$Y python3 is already installed $N ... Nothing to do" | tee -a $LOG_FILES
    # exit 0
fi
#Manikantha