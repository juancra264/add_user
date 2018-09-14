#!/bin/bash
# Script to add a user to the system

#default password
password="BT.l4t4m"

if [ $(id -u) -eq 0 ]; then
    read -p "Username : " username
    #read -s -p "Enter password : " password
    egrep "^$username" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        echo "$username exists, please check"
        exit 1
    else
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
        useradd -m -p $pass -s /bin/bash  $username
        # Force the user to change password at the next logon
        passwd -e $username
        [ $? -eq 0 ] && echo -e "User has been added..\r\n\n\tDefault password: BT.l4t4m\n\nThe user should change it after first logon" || echo "Failed to add a user!"
    fi
else
    echo "Only root or suders may add a user to the system"
    exit 2
fi
