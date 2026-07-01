show_file_or_dir_preview="
    if [ -d {} ]; then
        eza --tree --color=always --icons=always {} | head -200;
    else
        bat -n --color=always --line-range :500 {};
    fi"

    # --info inline
    # --height 40%
export FZF_DEFAULT_OPTS="
    --layout reverse
    --bind 'shift-up:preview-half-page-up,shift-down:preview-half-page-down'
    --bind 'alt-up:preview-top,alt-down:preview-bottom'"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_R_OPTS="
    --preview 'echo {}'
    --preview-window 'up:3:hidden:wrap'
    --bind 'ctrl-/:toggle-preview'
    --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
    --color header:italic
    --header 'CTRL-Y: copy | CTRL-/: preview'"

export FZF_CTRL_T_OPTS="
    --preview '$show_file_or_dir_preview'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --bind 'ctrl-y:execute-silent(echo -n {} | xclip -selection clipboard)+abort'
    --bind 'alt-e:execute(\$EDITOR {} < /dev/tty > /dev/tty 2>&1)+abort'
    --bind 'ctrl-o:execute-silent(xdg-open {} &)'
    --bind 'focus:bg-transform-preview-label:[[ -n {} ]] && printf \" %s \" {}'
    --color header:italic
    --header 'CTRL-/: preview | CTRL-Y: copy path | ALT-E: edit | CTRL-O: open'"

export FZF_ALT_C_OPTS="
    --bind 'focus:bg-transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}'
    --preview 'eza --tree --color=always --icons=always {} | head -200'"

# Zoxide integration
export _ZO_FZF_OPTS="
    --no-multi
    --delimiter ' '
    --preview 'eza --tree --icons=always --level=1 --color=always {2} | head -200'
    --preview-window='right:40%:wrap'
    --bind 'focus:bg-transform-preview-label:[[ -n {} ]] && printf \" %s \" {2}'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always --icons=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh|telnet)   fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Live ripgrep search: type to filter, Enter to open in $EDITOR at exact line
rfv() {
  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
  local INITIAL_QUERY="${*:-}"
  fzf --ansi \
      --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --bind 'ctrl-/:change-preview-window(down|hidden|)' \
      --delimiter : \
      --preview 'bat --color=always {1} --line-range {2}: --highlight-line {2}' \
      --preview-window 'right:60%:border-left:+{2}+3/3:~3' \
      --header 'Live grep | CTRL-/: preview' \
      --bind 'enter:become($EDITOR +{2} {1})'
}

# Kill process by port
fkp() {
  local port="${1:-}"
  local pid
  pid=$(lsof -i "${port:+:$port}" -sTCP:LISTEN -n -P 2>/dev/null \
    | sed 1d \
    | fzf --header='Select process to kill by port' \
    | awk '{print $2}')
  [[ -n "$pid" ]] && kill -${2:-9} "$pid"
}

# Kill process interactively
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --header='Select process to kill' | awk '{print $2}')
  [[ -n "$pid" ]] && echo "$pid" | xargs kill -${1:-9}
}
