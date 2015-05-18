#!/bin/sh
clear


WAV_FILES_DIR=/Afrigo.wav # Contains Wave Files
CONVERTED_DIR=/Afrigo.conv
ASTERISK_SOUNDS_DIR=/var/lib/asterisk/sounds
PROMPT=voice
TEMPFILE=/tmp/remove


# Create converted sounds directory if it does not exist
[ -d $CONVERTED_DIR ] || mkdir -p $CONVERTED_DIR



# Remove temp file
rm -f $TEMPFILE
# Check to see if the wav files are properly named i.e. no spaces
for FILENAME in `ls $WAV_FILES_DIR/*`
do
ls  $FILENAME >> $TEMPFILE 2>&1
done

# test to see if spaces exist
grep -rli "cannot access" $TEMPFILE > /dev/null
EXITVAL=$?
# Remove temp file
rm -f $TEMPFILE

if [ "$EXITVAL" = "0" ];
then
# Spaces Exist in Directory: - Rename files
echo "Renaming song files i.e. removing spaces in names"
sleep 5
# Rename files
for NAME in *.wav
do
# Song Number
let "DIGIT = DIGIT + 1" > /dev/null
# Copy renamed files to MOH folder
cp -v "$NAME" $WAV_FILES_DIR/$PROMPT-$DIGIT.wav
done
fi


# Change to Raw Wave File folder
cd $WAV_FILES_DIR

# Covert to sln format
#for FILE in *.wav; do  sox -V "$FILE" -t raw -r 8000 -s -w -c 1 `echo $FILE|sed "s/.wav/.sln/"` resample -ql; done
for FILE in *.wav; do  sox -V "$FILE" -t raw -r 8000 -s -c 1 `echo $FILE|sed "s/.wav/.sln/"` rate -ql; done


# Move to sounds dir
mv -v $WAV_FILES_DIR/*.sln $CONVERTED_DIR/

# Notify path of music on hold directory
clear
echo "The $PROMPT files have been converted to asterisk format i.e. sln.
Copies are located in the directory : [$CONVERTED_DIR]

You will need to manually move them to the Asterisk Sounds Directory at:
[$ASTERISK_SOUNDS_DIR] or MOH Directory

"


rm -rf $WAV_FILES_DIR
