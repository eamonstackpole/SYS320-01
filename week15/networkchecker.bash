#!/bin/bash

myIP=$(bash myIP.bash)


# Todo-1: Create a helpmenu function that prints help for the script
function helpmenu(){
echo "HELP MENU"
echo "*******************************************************"
echo "Syntax: ./$0 [- n/s] external/internal"
echo "Options:"
echo "n - Uses Nmap"
echo "s - Uses ss"
echo "Arguments:"
echo "internal - Prints Internal Ports"
echo "external - Prints External Ports"
echo "*******************************************************"
}

# Return ports that are serving to the network
function ExternalNmap(){
  rex=$(nmap "${myIP}" | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
  echo "$rex"
}

# Return ports that are serving to localhost
function InternalNmap(){
  rin=$(nmap localhost | awk -F"[/[:space:]]+" '/open/ {print $1,$4}' )
  echo "$rin"
}


# Only IPv4 ports listening from network
function ExternalListeningPorts(){
# Todo-2: Complete the ExternalListeningPorts that will print the port and application
# that is listening on that port from network (using ss utility)
# Same command as internal just filter out 127.0.0 instead of [::]
   xlpo=$(ss -ltpn4 | awk -F "[[:space:]:(),]+" '!/127.0.0./ && $1 == "LISTEN"  {print $5,$9}' | tr -d "\"")
   echo "$xlpo"
}


# Only IPv4 ports listening from localhost
function InternalListeningPorts(){
ilpo=$(ss -ltpn | awk  -F"[[:space:]:(),]+" '/127.0.0./ {print $5,$9}' | tr -d "\"")
  echo "$ilpo"
}



# Todo-3: If the program is not taking exactly 2 arguments, print helpmenu
if [ ! ${#} -eq 2 ]; then
helpmenu
exit;
fi
# Todo-4: Use getopts to accept options -n and -s (both will have an argument)
# If the argument is not internal or external, call helpmenu
# If an option other then -n or -s is given, call helpmenu
# If the options and arguments are given correctly, call corresponding functions
# For instance: -n internal => will call NMAP on localhost
#               -s external => will call ss on network (non-local)
while getopts "n:s:" option
do
	case $option in 
	n)
	     if [ "${OPTARG}" == "internal"  ]; then 
		InternalNmap
	     elif [ "${OPTARG}" == "external" ]; then
	   	ExternalNmap
	     else
		helpmenu
	     fi
	;;
	s)
	     if [ "${OPTARG}" == "internal" ]; then
		InternalListeningPorts
	     elif [ "${OPTARG}" == "external" ]; then
		ExternalListeningPorts
	     else
		helpmenu
	     fi
	;;
	:)
	     helpmenu
	;;
	?)
	     helpmenu
	;;
	esac
done
