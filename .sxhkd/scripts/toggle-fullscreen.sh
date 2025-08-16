#!/bin/bash
# toggle-fullscreen.sh: Toggles the maximized state of the active window.

# Get the ID of the active window
ACTIVE_WIN_ID=$(xdotool getactivewindow)
if [ -z "$ACTIVE_WIN_ID" ]; then exit 1; fi

# Check if the window is currently maximized both vertically and horizontally.
# We count the occurrences of the maximized states. If the count is 2, the window is fully maximized.
MAXIMIZED_STATE_COUNT=$(xprop -id "$ACTIVE_WIN_ID" _NET_WM_STATE | grep -c -E '(_NET_WM_STATE_MAXIMIZED_VERT|_NET_WM_STATE_MAXIMIZED_HORZ)')

# If it IS fully maximized (count is 2), un-maximize it.
# If it IS NOT fully maximized, maximize it.
if [ "$MAXIMIZED_STATE_COUNT" -eq 2 ]; then
    wmctrl -ir "$ACTIVE_WIN_ID" -b remove,maximized_vert,maximized_horz
else
    # This ensures a clean state before maximizing, handling cases where a window might be only partially maximized.
    wmctrl -ir "$ACTIVE_WIN_ID" -b remove,maximized_vert,maximized_horz
    wmctrl -ir "$ACTIVE_WIN_ID" -b add,maximized_vert,maximized_horz
fi


