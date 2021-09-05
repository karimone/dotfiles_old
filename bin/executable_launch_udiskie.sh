#!/bin/bash

# Terminate already running udiskie instances
killall -q udiskie

# Wait until the processes have been shut down
while pgrep -u $UID -x udiskie >/dev/null; do sleep 1; done

# Launch compton in background, using default config location ~/.config/compton/compton.conf
udiskie -t -c ~/.config/udiskie/config &

echo "Udiskie launched..."
