#!/bin/bash
#12/7/2023
#Adrianna Barrera
#Semester Project


#Checks if the correct num of parameters are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <remote-srv> <remote-usrid> <remote-file>" 
    exit 1
fi

#Creates variables for the args
declare -x remote_srv=$1
declare -x remote_usrid=$2
declare -x remote_file=$3

echo "Transferring file..."
#Transfers the file 
source transfer_file.sh $remote_srv $remote_usrid $remote_file 

echo "Unzipping file..."
#Unzips the file 
./unzip_file.sh $remote_srv $remote_usrid $remote_file

remote_file=${remote_file%.bz2}

ssh "$remote_usrid@$remote_srv" "mv /home/$remote_usrid/$remote_file /home/$remote_usrid/transaction.csv" 
remote_file=transaction.csv

#Removes the header record from the transaction file
echo "Removing header..."
./remove_header.sh $remote_srv $remote_usrid $remote_file

#Converts tolower
echo "Converting file to lower"
./tolower.sh $remote_srv $remote_usrid $remote_file

#Converts the gender
echo "Converting gender..."
#Copies the awk script to the remote srv
scp gender_converter.awk $remote_usrid@$remote_srv:/home/$remote_usrid/ || exit 1
#Gets into the srv and run the awk script
ssh "$remote_usrid@$remote_srv" "awk -f gender_converter.awk /home/$remote_usrid/$remote_file > /home/$remote_usrid/no_header.csv" || { echo "Unsuccessful gender converting"; exit 1; }
echo "Successful converting gender"

#Filters all records with no state or NA
echo "Filtering states..."
./filter.sh $remote_usrid $remote_srv $remote_file

#Removes $ sign from the purchase_amt field
echo "Removing $ sign..."
./remove_dollarsign.sh $remote_srv $remote_usrid $remote_file

#Sorts customerID
echo "Sorting customerID..."
./sort_ID.sh $remote_srv $remote_usrid $remote_file

#Removes extra files from the srv
ssh "$remote_usrid@$remote_srv" "rm /home/$remote_usrid/no_header.csv /home/$remote_usrid/gender_converter.awk" || { echo "Unsuccessful file deletion"; exit 1; }

#Generates summary report
./generate_report.sh $remote_srv $remote_usrid $remote_file

#Create transaction report
./transaction_report.sh $remote_srv $remote_usrid $remote_file

#Generates purchase report
./purchase_report.sh $remote_srv $remote_usrid $remote_file
