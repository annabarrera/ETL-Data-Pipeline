#!/bin/bash
#12/7/2023
#Adrianna Barrera
#Semester Project: ETL

# Execute a remote SSH command to generate a purchase report from a CSV file
ssh "$remote_usrid@$remote_srv" "\
#Generate the header and initial content for the purchase report
echo 'Report by: Adrianna Barrera' > /home/$remote_usrid/purchase.rpt && \
echo 'Purchase Summary Report' >> /home/$remote_usrid/purchase.rpt && \
printf '%-8s %-8s %-15s\n' 'State' 'Gender' 'Purchase Amount' >> /home/$remote_usrid/purchase.rpt && \
#Process the CSV file, filter, transform, and format the data
cut -d ',' -f12,5,6 $remote_file | grep -v '^$' | tr 'a-z' 'A-Z' | awk -F ',' '{amount=\$2; gsub(/[$]/, \"\", amount); printf \"%-8s %-8s $%-15s\\n\", \$3, \$1, sprintf(\"%.2f\", amount)}' | sort -t, -k2,2nr -k3,3 -k1,1 >> /home/$remote_usrid/purchase.rpt" || { echo "Unsuccessful purchase report generation"; exit 1; }

echo "Successfully generated purchase report"
