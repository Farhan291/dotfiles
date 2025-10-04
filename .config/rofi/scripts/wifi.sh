#!/bin/bash
notify-send "WiFi" "Scanning networks..."
WIFI_LIST=$(nmcli -f SSID,SECURITY,SIGNAL device wifi list | tail -n +2)
CHOSEN=$(echo "$WIFI_LIST" | rofi -dmenu -i -theme ~/.config/rofi/current.rasi -p "WiFi Networks" | awk '{print $1}')

if [ -n "$CHOSEN" ]; then
    PASSWORD=$(rofi -dmenu -theme ~/.config/rofi/current.rasi -password -p "Password for $CHOSEN")
    nmcli device wifi connect "$CHOSEN" password "$PASSWORD" && \
        notify-send "WiFi" "Connected to $CHOSEN" || \
        notify-send "WiFi" "Failed to connect"
fi
