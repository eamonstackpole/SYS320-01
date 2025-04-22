#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1 - FINISHED
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas
function displayCourseInLocation(){
echo -n "Please Input a Classroom Name: "
read locName
echo ""
echo "Courses in $locName :"
cat "$courseFile" | grep "$locName" | cut -d ';' -f 1,2,5,6,7 | sed 's/;/ | /g'
echo ""
}
# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function displayCourseAvailability(){
echo -n "Please Input a Course Code: "
read code
local courseList=$(cat "$courseFile" | grep "$code")
local availList=()
local tempList=()
readarray -t tempList <<< "$courseList"
echo "" 
echo "Available Courses in $code :"
for course in "${tempList[@]}"; do
    local seats=$(echo "$course" | cut -d ';' -f 4)
    if [ $((seats)) -gt 0 ]; then
	echo "$course" | sed 's/;/ | /g'
    fi
done
echo ""
}


while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses in a location"
	echo "[4] Display courses by availability"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts
	elif [[ "$userInput" == "3" ]]; then
		displayCourseInLocation
	elif [[ "$userInput" == "4" ]]; then
		displayCourseAvailability
	# TODO - 3 Display a message, if an invalid input is given - FINISHED
	else
		echo "ERROR: The Input given was not a valid option!"
	fi
done
