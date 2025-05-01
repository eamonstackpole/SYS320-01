#! /bin/bash

ipList=()
dateList=()
pageList=()

readarray -t reportList < "report.txt"
for log in "${reportList[@]}"; do
	ipList+=("$(echo "$log" | cut -d " " -f 1)")
	dateList+=("$(echo "$log" | cut -d " " -f 2)")
	pageList+=("$(echo "$log" | cut -d " " -f 3)")
done

:> /var/www/html/report.html
{
echo "<html>"
echo "<body>"
echo "<h3>Access logs with IOC indicators:</h3>"
echo "<table border=1>"
for (( i=0; i < "${#ipList[@]}"; i++ )); do
	echo "<tr>"
	echo "<td>${ipList[$i]}</td>"
	echo "<td>${dateList[$i]}</td>"
	echo "<td>${pageList[$i]}</td>"
	echo "</tr>"
done
echo "</table>"
echo "</body>"
echo "</html>"
} > /var/www/html/report.html
cat "/var/www/htmlreport.html"
