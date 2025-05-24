#!/bin/bash -e

#################### INITIALIZATION ####################

# Static variables
DEFAULT_IN_FILE_NAME="$1"
DEFAULT_OUT_KEY_FILE_NAME="private.key"
OUT_DIR="out"


# Preparation: default input file and check if exist, create working directory 
if [ -z "$1" ]
then
    DEFAULT_IN_FILE_NAME="physical-key-file.pdf"
fi

if ! [ -f $DEFAULT_IN_FILE_NAME ]
then
    echo "$DEFAULT_IN_FILE_NAME not found - aborted."
    exit
fi

mkdir -p $OUT_DIR


#################### EXECUTION ####################

# Read pdf, trim excess detectable whitespace and save each page as file 
convert $DEFAULT_IN_FILE_NAME -trim $OUT_DIR/part_%d.jpg


# Read images, decode QR code and concat into string
KEY_STRING=""

for file in $OUT_DIR/part_*.jpg
do
    # zbarimg parameters ensure only decoded string is exported
    KEY_STRING+=$(zbarimg -q --raw $file)
done


# Save with proper new lines into file
echo -e $KEY_STRING > $OUT_DIR/$DEFAULT_OUT_KEY_FILE_NAME


#################### CLEANUP ####################

rm -rf $OUT_DIR/*.jpg
