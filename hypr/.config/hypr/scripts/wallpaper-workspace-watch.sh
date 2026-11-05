#!/usr/bin/env bash

while true; do
    declare -A windows_by_monitor

    while IFS=$'\t' read -r monitor windows; do
        windows_by_monitor["$monitor"]=$windows
    done < <(
        hyprctl -j monitors | python -c '
import json
import subprocess
import sys

monitors = json.load(sys.stdin)
clients = json.loads(subprocess.check_output(["hyprctl", "-j", "clients"]))

for monitor in monitors:
    workspace_id = monitor["activeWorkspace"]["id"]
    count = sum(
        1 for client in clients
        if client["workspace"]["id"] == workspace_id
    )
    print("{}\t{}".format(monitor["name"], count))'
    )

    while read -r wallpaper_pid; do
        [[ -z "$wallpaper_pid" ]] && continue

        args=$(ps -o args= -p "$wallpaper_pid")

        if [[ "$args" =~ --screen-root[[:space:]]+([^[:space:]]+) ]]; then
            monitor="${BASH_REMATCH[1]}"
            windows="${windows_by_monitor[$monitor]:-0}"

            if (( windows > 0 )); then
                kill -STOP "$wallpaper_pid" 2>/dev/null
            else
                kill -CONT "$wallpaper_pid" 2>/dev/null
            fi
        fi
    done < <(pgrep -f '[l]inux-wallpaperengine.*--screen-root')

    sleep 1
done

