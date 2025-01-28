# Write a Powershell Script that starts Google Chrome and directs it to Champlain.edu, if its already running it stops it.
$chrome = Get-Process chrome -ErrorAction SilentlyContinue
if (!$chrome){
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList 'https://champlain.edu'
    }
else{
    Stop-Process -Name chrome
}