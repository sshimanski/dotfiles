# Russian layout support: mirror every keybinding onto the Cyrillic character
# that sits on the same physical key, so hjkl, gg, dD and the ,-leader chords
# keep working with the Russian group active.
#
# ranger reads raw bytes from curses, so a Cyrillic key arrives as a two-byte
# UTF-8 sequence: the mirrored branch is nested one level deeper than its Latin
# original. The Latin bindings are left untouched, and both branches point at
# the same leaf objects, so mixed-layout chords resolve too.
#
# The console context is deliberately not mirrored - there letters are text.

from __future__ import (absolute_import, division, print_function)

import ranger.api

LATIN_LOWER = "qwertyuiop[]asdfghjkl;'zxcvbnm,.`"
CYRILLIC_LOWER = u"йцукенгшщзхъфывапролджэячсмитьбюё"
LATIN_UPPER = 'QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>~'

CONTEXTS = ("browser", "pager", "taskview")

# The Russian group does not put a Cyrillic letter on every key: AB10 carries
# slash/question on the Latin group but period/comma on the Russian one, so a
# Russian "/" reaches ranger as a bare ".". Both are the same byte and ranger
# cannot tell them apart, so "." is aliased onto whatever "/" does. That costs
# the stock "." filter-stack prefix (rc.conf ships .d, .f, .l, .. and friends);
# deliberate, nothing here uses it.
ASCII_ALIASES = {".": "/"}
ALIASES = {ord(dst): ord(src) for dst, src in ASCII_ALIASES.items()}


def _build_translation():
    pairs = list(zip(LATIN_LOWER, CYRILLIC_LOWER))
    pairs += list(zip(LATIN_UPPER, CYRILLIC_LOWER.upper()))
    return {ord(lat): tuple(bytearray(cyr.encode("utf-8"))) for lat, cyr in pairs}


TRANSLATION = _build_translation()


def _mirror(node, seen):
    if id(node) in seen:
        return
    seen.add(id(node))
    for sub in list(node.values()):
        if isinstance(sub, dict):
            _mirror(sub, seen)
    for dst, src in ALIASES.items():
        if src in node:
            node[dst] = node[src]
    for key, leaf in list(node.items()):
        target = TRANSLATION.get(key)
        if target is None:
            continue
        first, second = target
        branch = node.get(first)
        if branch is None:
            branch = node[first] = {}
        elif not isinstance(branch, dict):
            # something already claimed that byte as a binding of its own
            continue
        branch.setdefault(second, leaf)


HOOK_INIT_OLD = ranger.api.hook_init


def hook_init(fm):
    for context in CONTEXTS:
        node = fm.ui.keymaps.get(context)
        if isinstance(node, dict):
            _mirror(node, set())
    return HOOK_INIT_OLD(fm)


ranger.api.hook_init = hook_init
