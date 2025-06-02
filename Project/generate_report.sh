#!/bin/bash 
#12/7/2023
#Adrianna Barrera
#Semester Project: ETL

# Execute a remote SSH command to process a CSV file with AWK, generate a summary, and sort the output
ssh "$remote_usrid@$remote_srv" "awk -F, '{
    total[\$1] += \$6
    state[\$1] = \$12
    zip[\$1] = \$13
    lastname[\$1] = \$3
    firstname[\$1] = \$2
} END {
    for (customerID in total) {
        print customerID \",\" state[customerID] \",\" zip[customerID] \",\" lastname[customerID] \",\" firstname[customerID] \",\" total[customerID]
    }
}' /home/$remote_usrid/$remote_file | sort -t, -k2,2nr -k1,1 > /home/$remote_usrid/summary.csv" || { echo "Unsuccessful summary report"; exit 1; }

# If the command is successful, print a success message
echo "Successful summary report"
