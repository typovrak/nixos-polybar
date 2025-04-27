#!/usr/bin/env bash

vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

if [ -z "$vol_raw" ] || echo "$vol_raw" | grep -q "Translate id"; then
    echo "%{F#a6e3a1}VOL%{F-} N/A"
    exit 0
fi

mute=$(echo "$vol_raw" | grep -q MUTED && echo true || echo false)
percent=$(echo "$vol_raw" | grep -o '[0-9]*\.[0-9]*' | awk '{printf "%d", $1 * 100}')

if [ "$mute" = "true" ]; then
    echo "%{F#a6e3a1}MUTED%{F-}"
else
    echo "%{F#a6e3a1}VOL%{F-} $percent%"
fi
