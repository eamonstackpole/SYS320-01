. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot Apache-Logs2.ps1)

clear
# Windows Apache Function
$test = grabLogs -page 'page.html' -code ' 404 ' -browserName 'Chrome'
$test

# Apache Parsing Function
$tableRecords = ApacheLogs2
$tableRecords | Format-Table -AutoSize -Wrap