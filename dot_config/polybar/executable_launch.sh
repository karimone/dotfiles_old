#!/usr/bin/env sh
set -x

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 3; done

MONITOR_CONNECTED=$(xrandr --query | grep " connected" | cut -d" " -f1| wc -l) 

EDP1="eDP1"
HDMI1="HDMI1"

# Launch bar1 and bar2
if [[ MONITOR_CONNECTED -eq 2 ]]; then
    MONITOR=$EDP1 TRAY_POS="none" polybar top -c ~/.config/polybar/config-top.ini &\
    MONITOR=$EDP1 TRAY_POS="none" polybar bottom -c ~/.config/polybar/config-bottom.ini &
    MONITOR=$HDMI1 TRAY_POS="right" polybar top -c ~/.config/polybar/config-top.ini &\
    MONITOR=$HDMI1 TRAY_POS="right" polybar bottom -c ~/.config/polybar/config-bottom.ini;
else
    MONITOR=$EDP1 TRAY_POS="right" polybar top -c ~/.config/polybar/config-top.ini & \
    MONITOR=$EDP1 TRAY_POS="right" polybar bottom -c ~/.config/polybar/config-bottom.ini;
fi
