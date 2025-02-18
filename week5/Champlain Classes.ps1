function gatherClasses(){
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.24/Courses.html


# Get all the tr elements of HTML document
$trs=$page.ParsedHtml.body.getElementsByTagName("tr")
# Empty Array to hod results
$FullTable = @()

for ($i=1; $i -lt $trs.length; $i++){

    #Get every td element of current tr element
    $tds = $trs[$i].getElementsByTagName("td")
    # Separate start time and end time from one time field
    $Times = $tds[5].innerText.Split("-")
    # Put into CustomObject
    
    $FullTable += [PSCustomObject]@{"Class Code" = $tds[0].innerText;
                                    "Title" = $tds[1].innerText;
                                    "Days" = $tds[4].innerText;
                                    "Time Start" = $Times[0];
                                    "Time End" = $Times[1];
                                    "Instructor" = $tds[6].innerText;
                                    "Location" = $tds[9].innerText; 
                                    }

}
return $FullTable
}

function daysTranslator($FullTable){

for ($i=0; $i -lt $FullTable.length; $i++){
    #empty array
    $Days = @()

    #If you see "M" -> Monday
    if($FullTable[$i].Days -ilike "M*"){ $Days += "Monday"}

    #If you see "T" followed by T,W, or F -> Tuesday
    if($FullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday"}

    #If you only see "T" -> Tuesday
    Elseif($FullTable[$i].Days -ilike "*T"){ $Days += "Tuesday"}

    #If you see "W" -> Wednesday
    if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday"}
    #If you see "TH" -> Thursday
    if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday"}
    #If you see "F" -> Friday
    if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday"}
    #Switches the values
    $FullTable[$i].Days = $Days



} #End Loop
return $FullTable
}
daysTranslator(gatherClasses) | Where-Object {$_.Location -ilike "JOYC 310"}