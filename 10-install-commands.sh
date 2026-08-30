#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1
else
    echo "You are running with root access"
fi

dnf list installed mysql

#This part of code is running but the same code commented below is not running what might be the issue
if [ $? -ne 0 ]
then
    echo "MySQL is not installed ... going to install it"
    
    dnf install mysql -y

    if [ $? -eq 0 ]
    then 
        echo "Installing MySQL is ... SUCCESS"
    else 
        echo "Installing MySQL is ... FAILURE"
        exit 1
    fi
else
    echo "MySQL is already installed ... Nothing to do"
    # exit 0
fi

# if [ $? -eq 0 ]
# then
#     echo "MySQL is not installed ... going to install it"
#     dnf install mysql -y
#     if [ $? -eq 0 ]
#     then 
#         echo "Installing MySQL is ... SUCCESS"
#     else 
#         echo "Installing MySQL is ... FAILURE"
#         exit 1
#     fi
# else
#     echo "MySQL is already installed ... Nothing to do"
#     # exit 1
# fi

# dnf install mysql -y

# if [ $? -eq 0 ]
# then 
#     echo "Installing MySQL is ... SUCESS"
# else 
#     echo "Installing MySQL is ... FAILURE"
#     exit 1
# fi
