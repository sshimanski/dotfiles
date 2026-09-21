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
    --preview 'echo {2..}'
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

# Zoxide integration.
# zoxide REPLACES FZF_DEFAULT_OPTS with _ZO_FZF_OPTS instead of merging, so
# everything zi needs is repeated here: the global layout/binds above plus
# zoxide's own defaults (--exact --no-sort --cycle --keep-right --exit-0),
# which are dropped as soon as this variable is set.
# --delimiter is not settable: zoxide always passes --delimiter=<TAB> --nth=2.
export _ZO_FZF_OPTS="
    --layout=reverse
    --exact
    --no-sort
    --cycle
    --keep-right
    --exit-0
    --preview 'eza --tree --icons=always --level=1 --color=always {2} | head -200'
    --preview-window='right:40%:wrap'
    --bind 'tab:down,btab:up,ctrl-z:ignore'
    --bind 'shift-up:preview-half-page-up,shift-down:preview-half-page-down'
    --bind 'alt-up:preview-top,alt-down:preview-bottom'
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

# Interactive process killer (procs + fzf).
#   kp [query]      fuzzy search over every process; TAB selects several
#   kp :8080        only what listens on that TCP port
#   kp -9 [query]   send SIGKILL instead of the default SIGTERM
kp() {
  emulate -L zsh

  local sig=TERM
  [[ $1 == -[0-9A-Za-z]* ]] && { sig=${1#-}; shift }

  local list='procs --color always'
  if [[ $1 == :<-> ]]; then
    local port=${1#:}
    local -a lpids=(${(f)"$(lsof -ti":$port" -sTCP:LISTEN 2>/dev/null)"})
    (( $#lpids )) || { print -u2 "kp: nothing listens on :$port"; return 1 }
    list+=" --or ${lpids}"
    shift
  fi

  local -a pids
  pids=(${(f)"$(fzf --ansi --multi --query "${1:-}" \
      --header-lines=2 \
      --header "ENTER: kill -$sig | TAB: select | CTRL-R: reload" \
      --preview 'procs --color always --tree --insert TcpPort {1}' \
      --preview-window='right:45%:wrap' \
      --bind "start:reload($list)" \
      --bind "ctrl-r:reload($list)" \
      </dev/null | awk '{print $1}')"})

  (( $#pids )) || return 1

  local pid name rc=0
  for pid in $pids; do
    [[ $pid == <-> ]] || continue
    (( pid == $$ )) && { print -u2 "kp: skipping this shell ($pid)"; continue }
    name=$(ps -o comm= -p $pid 2>/dev/null)
    if kill -$sig $pid 2>/dev/null; then
      print "kp: -$sig -> $pid ${name:+($name)}"
    else
      print -u2 "kp: could not signal $pid ${name:+($name)}"
      rc=1
    fi
  done
  return $rc
}

# ── fzf-tab ───────────────────────────────────────────────────────────────────
# Replaces zsh's completion menu with fzf for EVERY completion (branches, units,
# containers, PIDs, variables, flags), not just the `**<TAB>` trigger from fzf.
# Configured here rather than in .zshrc because these styles must win over
# oh-my-zsh's own, and this file is sourced after oh-my-zsh.

# omz sets `menu select` on ':completion:*:*:*:*:*' (lib/completion.zsh), a more
# specific pattern than ':completion:*', so it has to be reset on both.
zstyle ':completion:*' menu no
zstyle ':completion:*:*:*:*:*' menu no
# descriptions become fzf-tab's group headers; no escape sequences allowed here
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' group-name ''
# omz sets list-colors to '' - restore real colors for file candidates
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# keep git's own branch order instead of sorting alphabetically
zstyle ':completion:*:git-checkout:*' sort false

zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' show-group brief
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' fzf-min-height 15
zstyle ':fzf-tab:*' fzf-pad 4
zstyle ':fzf-tab:*' fzf-flags --preview-window='right:55%:wrap' --bind='ctrl-/:toggle-preview'

# `/` accepts the current path and keeps completing, so whole paths are typed
# without leaving fzf
zstyle ':fzf-tab:complete:(cd|z|zi|ls|eza|nvim|vim|bat|cat|less|cp|mv|rm|trash-put|chmod|chown|du|tar|unzip):*' continuous-trigger '/'

# Previews. $realpath/$word/$desc/$group are exported by fzf-tab; the preview
# runs in a fresh non-interactive zsh, so only real commands work here.
zstyle ':fzf-tab:complete:*:*' fzf-preview '
    if [[ -d $realpath ]]; then
        eza --tree --icons=always --level=1 --color=always -- $realpath | head -200
    elif [[ -f $realpath ]]; then
        bat -n --color=always --line-range :500 -- $realpath
    elif [[ -n $desc ]]; then
        print -r -- $desc
    fi'

zstyle ':fzf-tab:complete:-command-:*' fzf-preview '
    whatis -- $word 2>/dev/null | head -5 || print -r -- $desc'

zstyle ':fzf-tab:complete:(export|unset|printenv|typeset|-parameter-):*' fzf-preview '
    print -r -- ${(P)${word#\$}}'

zstyle ':fzf-tab:complete:git-(add|stage|restore|rm|diff):*' fzf-preview '
    d=$(git diff HEAD -- ${realpath:-$word} 2>/dev/null)
    if [[ -n $d ]]; then
        print -r -- $d | delta --paging=never --width=${FZF_PREVIEW_COLUMNS:-80}
    else
        bat -n --color=always --line-range :200 -- ${realpath:-$word} 2>/dev/null
    fi'

zstyle ':fzf-tab:complete:git-(checkout|switch|branch|merge|rebase|reset|revert|cherry-pick|log|show|tag):*' fzf-preview '
    if [[ -e $realpath ]]; then
        git diff HEAD -- $realpath | delta --paging=never --width=${FZF_PREVIEW_COLUMNS:-80}
    else
        git log --oneline --graph --decorate --color=always -50 $word 2>/dev/null ||
        git show --stat --color=always $word 2>/dev/null
    fi'

zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | col -bx | bat -l man -p --color=always'

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status --no-pager --lines=20 $word 2>&1'
zstyle ':fzf-tab:complete:journalctl:option-(u|-unit)-*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status --no-pager --lines=20 $word 2>&1'

zstyle ':fzf-tab:complete:(kill|renice|strace|gdb):argument-rest' fzf-preview 'procs --color always --tree $word 2>/dev/null'
zstyle ':fzf-tab:complete:(kill|renice|strace|gdb):argument-rest' fzf-flags --preview-window='down:8:wrap' --bind='ctrl-/:toggle-preview'

zstyle ':fzf-tab:complete:(docker|podman)-*:*' fzf-preview '
    out=$(docker inspect $word 2>/dev/null |
        jq -C ".[0] | {Name, Image: .Config.Image, State: .State.Status, Ports: .NetworkSettings.Ports}" 2>/dev/null)
    print -r -- ${out:-$desc}'

zstyle ':fzf-tab:complete:git:argument-1' fzf-preview '
    git help $word 2>/dev/null | col -bx | bat -l man -p --color=always | head -80 ||
        print -r -- $desc'

zstyle ':fzf-tab:complete:(docker|podman):*' fzf-preview '
    docker $word --help 2>/dev/null | head -40 || print -r -- $desc'

zstyle ':fzf-tab:complete:kubectl-*:*' fzf-preview 'kubectl explain $word 2>/dev/null | head -40'

zstyle ':fzf-tab:complete:(ssh|ping|telnet|host|dig):*' fzf-preview '
    dig +short $word 2>/dev/null; rg -N -A4 "^Host(name)? .*\b$word\b" ~/.ssh/config 2>/dev/null'

zstyle ':fzf-tab:complete:man:*' fzf-preview 'man -- $word 2>/dev/null | col -bx | bat -l man -p --color=always | head -100'
