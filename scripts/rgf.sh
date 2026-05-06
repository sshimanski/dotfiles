#!/usr/bin/env bash

cmd='command rg --column --no-heading --color=always --smart-case {q} || :'

OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
          nvim {1} +{2}     # No selection. Open the current line in Vim.
        else
          nvim +cw -q {+f}  # Build quickfix list for the selected items.
        fi'

fzf --disabled \
    --ansi \
    --multi \
    --delimiter : \
    --ghost 'Enter search term...' \
    --bind "change:reload:if [ -n {q} ]; then $cmd; else echo ''; fi" \
    --bind "start:reload:if [ -n {q} ]; then $cmd; fi" \
    --bind "enter:become:$OPENER" \
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
    --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
    --preview-window 'right:60%:~4,+{2}+4/3,border-left' \
    --header 'Enter: Open; CTRL-/: Toggle preview; ALT-A: All; ALT-D None' \
    --query "$*"
