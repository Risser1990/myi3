#!/bin/bash

##########################################################
# Script: Memory Usage Display                             #
# Purpose: Outputs current memory usage in GiB and       #
#          as a percentage of total memory used.          #
##########################################################

# Get used memory in GiB with 1 decimal precision
used=$(free -m | awk '/Mem:/ { printf "%.1f", $3 / 1024 }')

# Get used memory as percentage (integer)
pct=$(free | awk '/Mem:/ { printf "%d", $3 / $2 * 100 }')

# Print used memory and percentage
echo "$used GiB ($pct%)"
