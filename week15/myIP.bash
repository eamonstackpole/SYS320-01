#!bin/bash

ip addr | grep 10.0.17.23 | awk '{print $2}' | cut -d "/" -f 1
