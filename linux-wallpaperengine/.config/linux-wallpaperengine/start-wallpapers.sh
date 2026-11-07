#!/usr/bin/env bash

/usr/bin/linux-wallpaperengine \
    --screen-root DP-3 \
    --bg /home/michael/.config/linux-wallpaperengine/wallpapers/3706973514 \
    --assets-dir /home/michael/.config/linux-wallpaperengine/assets \
    --volume 100 &

/usr/bin/linux-wallpaperengine \
    --screen-root HDMI-A-1 \
    --bg /home/michael/.config/linux-wallpaperengine/wallpapers/3707010937 \
    --scaling fill \
    --assets-dir /home/michael/.config/linux-wallpaperengine/assets \
    --volume 0 &

wait
