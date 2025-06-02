#!/bin/bash
# Adrianna Barrera
# 12/7/2023
# Semester Project: ETL

remote_srv=$1
remote_usrid=$2
remote_file=$3

#Unzips file on the srv
ssh "$remote_usrid@$remote_srv" "bunzip2 /home/$remote_usrid/$remote_file" || { echo "Unsuccessful"; exit 1; }
echo "Successful"
