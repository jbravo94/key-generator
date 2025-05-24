#!/bin/bash -e

#################### INITIALIZATION ####################

# Static variables
OUT_DIR="out"
DEFAULT_IN_KEY_FILE_NAME="$1"
DEFAULT_OUT_FILE_NAME="physical-key-file.pdf"


# Preparation: default input file and check if exist, create working directory 
if [ -z "$1" ]
then
    DEFAULT_IN_KEY_FILE_NAME="private.key"
fi

if ! [ -f $DEFAULT_IN_KEY_FILE_NAME ]
then
    echo "$DEFAULT_IN_KEY_FILE_NAME not found - aborted."
    exit
fi

mkdir -p $OUT_DIR


#################### EXECUTION ####################

# Read key line by line and encode 5 line chunks into QR code 
COUNTER=0
CHUNK=""
FILE_NAMES_IN_ORDER=""

while IFS='' read -r LINE; do
    CHUNK+="$LINE\n"
    ((COUNTER+=1))

    # Each 5 lines encode chunk into QR code and reset chunk
    if (( $COUNTER % 5 == 0 ))
    then
        # Write QR code with module size of 10 pixels
        echo $CHUNK | qrencode -s 10 -o "$OUT_DIR/$COUNTER.jpg"

        # Concat filenames to ensure sequential ordering for PDF generation
        FILE_NAMES_IN_ORDER+=" $OUT_DIR/$COUNTER.jpg"
        CHUNK=""
    fi
done < $DEFAULT_IN_KEY_FILE_NAME


# Convert QR code file name list into PDF in A4 format
convert -page a4 $FILE_NAMES_IN_ORDER "$OUT_DIR/$DEFAULT_OUT_FILE_NAME"


#################### CLEANUP ####################

rm -rf $OUT_DIR/*.jpg