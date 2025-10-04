#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpaper"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)

swww img "$WALLPAPER" --transition-type wipe --transition-duration 2
notify-send "Wallpaper Changed" "$(basename "$WALLPAPER")" -i "$WALLPAPER"
