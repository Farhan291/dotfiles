#!/bin/bash

# Initialize cliphist if not running
if ! pgrep -x "wl-paste" > /dev/null; then
    wl-paste --watch cliphist store &
fi

# Rofi theme integrated
rofi_theme='
configuration {
    modi: "dmenu";
    show-icons: false;
    font: "JetBrainsMono Nerd Font 11";
    drun-display-format: "{name}";
}

* {
    bg: #1e2030;
    bg-alt: rgba(45, 38, 64, 0.9);
    fg: #e0def4;
    border: #7dcfff;
    selected: #7dcfff;
    urgent: #ff757f;
    
    background-color: transparent;
    text-color: @fg;
}

window {
    width: 100%;
    height: 100%;
    background-color: rgba(30, 32, 48, 0.95);
    border: 3px;
    border-color: @border;
}

mainbox {
    padding: 64px;
    spacing: 20px;
    children: [ "inputbar", "message", "listview" ];
}

inputbar {
    padding: 150px 64px;
    spacing: 0px;
    border-radius: 8px;
    background-color: rgba(125, 220, 255, 0.1);
    border: 2px;
    border-color: @border;
    children: [ "prompt", "entry" ];
}

prompt {
    padding: 12px 20px;
    background-color: @border;
    text-color: @bg;
    border-radius: 6px 0px 0px 6px;
    font: "JetBrainsMono Nerd Font Bold 12";
}

entry {
    padding: 12px 20px;
    placeholder: "Search clipboard...";
    placeholder-color: rgba(224, 222, 244, 0.5);
    background-color: rgba(45, 38, 64, 0.6);
    border-radius: 0px 6px 6px 0px;
}

message {
    padding: 12px;
    border-radius: 8px;
    background-color: @bg-alt;
    border: 2px;
    border-color: @border;
}

textbox {
    padding: 8px;
    text-color: @border;
    font: "JetBrainsMono Nerd Font Bold 10";
}

listview {
    columns: 1;
    lines: 10;
    spacing: 8px;
    scrollbar: true;
    background-color: transparent;
}

scrollbar {
    width: 4px;
    border: 0;
    handle-color: @border;
    handle-width: 4px;
    padding: 0;
    margin: 0px 0px 0px 4px;
}

element {
    padding: 14px 16px;
    spacing: 12px;
    border-radius: 8px;
    background-color: @bg-alt;
    border: 2px;
    border-color: transparent;
}

element selected {
    background-color: rgba(125, 220, 255, 0.15);
    border-color: @border;
    text-color: @border;
}

element-text {
    background-color: transparent;
    text-color: inherit;
}
'

# Save theme to temporary file
THEME_FILE="/tmp/clipboard-theme-$$.rasi"
echo "$rofi_theme" > "$THEME_FILE"

# Show clipboard history with custom message
cliphist list | rofi -dmenu -i \
    -p "  CLIPBOARD HISTORY" \
    -mesg " [ ENTER ]  PASTE     [ DEL ]  DELETE ENTRY     [ CTRL+DEL ]  CLEAR ALL" \
    -theme "$THEME_FILE" | cliphist decode | wl-copy

# Clean up
rm -f "$THEME_FILE"

# Notify
if [ -n "$(wl-paste)" ]; then
    notify-send "Clipboard" "Content copied!" -t 2000
fi
