#!/usr/bin/env bash
# Which tunnel is up: N = corporate openvpn (nvpn), H = hiddify (hvpn).
#
# N is detected exactly the way the _hvpn shell function does it — an
# interface holding a 10.155.0.0/16 address — so the two never disagree.
# Output width is constant, so the bar never shifts.

UP="#b8bb26"
OFF="#504945"

ip -o -4 addr show | awk '$4 ~ /^10\.155\./ {found=1} END {exit !found}' \
    && n="$UP" || n="$OFF"
pgrep -x hiddify >/dev/null && h="$UP" || h="$OFF"

# printf is not usable here: polybar's %{...} markup collides with its
# format specifiers.
echo "%{F#8ec07c}%{F-} %{F$n}N%{F-}%{F$h}H%{F-}"
