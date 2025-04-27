#!/usr/bin/env bash

echo "TESTTTTTTTTTT"
exit 0

vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if [ -z "$vol_raw" ]; then
    echo "%{F#a6e3a1}VOL%{F-} N/A"
    exit 0
fi

percent=$(echo "$vol_raw" | grep -o '[0-9]*\.[0-9]*' | awk '{printf "%d", $1 * 100}')

if [ -z "$vol_raw" ]; then
    echo "%{F#a6e3a1}VOL%{F-} N/A"
    exit 0
fi

mute=$(echo "$vol_raw" | grep -q MUTED && echo true || echo false)

if [ "$mute" = "true" ]; then
    echo "%{F#a6e3a1}MUTED%{F-}"
else
    echo "%{F#a6e3a1}VOL%{F-} $percent%"
fi
