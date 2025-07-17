#!/bin/bash

################################################################################
# Script: Rofi Power Menu                                                       #
# Purpose: Provide a simple graphical menu for power actions (Shutdown, Reboot, #
#          Logout) with confirmation prompt before executing the selected action.#
################################################################################

# Show power options in rofi menu with icons
chosen=$(printf " Shutdown\n Reboot\n Logout" | rofi -dmenu -i -p "Power" -theme-str 'window {width: 200;}')

# Exit if no option was selected
[ -z "$chosen" ] && exit 1

# Confirmation prompt
confirm=$(printf "No\nYes" | rofi -dmenu -i -p "Are you sure?" -theme-str 'window {width: 200;}')

# Exit if user does not confirm
if [[ "$confirm" != "Yes" ]]; then
    exit 1
fi

# Execute the selected action
case "$chosen" in
    *Shutdown) systemctl poweroff ;;
    *Reboot) systemctl reboot ;;
    *Logout) pkill -KILL -u "$USER" ;;
    *) exit 1 ;;
esac
