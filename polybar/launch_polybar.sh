#!/bin/bash

##########################################################
# Script: Polybar Launch with Multi-Monitor Support       #
# Purpose: Kill existing polybar instances, then launch   #
#          polybar on all connected monitors. The primary #
#          monitor gets a bar with tray; others get a     #
#          bar without tray to avoid duplicates.           #
##########################################################

# Optional delay to ensure monitors are fully ready (uncomment if needed)
# sleep 2

# Kill all existing polybar instances quietly
killall -q polybar

# Wait until all polybar processes have fully stopped
while pgrep -x polybar >/dev/null; do
  sleep 0.5
done

# Define the monitor that should display the system tray
tray_monitor="DisplayPort-1"  # Adjust to your primary monitor name

# Get all connected monitors (names)
monitors=($(xrandr --query | grep " connected" | cut -d" " -f1))

# Launch polybar on each monitor
for m in "${monitors[@]}"; do
  if [ "$m" = "$tray_monitor" ]; then
    MONITOR="$m" polybar --reload cody &
  else
    MONITOR="$m" polybar --reload cody_no_tray &
  fi
done

