#!/bin/bash

##########################################################
# Script: Disk Usage Display for Polybar                  #
# Purpose: Shows used and total disk space in GiB for    #
#          a given mount point (default is root "/").     #
# Output: Formatted string suitable for Polybar with      #
#         color tags, e.g., "used/total GB" in grey.      #
##########################################################

# Mount point
MOUNT="/"

# Get used and total space in GiB
read used total <<< $(df -BG --output=used,size "$MOUNT" | tail -n 1 | awk '{print $1, $2}')
used=${used%G}
total=${total%G}

# Output formatted for Polybar with color
echo "%{F#dfdfdf}${used}/${total} GB%{F-}"
