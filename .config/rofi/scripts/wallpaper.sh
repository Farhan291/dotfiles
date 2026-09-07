#!/bin/bash
# wall – rofi-powered wallpaper picker + global pywal colours

set -e
WALLPAPER_DIR="$HOME/Pictures/Wallpaper"

# ---- 1. build rofi list ----
mapfile -t WALLS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort)
[ ${#WALLS[@]} -eq 0 ] && {
    notify-send -u critical "Wallpaper" "No images found"; exit 1
}

# basename-only menu (keeps full path in array)
for w in "${WALLS[@]}"; do echo "${w##*/}"; done \
| rofi -dmenu -i -p "Wallpaper" \
       -theme ~/.config/rofi/current.rasi \
       -theme-str 'window {width: 600px;} listview {lines: 10;}' \
> /tmp/wall_choice.txt || exit 1          # user pressed Esc

CHOICE=$(cat /tmp/wall_choice.txt)
[ -z "$CHOICE" ] && exit 0

# ---- 2. recover full path ----
for w in "${WALLS[@]}"; do
    [[ ${w##*/} == "$CHOICE" ]] && WALL="$w" && break
done
[ -f "$WALL" ] || { notify-send -u critical "Wallpaper" "File gone"; exit 1; }

# ---- 3. set wallpaper ----
swww img "$WALL" --transition-type wipe --transition-duration 2

# ---- 4. generate & broadcast palette ----
wal -i "$WALL" -n -q          # -n = skip feh/swww call, -q = quiet
kitty @ set-colors -a ~/.cache/wal/kitty.conf

# a) live terminals
(cat ~/.cache/wal/sequences &)

# b) GTK / Qt / Flatpak
gsettings set org.gnome.desktop.interface gtk-theme "Pywal-GTK"
flatpak override --user --env=GTK_THEME=Pywal-GTK 2>/dev/null || true

# c) Waybar
systemctl --user is-active waybar.service && pkill -USR1 waybar

# d) Hyprland border / group colours
hyprctl reload

# e) TTY palette (new consoles)
[ -f ~/.cache/wal/tty-sequences ] && cat ~/.cache/wal/tty-sequences > /dev/tty

# ---- 5. notify ----
notify-send -i "$WALL" "Wallpaper" "$CHOICE" -t 3000
