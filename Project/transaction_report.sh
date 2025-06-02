#!/bin/bash 
#12/7/2023
#Adrianna Barrera
#Semester Project: ETL

# Execute a remote SSH command to generate a transaction report from a CSV file
ssh "$remote_usrid@$remote_srv" "\
echo 'Report by: Adrianna Barrera' > /home/$remote_usrid/transaction.rpt && \
echo 'Transaction Count Report' >> /home/$remote_usrid/transaction.rpt && \
printf '%-25s %-25s\n' 'State' 'Transaction Count' >> /home/$remote_usrid/transaction.rpt && \
cut -d ',' -f12 $remote_file | grep -v '^$' | tr 'a-z' 'A-Z' | sort | uniq -c | sort -nr | awk '{printf \"%-25s %-25s\\n\", \$2, \$1}' >> /home/$remote_usrid/transaction.rpt" || { echo "Unsuccessful transaction report"; exit 1; }

echo "Successful transaction report"
