#!/bin/bash
# 12/7/2023
# Adrianna Barrera
# Semester Project: ETL

remote_srv=$1
remote_usrid=$2
remote_file=$3

#Removes header from the transaction file
ssh "$remote_usrid@$remote_srv" "tail -n +2 /home/$remote_usrid/$remote_file > /home/$remote_usrid/no_header.csv" || { echo "Unsuccessful"; exit 1; }

echo "Successful removing the header"
