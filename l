#!/usr/bin/bash

lsblk -o NAME,SIZE,FSTYPE,FSUSE%,MOUNTPOINT | awk '
BEGIN {
    header="\033[1;36m"   
    name="\033[0;32m"    
    size="\033[0;36m"    
    fstype="\033[0;32m"  
    fsuse="\033[0;36m"    
    mountpoint="\033[0;32m" 
    reset="\033[0m"       
}

NR == 1 {
    # Print header with header color
    print header $0 reset
    next
}

{
    # Print each field with its respective color
    printf "%s%s%s  %s%s%s  %s%s%s  %s%s%s  %s%s%s\n",
        name, $1, reset,
        size, $2, reset,
        fstype, $3, reset,
        fsuse, $4, reset,
        mountpoint, $5, reset
}' | column -t 

df -h | awk '/\/mnt/ {print $6 ": " $3 "/" $2 " (" $5 ")" }'
echo -n "root: "; df -h | awk '/\/$/ {print $3 "/" $2 " (" $5 ")" }'
