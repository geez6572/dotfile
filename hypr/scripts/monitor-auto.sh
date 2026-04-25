#!/bin/bash

# Get list of connected monitors
MONITORS=$(hyprctl monitors | grep -E "^Monitor (eDP|DP|HDMI|VGA)" | awk '{print $2}')

# Check if any external monitor is connected (not eDP-1)
EXTERNAL_CONNECTED=false
for monitor in $MONITORS; do
    if [[ $monitor != "eDP-1" ]]; then
        EXTERNAL_CONNECTED=true
        break
    fi
done

# Control laptop screen based on external monitor status
if [[ $EXTERNAL_CONNECTED == true ]]; then
    # External monitor connected, disable laptop screen
    hyprctl keyword monitor "eDP-1,disable"
else
    # No external monitor, enable laptop screen
    hyprctl keyword monitor "eDP-1,preferred,auto,1"
fi
