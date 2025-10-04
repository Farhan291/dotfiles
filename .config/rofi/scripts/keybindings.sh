#!/bin/bash

cat << 'EOF' | rofi -dmenu -i -theme ~/.config/rofi/current.rasi -p "  Keybindings" -theme-str 'window {width: 800px;} listview {lines: 15;}'
SUPER + Q - Close Window
SUPER + R - Waybar reload
SUPER + E - File manager
SUPER + W - Firefox
SUPER + SHIFT + W - Wifi
SUPER + SHIFT + B - Bluetooth
SUPER + C - VSCODE
SUPER + Return - Terminal
SUPER + D - App Launcher
SUPER + SHIFT + A - Wallpaper Selector
SUPER + A - Random Wallpaper
SUPER + V - Toggle Floating
SUPER + M - Exit
SUPER + N - Notification Center
SUPER + L - Lock Screen
SUPER + SHIFT + S - Screenshot 
SUPER + SHIFT + V - Clipboard
SUPER + [1-9] - Switch Workspace
SUPER + SHIFT + [1-9] - Move to Workspace
SUPER + Mouse - Move/Resize Window
SUPER + Tab - Window Switcher
F10 - Screenshot Full Screen
EOF
