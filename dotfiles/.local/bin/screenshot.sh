#!/bin/bash

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

FILENAME="Screenshot-$(date +%Y%m%d-%H%M%S).png"
FILEPATH="$SCREENSHOT_DIR/$FILENAME"

GEOMETRY=$(slurp -o 2>/dev/null)

if [ -z "$GEOMETRY" ]; then
	notify-send "Screenshot" "Canceled" -t 1000
	exit 0
fi

grim -g "$GEOMETRY" "$FILEPATH" && wl-copy < "$FILEPATH"
notify-send "Screenshot" "Saved: $FILENAME" -t 2000
