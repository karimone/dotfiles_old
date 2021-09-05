#!/bin/bash

# Terminate already running udiskie instances
killall -q pa-applet

# Wait until the processes have been shut down
while pgrep -u $UID -x pa-applet >/dev/null; do sleep 1; done

# Launch compton in background, using default config location ~/.config/compton/compton.conf
pa-applet &

echo "pa-applet launched..."
