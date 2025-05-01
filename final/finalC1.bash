#! bin/bash

url="10.0.17.6/IOC.html"

temp=$(curl -sL "$url" | pup 'td:first-of-type')
hold=$(echo "$temp" | sed -e 's/<[^>]*>//g' | awk 'NF')
echo "$hold" > IOC.txt
