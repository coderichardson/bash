#!/bin/bash

# Download NASA's Astronomy Picture of the Day!

# Get today's date in the format YYYYMMDD
today=$(date +%Y%m%d)

# API endpoint URL for NASA APOD
apod_url="https://apod.nasa.gov/apod/astropix.html"

# Make a GET request to the APOD API
response=$(curl -s "$apod_url")

# Store the provided HTML content in a variable
html_content=$response

# Extract the string following 'IMG SRC=' using grep and regex
img_src_string=$(echo "$html_content" | grep -oP '<IMG\s+SRC="\K[^"]+' | head -1)

# Extract the image extension from the URL
img_extension=$(echo "$img_src_string" | grep -oP '\.\w+$' | tr '[:upper:]' '[:lower:]')

# Download the image with the identified extension
curl -s -o "$today$img_extension" "https://apod.nasa.gov/apod/$img_src_string"

# Print that the download was successful.
file_name=$today$img_extension
if [ -f "$file_name" ]; then
    echo "File '$file_name' downloaded successfully."
else
    echo "Failed to download the file."
fi