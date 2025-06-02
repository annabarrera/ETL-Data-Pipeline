#!/bin/bash
#12/7/2023
#Adrianna Barrera
# Semester Project: ETL

#Logins into the srv, removes all lines with blank states or NA for states and moves the line to exceptions.csv 
ssh "$remote_usrid@$remote_srv" "awk -F ',' '{ if(\$12 == \"\" || \$12 == \"NA\") {print > \"/home/$remote_usrid/exceptions.csv\"; next} else {print}}' /home/$remote_usrid/no_header.csv > /home/$remote_usrid/$remote_file" || { echo "Unsuccessful filtering of states"; exit 1; }

echo "Successful"
