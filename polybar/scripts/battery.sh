#!/usr/bin/env sh
# Battery readout for polybar. Prints nothing while the mains adapter is
# online, so the bar carries the module only when actually running on battery.
# internal/battery cannot do this: with a charge threshold the kernel reports
# "Not charging" on AC, which polybar maps to its discharging state.
PS=/sys/class/power_supply

[ "$(cat $PS/ADP1/online 2>/dev/null)" = 1 ] && exit 0

cap=$(cat $PS/BAT1/capacity 2>/dev/null) || exit 0

case $cap in
    [0-9]|1[0-9]|20) col='#fb4934' ;;
    2[1-9]|3[0-9]|40) col='#fe8019' ;;
    *) col='#d4be98' ;;
esac

now=$(cat $PS/BAT1/charge_now 2>/dev/null)
cur=$(cat $PS/BAT1/current_now 2>/dev/null)
left=
if [ "${cur:-0}" -gt 0 ]; then
    left=$(awk -v n="$now" -v c="$cur" 'BEGIN{m=n*60/c; printf " %d:%02d", m/60, m%60}')
fi

printf '%%{F%s}\357\211\200%%{F-}%%{O2}%s%%%s\n' "$col" "$cap" "$left"
