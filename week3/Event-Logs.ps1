<# ****************************************************************************************
    Functions: Get Login and Logoff Records from Windows Events for the past daysNum days
    Input: daysNum
    Output: Array of Logon and Logoff logs
******************************************************************************************* #>
function getLogonLogoff ($numDays){
#Get-EventLog -LogName System -Source Microsoft-Windows-winlogon
# Obtain the last 14 days of logs
$loginouts = Get-EventLog -LogName System -Source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-$numDays)
#Create an empty array
$loginoutsTable = @()

#Loop each log returned by Get-EventLog and process the records to form a new custom return object
# New Object displays
# Time: TimeGenerated obtained from event logs
# ID: InstanceID obtained from event logs
# Event: Depending on the value of InstanceID it will be Logon or logoff
# User: Obtained from ReplacementStrings obtained from event logs

for($i=0; $i -lt $loginouts.Count; $i++){
# Creating Event Value
$event="" #empty variable
if ($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
if ($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}
# Creating User Value
#Getting SID
$sid = $loginouts[$i].ReplacementStrings[-1]
# Translate to User name
$objSID = New-Object System.Security.Principal.SecurityIdentifier $sid
$user = $objSID.Translate([System.Security.Principal.NTAccount])

# Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                        "Id" = $loginouts[$i].InstanceId;
                                        "Event" = $event;
                                        "User" = $user;
                                        }


}
return $loginoutsTable
}

<# ****************************************************************************************
    Functions: Get Start and Shut-Down Records from Windows Events for the past daysNum days
    Input: daysNum
    Output: Array of Start and Shut-Down logs
******************************************************************************************* #>
function getStartShut($numDays){
# Obtain the last 14 days of logs
$startshuts = Get-EventLog -LogName System -Source EventLog -After (Get-Date).AddDays(-$numDays) | Where {$_.EventID -eq 6006 -or $_.EventID -eq 6005}
#Create an empty array
$startshutsTable = @()

#Loop each log returned by Get-EventLog and process the records to form a new custom return object
# New Object displays
# Time: TimeGenerated obtained from event logs
# ID: EventId obtained from event logs
# Event: Assign custom string value based on EventID
# User: Use constant value "System"

for($i=0; $i -lt $startshuts.Count; $i++){
# Creating Event Value
$event="" #empty variable
if ($startshuts[$i].EventId -eq 6005) {$event="Startup"}
if ($startshuts[$i].EventId -eq 6006) {$event="Shutdown"}

# Creating User Value
$user = "System"

# Adding each new line (in form of a custom object) to our empty array
$startshutsTable += [pscustomobject]@{"Time" = $startshuts[$i].TimeGenerated;
                                        "Id" = $startshuts[$i].EventId;
                                        "Event" = $event;
                                        "User" = $user;
                                        }


}
return $startshutsTable
}
