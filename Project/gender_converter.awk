#!/usr/bin/awk -f
#12/7/2023
#Adrianna Barrera
# Semester Project: ETL

# Set input FS and OFS to comma
BEGIN{
    FS = ",";
    OFS = ",";
}

# Process each line in the CSV file
{
#Check the value in the 5th field and converts it
if ($5 == "1")
        $5 = "f";
    else if ($5 == "0")
        $5 = "m";
    else if ($5 == "male")
        $5 = "m";
    else if ($5 == "female")
        $5 = "f";
    else
        $5 = "u";

    print $0;
 }
