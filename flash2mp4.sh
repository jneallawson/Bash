#!/bin/bash 

# flash2mp4.sh - For every .flv file in the current directory,
# 	create a corresponding .mp4 file.
# Requires: ffmpeg with libx264 codec support.
#	- Neal Lawson

# For every .flv file in this directy...
for fname in `ls -f *.flv`;
do
   # get the file name minus the extension.
   name="${fname%.*}"

   # if the .mp4 doesn't exist, create an .mp4 from the .flv file.
   if ! test -f "$name.mp4"; then
      echo "Creating ${name}.mp4 ..."
      ffmpeg -y -loglevel warning -stats -i $name.flv -c:v libx264 -crf 19 -strict experimental $name.mp4
      echo ""
   fi
done

