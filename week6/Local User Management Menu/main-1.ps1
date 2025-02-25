. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List At-Risk Users `n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"


        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        if (checkUser($name) -eq $true){
            Write-Host "ERROR: That User already exists!" | Out-String
            continue 
            
        }

        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function
        $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        $check = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
        $test = checkPassword($check)
        
        if ($test -eq $false){
            Write-Host "ERROR: Password does not meet complexity requirements!" | Out-String
            continue
            
        }

        createAUser $name $password
       
        Write-Host "User: $name is created." | Out-String
        
       
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"
        # TODO: Check the given username with the checkUser function.
        $check = checkUser($name)
        if ($check -eq $false){
            Write-Host "ERROR: That User does not exist!" | Out-String
            continue 
            
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        $check = checkUser($name)
        if ($check -eq $false){
            Write-Host "ERROR: That User does not exist!" | Out-String
            continue 
            
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.
        $check = checkUser($name)
        if ($check -eq $false){
            Write-Host "ERROR: That User does not exist!" | Out-String
            continue 
            
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
        $check = checkUser($name)
        if ($check -eq $false){
            Write-Host "ERROR: That User does not exist!" | Out-String
            continue 
            
        }
        $days = Read-Host -Prompt "Please enter the number of days"
        if ($days -notmatch '[0-9]'){
            Write-Host "ERROR: That is not an accepted input!" | Out-String
            continue
        }
        $userLogins = getLogInAndOffs $days
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.
        $check = checkUser($name)
        if ($check -eq $false){
            Write-Host "ERROR: That User does not exist!" | Out-String
            continue 
            
        }
        $days = Read-Host -Prompt "Please enter the number of days"
        if ($days -notmatch '[0-9]'){
            Write-Host "ERROR: That is not an accepted input!" | Out-String
            continue
        }
        $userLogins = getFailedLogins $days
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    elseif($choice -eq 9){
        $days = Read-Host -Prompt "Please enter the number of days"
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #or a character that should not be accepted. Give a proper message to the user and prompt again.
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
}




