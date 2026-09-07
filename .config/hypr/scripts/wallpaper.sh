#!/bin/bash
# wall – change wallpaper (swww) + generate permanent pywal palette

set -e
WALLPAPER_DIR="$HOME/Pictures/Wallpaper"

# 1. pick random wall
WALL=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
[[ -z $WALL ]] && { notify-send -u critical wall "No image found"; exit 1; }

# 2. set wallpaper
swww img "$WALL" --transition-type wipe --transition-duration 2

# 3. generate palette (skip pywal's own feh/swww call)
wal -i "$WALL" -n -q                 # -n = no wallpaper call, -q = quiet

# 4. export to every place that can receive colours ------------------------

# a) already-running terminals
(cat ~/.cache/wal/sequences &)       # kitty, alacritty, wezterm, foot, etc.

# b) GTK / Qt / Flatpak
gsettings set org.gnome.desktop.interface gtk-theme "Pywal-GTK"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
flatpak override --user --env=GTK_THEME=Pywal-GTK 2>/dev/null || true

# c) Waybar (if running)
systemctl --user is-active waybar.service && pkill -USR1 waybar

# d) Hyprland border / group / window colours (live reload)
hyprctl reload

# e) TTY escape sequences (so new terminals inherit palette)
tty_escape_file="$HOME/.cache/wal/tty-sequences"
[[ -f $tty_escape_file ]] && cat "$tty_escape_file" > /dev/tty

# 5. notify
notify-send -i "$WALL" "Wallpaper" "$(basename "$WALL")"
