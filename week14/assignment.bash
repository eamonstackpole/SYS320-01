#! /bin/bash

url="10.0.17.6/assignment.html"
# Acquire and Store Temperature Table and Dates into Arrays
temp=$(curl -sL "$url" | pup 'table:first-of-type')
hold=$(echo "$temp" | sed -e 's/<[^>]*>//g' | awk 'NF')
holdList=()
tempList=()
dateList=()
readarray -t holdList <<< "$hold"
unset holdList[0]
unset holdList[1]
for entry in "${holdList[@]}"; do
	if [[ "$entry" == *"m"* ]]; then
	   dateList["${#dateList[@]}"]="$entry"
	else
	   tempList["${#tempList[@]}"]="$entry"
	fi 
done 

# Acquire and Store Pressure Table into Array (Filtering out Dates)
press=$(curl -sL "$url" | pup 'table:nth-of-type(2)')
hold=$(echo "$press" | sed -e 's/<[^>]*>//g' | awk 'NF')
holdList=()
pressList=()
readarray -t holdList <<< "$hold"
unset holdList[0]
unset holdList[1]
for entry in "${holdList[@]}"; do
	
	if [[ "$entry" != *"m"* ]]; then
	   pressList["${#pressList[@]}"]="$entry"
	fi
done 
# Putting them Together
length="${#pressList[@]}"
for (( i=0; i< length; i++ )); do
	echo "${pressList[$i]}${tempList[$i]}${dateList[$i]}" 
done
