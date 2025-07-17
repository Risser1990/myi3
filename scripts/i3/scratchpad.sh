#!/usr/bin/env bash

# Prompt user for a note title using rofi dmenu with custom appearance
title=$(rofi -dmenu -p "Note Title:" -no-fixed-num-lines -theme-str 'listview { enabled: false; } window { width: 20em; } entry { padding: 10px; }')

# Exit if no title was entered
[ -z "$title" ] && exit 1

# Sanitize the title to create a safe filename:
# - convert to lowercase
# - replace spaces with hyphens
# - remove all characters except alphanumeric, hyphen, and underscore
safe_title=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-_')

# Construct the full filename in the Scratchpad-Notes directory with date suffix
filename="$HOME/Documents/Scratchpad-Notes/${safe_title}_$(date '+%B-%d-%Y').txt"

# Create the file if it doesn't exist
touch "$filename"

# After a short delay, show the scratchpad window class "scratchnote" in i3 (runs in background)
( sleep 0.2 && i3-msg '[class="scratchnote"] scratchpad show' ) &

# Open the file in micro editor, ensuring terminal input/output works correctly
micro "$filename" </dev/tty >/dev/tty 2>/dev/null

# Clean the file by removing any lines that match a JSON success response (usually from i3-msg output)
sed -i '/^\[{"success":.*\}]$/d' "$filename"
