#!/bin/bash

# Terminate already running compton instances
killall -q picom

# Wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

# Launch picom in background
picom -b

echo "Picom launched..."
