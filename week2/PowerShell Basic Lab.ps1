# 1 - Get IPv4 Address from Ethernet Interface
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet0"}).IPAddress
# 2 - Get IPv4 PrefixLength from Ethernet0 Interface
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ilike "Ethernet0"}).Prefixlength
# 3&4 - Show what classes there is of Win32 library that starts with net, sort alphabetically
#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object 
# 5&6 - Get DHCP Server IP & Hide the table headers
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | select DHCPServer | Format-Table -HideTableHeaders
# 7 - Get DNS Server IPs for Ethernet Interface and only display the first one
#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet*" }).ServerAddresses[0]
# 8 - List all the files in your working directory
#cd $PSScriptRoot

# List files based on file name
#$files=(Get-ChildItem)
#for ($j=0; $j -le $files.Length; $j++){
#    if ($files[$j].Name -ilike "*ps1"){
#        Write-Host $files[$j].Name
#        }
#    }
# 9 - Create a folder called "outfolder" if it does not already exist
#$folderpath="$PSScriptRoot\outfolder"
#if (Test-Path $folderpath){
#    Write-Host "Folder Already Exists"
#}
#else{
#    New-Item -ItemType Directory -Path $folderpath
#}

# 10 - List all the files in your working directory
#cd $PSScriptRoot
#$files= Get-ChildItem -Filter "*.ps1"

#$folderPath = "$PSScriptRoot/outfolder/"
#$filePath = New-Item -ItemType "file" -Path $folderPath -Name "out.csv"

# List all the files that have the extension ".ps1" and save the results to out.csv file
#$files | Export-Csv -Path $filePath
# 11 - Without changing the directory find every .csv file and change their extensions to .log, then recursively display the files
$files= Get-ChildItem -Recurse -File
$files | Rename-Item -NewName {$_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse -File