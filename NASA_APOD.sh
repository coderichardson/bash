#!/bin/bash

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

# Download the image and name is today's date and assign a filetype of .jpg.
curl -s -o "$today.jpg" "https://apod.nasa.gov/apod/$img_src_string"

# Print that the download was successful.
file_name=$today.jpg
if [ -f "$file_name" ]; then
    echo "File '$file_name' downloaded successfully."
else
    echo "Failed to download the file."
fi