Function grabLogs{
    param (
    [String]$page,
    [String]$code,
    [String]$browserName
    )

$logs = Get-Content C:\xampp\apache\logs\access.log | Select-String $page  | Select-String $code  | Select-String $browserName
$regex = [regex] "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"
$ipsUnorganized = $regex.Matches($logs)

$ips = @()
for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
 $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
 }
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group -Property IP
return $counts | Select-Object Count, Name

}
