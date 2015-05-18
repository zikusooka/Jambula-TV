#!/bin/sh
clear

INPUT_MP3_DIRECTORY=/AExBox2/music/afrigo
OUTPUT_WAV_DIRECTORY=/Afrigo.wav
DIGIT=99
PROMPT=song





# Create Output Directory if it does not exist
[ -d $OUTPUT_WAV_DIRECTORY ]  || mkdir $OUTPUT_WAV_DIRECTORY

# Change to mp3 file directory
cd $INPUT_MP3_DIRECTORY

# Rename files
for NAME in *.mp3
do
# Song Number
let "DIGIT = DIGIT + 1" > /dev/null
# Copy renamed files to MOH folder
cp -v "$NAME" $PROMPT-$DIGIT.mp3
# Convert to wav
mpg123 -w $OUTPUT_WAV_DIRECTORY/$PROMPT-$DIGIT.wav $PROMPT-$DIGIT.mp3
# Remove renamed file
rm -f $PROMPT-$DIGIT.mp3
done


