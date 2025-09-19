# Setup fzf
# ---------
if [[ ! "$PATH" == */home/administrator/work/apps/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/administrator/work/apps/fzf/bin"
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

show_file_or_dir_preview="
    if [ -d {} ]; then 
        eza --tree --color=always --icons=always {} | head -200; 
    else 
        bat -n --color=always --line-range :500 {}; 
    fi"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_R_OPTS="
    --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
    --color header:italic
    --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_CTRL_T_OPTS="
    --preview '$show_file_or_dir_preview' 
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --color header:italic
    --header 'Press CTRL-/ to change preview window' "
export FZF_ALT_C_OPTS="
    --bind 'focus:bg-transform-preview-label:[[ -n {} ]] && printf \" Previewing [%s] \" {}'
    --preview 'eza --tree --color=always --icons=always {} | head -200'
"

export _ZO_FZF_OPTS="
    --delimiter ' ' 
    --reverse 
    --preview 'eza --tree --icons=always --level=1 --color=always {2} | head -200' 
    --preview-window=right,40%"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh|telnet)   fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
