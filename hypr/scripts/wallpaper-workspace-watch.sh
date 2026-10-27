#!/usr/bin/env bash

while true; do
    wallpaper_pid=$(pgrep -f '^./linux-wallpaperengine --screen-root HDMI-A-1' | head -n 1)

    if [[ -n "$wallpaper_pid" ]]; then
        windows=$(hyprctl -j activeworkspace | python -c \
            'import json, sys; print(json.load(sys.stdin)["windows"])')

        if (( windows > 0 )); then
            kill -STOP "$wallpaper_pid" 2>/dev/null
        else
            kill -CONT "$wallpaper_pid" 2>/dev/null
        fi
    fi

    sleep 1
done

