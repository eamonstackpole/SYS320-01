#!bin/bash

file="/var/log/apache2/access.log"

function getPageTwo(){
pageTwo=$(cat "$file" | grep "GET /page2.html" | cut -d ' ' -f1,7 | tr -d "/")
}

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,4,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

function pageCount(){
pagesAccessed=$(echo "$allLogs" | cut -d' ' -f3 | sort | uniq -c)
}

function countingCurlAccess(){
curlAccessed=$(cat "$file" | grep "curl/" | cut -d' ' -f1,12 | sort | uniq -c)
}

countingCurlAccess
echo "$curlAccessed"

