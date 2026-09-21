#!/usr/bin/env bash
# Launch polybar, restarting cleanly on i3 reload/restart.

killall -q polybar

while pgrep -u "$UID" -x polybar >/dev/null; do
    sleep 1
done

CONFIG="$HOME/dotfiles/polybar/config.ini"

if type xrandr >/dev/null 2>&1; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload main -c "$CONFIG" &
    done
else
    polybar --reload main -c "$CONFIG" &
fi
