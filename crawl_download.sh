#!/usr/bin/bash

# Crawl and download the website specified on the command-line. Wraps wget.
# - Neal Lawson
# Example: $0 http://example.com
#
# Resource: https://simpleit.rocks/linux/how-to-download-a-website-with-wget-the-right-way/

if [ $# -ne 1 ]; then
  echo ""
  echo "USAGE: $0 URL-to-download"
  echo ""
  exit 1
fi


wget --random-wait \
     --level=inf \
     --recursive \
     --page-requisites \
     --user-agent=Mozilla \
     --no-parent \
     --convert-links \
     --adjust-extension \
     --no-clobber \
     -e robots=off \
          $1


# Options not using currently:
#  Don't re-retrieve files unless newer than.
#     --timestamping \
#
#  Limit the download speed to amount bytes per second.
#     --limit-rate=20K \
