#!/bin/bash
echo -e "\n########################################################### CREATE SWAP MEMORY ##################################################################\n"
echo -e "\n####SCRIPT IS DONE BY ATISH\n"
# size of swapfile in megabytes
#swapsize=1024
#swapsize=1024
#Does the swap already exist
grep -q "swap" /etc/fstab
if [ $? -ne 0 ]; then
	echo 'SWAPFILE NOT FOUND/GOING TO ADD'
if [ -z "${swapsize}" ]; then
	read -p "Please enter swap file name  [${swapname}]: " swapname
    fi
if [ -z "${swapsize}" ]; then
        read -p "Please enter swap memory  [${swapsize}]: " swapsize
    fi
read -p 'Would you like to continue [y/n]: ' answer
    if [ "$answer" != 'y' ] && [ "$answer" != 'Y'  ]; then
        echo 'GOOD BYE'
        exit 1
    fi
 # IF DD COMMAND WILL NOT WORK COMMENT DD && UN COMMENT FALLOCATE
       fallocate -l ${swapsize}M /${swapname}
 #       dd if=/dev/zero of=/${swapname} bs=1M count=${swapsize}
        chmod 600 /${swapname}
        mkswap /${swapname}
        swapon /${swapname}
        echo "/${swapname} swap swap defaults 0 0" >> /etc/fstab
else
        echo 'swapfile found.So No changes made.'
fi

# output results to terminal
cat /proc/swaps
cat /proc/meminfo | grep Swap

exit
