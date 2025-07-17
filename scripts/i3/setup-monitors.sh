#!/bin/bash

# Set both to the same refresh rate to avoid flickering
xrandr --output DisplayPort-1 --primary --mode 2560x1440 --rate 239.97 --auto
xrandr --output DisplayPort-0 --mode 2560x1440 --rate 164.96 --left-of DisplayPort-1 --auto

# Disable VRR only if the output supports it
for output in DisplayPort-1 DisplayPort-0; do
    if xrandr --prop | grep -A10 "^$output" | grep -q "VRR"; then
        xrandr --output "$output" --set "VRR" 0
    fi
done

