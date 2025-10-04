#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpaper"

# Get all wallpapers
WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort)

# Check if directory has wallpapers
if [ -z "$WALLPAPERS" ]; then
    notify-send "Wallpaper Selector" "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Create rofi menu with image names
SELECTED=$(echo "$WALLPAPERS" | while read -r wallpaper; do
    basename "$wallpaper"
done | rofi -dmenu -i -theme ~/.config/rofi/current.rasi -p "Select Wallpaper" \
    -theme-str 'window {width: 600px;} listview {lines: 10;}')

# If something was selected
if [ -n "$SELECTED" ]; then
    WALLPAPER_PATH=$(echo "$WALLPAPERS" | grep "$SELECTED$")
    
    if [ -f "$WALLPAPER_PATH" ]; then
        swww img "$WALLPAPER_PATH" --transition-type wipe --transition-duration 2
        notify-send "Wallpaper Changed" "$SELECTED" -i "$WALLPAPER_PATH" -t 3000
    fi
fi
