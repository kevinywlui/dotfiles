#!/usr/bin/env bash

# Detect monitors
INTERNAL="eDP-1"
EXTERNAL="DP-2"

# Check if external monitor is connected
if xrandr | grep -q "$EXTERNAL connected"; then
    # External monitor connected: scale it by 2x2 to match 192 DPI
    xrandr --output "$INTERNAL" --auto --primary \
           --output "$EXTERNAL" --auto --scale 2x2 --right-of "$INTERNAL"
else
    # Only internal monitor
    xrandr --output "$INTERNAL" --auto --primary --output "$EXTERNAL" --off
fi
