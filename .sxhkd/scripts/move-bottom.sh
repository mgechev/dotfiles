#!/bin/bash
# move-bottom.sh: Move the active window to the bottom half of the screen.

# Get the ID of the active window
ACTIVE_WIN_ID=$(xdotool getactivewindow)
if [ -z "$ACTIVE_WIN_ID" ]; then exit 1; fi

# Un-maximize window first to allow moving/resizing
wmctrl -ir "$ACTIVE_WIN_ID" -b remove,maximized_vert,maximized_horz

# Get primary monitor geometry using xrandr (e.g., "1920x1080")
SCREEN_GEOM=$(xrandr --current | grep ' primary' | awk '{print $4}' | cut -d'+' -f1)
# Fallback if no primary monitor is set
if [ -z "$SCREEN_GEOM" ]; then
    SCREEN_GEOM=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
fi

# Extract Width and Height from geometry
SCREEN_W=$(echo "$SCREEN_GEOM" | cut -d'x' -f1)
SCREEN_H=$(echo "$SCREEN_GEOM" | cut -d'x' -f2)

# Exit if any of the crucial variables are not integers
if ! [[ "$SCREEN_W" =~ ^[0-9]+$ && "$SCREEN_H" =~ ^[0-9]+$ ]]; then
    exit 1
fi

# Calculate new dimensions and position for BOTTOM half of the entire screen
NEW_WIDTH=$SCREEN_W
NEW_HEIGHT=$((SCREEN_H / 2))
NEW_X=0
NEW_Y=$((SCREEN_H / 2))

# Add a tiny delay to allow the window manager to process the un-maximize command
sleep 0.1

# Use a chained xdotool command for a more atomic move and resize.
xdotool windowsize "$ACTIVE_WIN_ID" "$NEW_WIDTH" "$NEW_HEIGHT" windowmove "$ACTIVE_WIN_ID" "$NEW_X" "$NEW_Y"


