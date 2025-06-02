#!/bin/bash
#12/7/2023
#Adrianna Barrera
#Semester Project: ETL

# Execute a remote SSH command to remove the '$' sign from the specified CSV file
ssh "$remote_usrid@$remote_srv" "tr -d '$' < /home/$remote_usrid/$remote_file > /home/$remote_usrid/no_header.csv" || { echo "Unsuccessful removing $ sign"; exit 1; }
echo "Successful"
