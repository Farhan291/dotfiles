#!/bin/bash

notify-send "Hyprland" "Reloading configuration..."

# Reload Hyprland
hyprctl reload

# Restart waybar
killall waybar
waybar &

# Restart swaync
killall swaync
swaync &

notify-send "Hyprland" "Reload complete!" -t 3000
