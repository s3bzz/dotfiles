#!/bin/bash

# Get the direction of the scroll (+/- for up/down)
direction="$1"

# Define the volume change step (adjust as needed)
step=5

# Get the current volume
current_volume=$(pactl get-sink-volume @DEFAULT_SINK% | grep -Eo '[0-9]+')

# Calculate the new volume based on direction and step
if [[ $direction == "+" ]]; then
  new_volume=$((current_volume + step))
elif [[ $direction == "-" ]]; then
  new_volume=$((current_volume - step))
fi

# Ensure volume stays within bounds (0-100%)
new_volume=$(echo "$new_volume" | tr -d '\r' | awk '{ printf("%.0f", ($1 > 100 ? 100 : ($1 < 0 ? 0 : $1))) }')

# Set the new volume
pactl set-sink-volume @DEFAULT_SINK% $new_volume%

# Update Polybar (optional)
# (Replace 'my_polybar_hook' with your actual Polybar hook command)
# my_polybar_hook

