#!/bin/bash
#12/7/2023
#Adrianna Barrera
#Semester Project: ETL 

remote_srv=$1
remote_usrid=$2
remote_file=$3

#Converts all text to lower case
ssh "$remote_usrid@$remote_srv" "tr [:upper:] [:lower:] < /home/$remote_usrid/no_header.csv > /home/$remote_usrid/$remote_file" || { echo "Unsuccessful"; exit 1; }
echo "Successful converting to lowercase"
