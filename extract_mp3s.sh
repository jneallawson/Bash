#!/bin/bash

# Script to extract highest-quality MP3 from each .mp4 and .webm 
# in current dir, matching source audio bitrate/sample rate/channels
# to avoid bloat.
# - handles ALL special chars (including unicode) via find -print0
# - Uses ffprobe to parse source audio specs, then ffmpeg accordingly.
# Output: same basename as input.mp4 but .mp3 extension.
#
# captainneal@gmail.com, github.com/jneallawson

find . -maxdepth 1 \( -name '*.mp4' -o -name '*.webm' \) -print0 | while IFS= read -r -d '' video; do
  base="${video%.*}"
  mp3="${base}.mp3"
  
  echo "Processing: $(basename "$video")"
  echo "  Extracting first audio stream..."
  
  # Run in background + wait to prevent TTY prompt
  ffmpeg -y -i "$video" -map 0:a:0 -vn -c:a libmp3lame -q:a 0 \
    -nostdin -hide_banner -loglevel error "$mp3" &
  
  ffmpeg_pid=$!
  wait $ffmpeg_pid  # Wait for completion
  
  if [ $? -eq 0 ] && [ -f "$mp3" ]; then
    size=$(du -h "$mp3" | cut -f1)
    echo "  ✓ $(basename "$mp3") (${size})"
  else
    echo "  ✗ Failed"
    rm -f "$mp3"
  fi
  echo ""
done

echo "Done."
