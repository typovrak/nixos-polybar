{ config, pkgs, ... }:

let
	username = "typovrak";
	group = config.users.users.${username}.group or "users";
	home = config.users.users.${username}.home;
in {
	system.activationScripts.polybar = ''
		mkdir -p ${home}/.config/polybar
		cat > ${home}/.config/polybar/config.ini << EOF
[global/wm]
include-file = "${home}/.config/polybar/mocha.ini"

[colors]
background = ''\$''\{colors.base''\}
background-alt = ''\$''\{colors.surface0''\}
foreground = ''\$''\{colors.text''\}
primary = ''\$''\{colors.green''\}
secondary = ''\$''\{colors.red''\}
alert = ''\$''\{colors.red''\}
disabled = ''\$''\{colors.overlay0''\}

[bar/main]
width = 100%
height = 18pt
background = ''\$''\{colors.background''\}
foreground = ''\$''\{colors.foreground''\}
line-size = 3pt
padding-right = 1
module-margin = 1
separator = |
separator-foreground = ''\$''\{colors.disabled''\}
font-0 = JetBrainsMono Nerd Font:pixelsize=10;1
modules-left = xworkspaces xwindow
modules-right = cpu temperature memory speedtest-down speedtest-up audio brightnessctl wlan battery date
cursor-click = pointer
cursor-scroll = ns-resize
enable-ipc = true

[module/xworkspaces]
type = internal/xworkspaces
label-active = %name%
label-active-background = ''\$''\{colors.background-alt''\}
label-active-underline= ''\$''\{colors.primary''\}
label-active-padding = 1
label-occupied = %name%
label-occupied-padding = 1
label-urgent = %name%
label-urgent-background = ''\$''\{colors.alert''\}
label-urgent-padding = 1
label-empty = %name%
label-empty-foreground = ''\$''\{colors.disabled''\}
label-empty-padding = 1

[module/xwindow]
type = internal/xwindow
label = %title:0:60:...%

[module/audio]
type = custom/script
exec = ${home}/.config/polybar/audio.sh
interval = 1

[module/memory]
type = internal/memory
interval = 1
label = %{F#a6e3a1}RAM%{F-} %percentage_used%%
warn-percentage = 90
label-warn = %{F#f38ba8}RAM%{F-} %percentage%%

[module/cpu]
type = internal/cpu
interval = 1
label = %{F#a6e3a1}CPU%{F-} %percentage%%
warn-percentage = 90
label-warn = %{F#f38ba8}CPU%{F-} %percentage%%

[module/wlan]
type = internal/network
interface-type = wireless
interval = 1
label-connected = %{F#a6e3a1}WLAN0%{F-} %essid%
label-disconnected = %{F#f38ba8}WLAN0%{F-} disconnected

[module/date]
type = internal/date
interval = 1
date = %H:%M
date-alt = %Y-%m-%d %H:%M:%S
label = %date%
label-foreground = ''\$''\{colors.primary''\}

[module/brightnessctl]
type = custom/script
exec = ${home}/.config/polybar/brightnessctl.sh
interval = 1
label = %{F#a6e3a1}LUM%{F-} %output%
label-foreground = ''\$''\{colors.foreground''\}

[speedtest-base]
type = internal/network
interface = wlan0
interface-type = wireless
interval = 1
label-foreground = ''\$''\{colors.foreground''\}

[module/speedtest-down]
inherit = speedtest-base
label-connected = %{F#a6e3a1}DOWN%{F-} %downspeed%
label-disconnected = %{F#f38ba8}DOWN%{F-} disconnected

[module/speedtest-up]
inherit = speedtest-base
label-connected = %{F#a6e3a1}UP%{F-} %upspeed%
label-disconnected = %{F#f38ba8}UP%{F-} disconnected

[module/battery]
type = internal/battery
# ls -1 /sys/class/power_supply/
battery = BAT0
adapter = AC0
poll-interval = 5
label-charging = %{F#a6e3a1}POW%{F-} %percentage%%
label-discharging = %{F#a6e3a1}POW%{F-} %percentage%%
label-full = %{F#a6e3a1}POW%{F-} %percentage%%
label-low = %{F#f38ba8}POW%{F-} %percentage%%

[module/temperature]
type = internal/temperature
# for i in /sys/class/thermal/thermal_zone*; do echo "$i: $(<$i/type)"; done
thermal-zone = 4
zone-type = x86_pkg_temp
label = %{F#a6e3a1}TEMP%{F-} %temperature-c%
label-warn = %{F#f38ba8}TEMP%{F-} %temperature-c%

[settings]
screenchange-reload = true
pseudo-transparency = true
EOF
		chown ${username}:${group} ${home}/.config/polybar/config.ini
		chmod 644 ${home}/.config/polybar/config.ini

		cat > ${home}/.config/polybar/mocha.ini << EOF
[colors]
rosewater = #f5e0dc
flamingo = #f2cdcd
pink = #f5c2e7
mauve = #cba6f7
red = #f38ba8
maroon = #eba0ac
peach = #fab387
yellow = #f9e2af
green = #a6e3a1
teal = #94e2d5
sky = #89dceb
sapphire = #74c7ec
blue = #89b4fa
lavender = #b4befe
text = #cdd6f4
subtext1 = #bac2de
subtext0 = #a6adc8
overlay2 = #9399b2
overlay1 = #7f849c
overlay0 = #6c7086
surface2 = #585b70
surface1 = #45475a
surface0 = #313244
base = #1e1e2e
mantle = #181825
crust = #11111b
transparent = #FF00000
EOF
		chown ${username}:${group} ${home}/.config/polybar/mocha.ini
		chmod 644 ${home}/.config/polybar/mocha.ini

		cat > ${home}/.config/polybar/audio.sh << EOF
#!/bin/bash

vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
mute=$(echo "$vol_raw" | grep -q MUTED && echo true || echo false)
percent=$(echo "$vol_raw" | grep -o '[0-9]*\.[0-9]*' | awk '{printf "%d", $1 * 100}')

if [ "$mute" = "true" ]; then
    echo "%{F#a6e3a1}MUTED%{F-}"
else
    echo "%{F#a6e3a1}VOL%{F-} $percent%"
fi
EOF
		chown ${username}:${group} ${home}/.config/polybar/audio.sh
		chmod 755 ${home}/.config/polybar/audio.sh

		cat > ${home}/.config/polybar/brightnessctl.sh << EOF
#!/bin/bash

echo `brightnessctl | grep -o "(.*" | tr -d "()"`
EOF
		chown ${username}:${group} ${home}/.config/polybar/brightnessctl.sh
		chmod 755 ${home}/.config/polybar/brightnessctl.sh

	'';

	environment.systemPackages = with pkgs; [
		polybar
	];
}
