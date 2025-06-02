#!/bin/bash
# Adrianna Barrera
# 12/7/2023
# Semester Project: ETL

#Copies the src file to the project dir
scp "$remote_usrid@$remote_srv:/home/shared/$remote_file" "$remote_usrid@$remote_srv:/home/$remote_usrid/" || exit 1
if [ $? -eq 0 ]; then
    echo "Successful transfer"
fi
