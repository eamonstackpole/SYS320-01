. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

# Get Login and Logoffs from the last 15 days
$loginoutsTable = getLogonLogoff(15)
$loginoutsTable
# Get Starts and Shut-downs from last 25 days
$startshutsTable = getStartShut(25)
$startshutsTable
