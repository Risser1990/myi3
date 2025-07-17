#!/bin/bash

############################################################
# Script: Toggle Weather Popup                              #
# Purpose: Toggle a weather popup window using kitty       #
#          running wttr.in weather info in a scratchpad.   #
#          If the popup is visible, it moves it to the     #
#          scratchpad (hides it). If not, it spawns a new  #
#          kitty window and shows it.                       #
############################################################

# Check if a visible weatherpop window already exists
if xdotool search --onlyvisible --class weatherpop >/dev/null 2>&1; then
    # Hide it by moving to scratchpad (toggle off)
    i3-msg '[class="weatherpop"] move to scratchpad'
else
    # Spawn new weatherpop kitty window with wttr.in weather
    kitty --class=weatherpop -e bash -c '
      curl "wttr.in?2&columns=60";
      echo;
      echo "Press any key to exit...";
      read -n 1 -s;
      exit
    ' &

    # Small delay before showing the scratchpad window
    sleep 0.3
    i3-msg '[class="weatherpop"] scratchpad show'
fi
