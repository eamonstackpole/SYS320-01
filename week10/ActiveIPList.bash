 #!/bin/bash

# List all the ips in the given network prefix
# /24 only

# Usage: bash IPList.bash 10.0.17
[ "$#" -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1 

# Prefix is the first input taken
prefix="$1"
# Verify input length
[ ${#prefix} -lt 5 ] && \
printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {1..254}
 do
	ping -c 1 "$prefix.$i" | grep "64 bytes from*" | awk '{print $4}' \
	| tr -d ':'   
done
