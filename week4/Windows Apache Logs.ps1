# List all of the apache logs of xampp
#Get-Content C:\xampp\apache\logs\access.log
# List only last 5 Apache logs
#Get-Content C:\xampp\apache\logs\access.log -Tail 5
# Display only logs that contain 404 (Not Found) or 400 (Bad Request)
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ', ' 400 '
# Display only logs that does NOT contain 200 (OK)
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch
# From every .log file in the directory, only get logs that contains the word 'error'
#$A = Get-childItem -Path C:\xampp\apache\logs\*.log | Select-String 'error'
# Display the last 5 elements of the result array
#$A[-5..-1]
# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '
# Define a regex (Regular Expression) for IP addresses
$regex = [regex] "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"
# Get $notfounds records that match the regex
$ipsUnorganized = $regex.Matches($notfounds)
# Get ips as pscustomobject
$ips = @()
for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
 $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
 }
 #$ips | Where-Object {$_.IP -ilike "10.*"}
 # Count ips from number 8 
 $ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
 $counts = $ipsoftens | Group -Property IP
 $counts | Select-Object Count, Name