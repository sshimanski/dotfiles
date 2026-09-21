#!/usr/bin/env bash
# Streams the active layout name from the already-running kbdd daemon
# (same dbus service the i3blocks kbdd_layout block reads), normalized
# to RU/EN. Does not touch/restart kbdd itself.
#
# dbus-monitor carries a layout switch instantly; the poll loop re-syncs after
# the events kbdd does not signal — xkbcomp re-applying the keymap on i3 reload
# resets the active group to the first one silently, and kbdd may be restarted underneath us.

normalize() {
    local trimmed="${1#"${1%%[![:space:]]*}"}"
    case "$trimmed" in
        Rus*) echo "RU" ;;
        Eng*) echo "EN" ;;
        *) echo "$trimmed" ;;
    esac
}

get_current() {
    local n
    n=$(dbus-send --print-reply=literal --dest=ru.gentoo.KbddService \
        /ru/gentoo/KbddService ru.gentoo.kbdd.getCurrentLayout 2>/dev/null |
        sed -un 's/^.*uint32 //p')
    [[ -z "$n" ]] && return 1
    dbus-send --print-reply=literal --dest=ru.gentoo.KbddService \
        /ru/gentoo/KbddService ru.gentoo.kbdd.getLayoutName uint32:"$n" 2>/dev/null
}

# prints the current layout, or fails silently while kbdd is down or answers
# an empty name (it does that for a group it did not know at startup)
emit_current() {
    local name
    name=$(get_current) || return 1
    [[ -z "${name//[[:space:]]/}" ]] && return 1
    normalize "$name"
}

until emit_current; do sleep 0.2; done

# safety net; exits on its own once polybar has killed the script
main=$$
while sleep 2; do
    kill -0 "$main" 2>/dev/null || exit 0
    emit_current
done &

dbus-monitor "interface='ru.gentoo.kbdd',member='layoutNameChanged'" 2>/dev/null |
    grep -Po --line-buffered '(?<=string ")\w*' |
    while read -r name; do [[ -n "$name" ]] && normalize "$name"; done
