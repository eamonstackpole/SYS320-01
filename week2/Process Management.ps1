# Write a Powershell Script that lists every process for which ProcessName starts with "C".
#Get-Process | Where-Object {$_.ProcessName -ilike "C*"}
# Write a Powershell Script that lists every process for which the path does not include string "system32"
#Get-Process | Where-Object {$_.Path -notlike "C:\Windows\system32*"}
# Write a Powershell Script that lists every stopped service, orders it alphabetically, and saves it to a csv file
#Get-Service | Where-Object {$_.Status -eq "Stopped"} | Sort-Object | Export-Csv -Path "stopped.csv"
# Write a Powershell Script that starts Google Chrome and directs it to Champlain.edu, if its already running it stops it.
$chrome = Get-Process chrome -ErrorAction SilentlyContinue
if (!$chrome){
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList 'https://champlain.edu'
    }
else{
    Stop-Process -Name chrome
}

