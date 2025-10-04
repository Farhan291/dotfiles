#!/bin/bash
power_on() { bluetoothctl power on; }
power_off() { bluetoothctl power off; }

if ! bluetoothctl show | grep -q "Powered: yes"; then
    power_on
fi

DEVICES=$(bluetoothctl devices | awk '{$1=""; print substr($0,2)}')
CHOSEN=$(echo -e "  Turn Off Bluetooth\n$DEVICES" | rofi -dmenu -i -theme ~/.config/rofi/current.rasi -p "Bluetooth")

if [ "$CHOSEN" = "  Turn Off Bluetooth" ]; then
    power_off
    notify-send "Bluetooth" "Turned off"
elif [ -n "$CHOSEN" ]; then
    MAC=$(bluetoothctl devices | grep "$CHOSEN" | awk '{print $2}')
    bluetoothctl connect "$MAC" && \
        notify-send "Bluetooth" "Connected to $CHOSEN" || \
        notify-send "Bluetooth" "Failed to connect"
fi
