#! bin/bash

logFile=$1

susFile=$2

indList=()
logList=()

readarray -t indList < "$susFile"
readarray -t logList < "$logFile"
:> report.txt
for log in "${logList[@]}"; do
    for ind in "${indList[@]}"; do
         if echo "$log" | grep -q $ind; then
	 	echo "$log" | cut -d " " -f 1,4,7 | tr -d "[" >> report.txt
		break
         fi
    done
#cat "$logFile" | grep $ind | uniq | cut -d " " -f 1,4,7 | tr -d "["  >> report.txt
done
cat report.txt

