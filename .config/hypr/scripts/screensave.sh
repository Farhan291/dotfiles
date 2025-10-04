#!/bin/bash

FILENAME="$HOME/Pictures/Screenshots/screenshot_$(date +%Y%m%d_%H%M%S).png"

grimblast save screen "$FILENAME"

notify-send "Screenshot" "Screen saved to $(basename $FILENAME)" -t 2000
