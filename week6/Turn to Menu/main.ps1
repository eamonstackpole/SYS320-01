. "C:\Users\champuser\SYS320-01\week6\Local User Management Menu\Event-Logs.ps1"
. "C:\Users\champuser\SYS320-01\week4\Apache-Logs2.ps1"

clear 

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display Last 10 Apache Logs`n"
$Prompt += "2 - Display Last 10 Failed Logins for all Users`n"
$Prompt += "3 - Display At-Risk Users`n"
$Prompt += "4 - Start Chrome and Navigate to Champlain.edu`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host
    #Input Checking
    if($choice -notmatch '[1-5]'){
        Write-Host "ERROR: That is not a valid operation!" | Out-String
        continue
    }

    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    #Display last 10 Apache Logs
    elseif($choice -eq 1){
        $test = ApacheLogs2
        $test[-10..-1] | Format-Table 
    }
    #Display last 10 failed Logins
    elseif($choice -eq 2){
        $days = Read-Host -Prompt "Please enter the number of days"
        if ($days -notmatch '[0-9]'){
            Write-Host "ERROR: That is not an accepted input!" | Out-String
            continue
        }
        $userLogins = getFailedLogins $days 
        $userlogins[-10..-1] | Format-Table
    }
    #Display at risk users
    elseif($choice -eq 3){
        $days = Read-Host -Prompt "Please enter the number of days"
        if ($days -notmatch '[0-9]'){
            Write-Host "ERROR: That is not an accepted input!" | Out-String
            continue
        }

        $userLogins = getFailedLogins $days
        $users = @()
        for ($i = 0; $i -lt $userLogins.Length; $i++){
            $users += $userLogins[$i].User
        }
        $users = $users | Group-Object
        Write-Host ($users | Where-Object {$_.Count -ge 10} | Select-Object Name | Out-String)
    }
    #Open Chrome and Navigate to champlain.edu
    elseif($choice -eq 4){
        . "C:\Users\champuser\SYS320-01\week2\Process_Management_Chrome.ps1"
    }










}