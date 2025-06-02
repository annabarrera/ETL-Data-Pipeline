#!/bin/bash
#12/7/2023
#Adrianna Barrera
#Semester Project: ETL

#Sorts by customerIDs
ssh "$remote_usrid@$remote_srv" "sort -t, -k1,1n /home/$remote_usrid/no_header.csv > /home/$remote_usrid/$remote_file" || { echo "Unsuccessful ID sort"; exit 1; }
echo "Successful"
