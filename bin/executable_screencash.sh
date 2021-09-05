#!/bin/bash
filename="output.mkv"

ffmpeg -y \
-f x11grab \
-s $(xdpyinfo | grep dimensions | awk '{print $2;}') \
-i :0.0 \
-f alsa -i default \
-c:v ffvhuff -r 30 -c:a flac $filename
