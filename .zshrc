# Uncomment below (also at the end of file) for profiling
# zmodload zsh/zprof


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=5

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # fzf-tab should be before zsh-autosuggestions and zsh-syntax-highlighting
    git vi-mode zoxide fzf-tab zsh-autosuggestions
    
    # Commonly used plugins
    colored-man-pages common-aliases copyfile copypath
    
    # Language/framework specific plugins (lazy loaded when possible)
    docker docker-compose git-extras gradle mvn nvm rust sdk ssh-agent themes tig you-should-use

    # Should be last one
    zsh-syntax-highlighting
)

# NVM required for VIM
# zstyle ':omz:plugins:nvm' lazy yes
# zstyle ':omz:plugins:nvm' lazy-cmd npm npx node prettier typescript tsc

zstyle ':omz:plugins:ssh-agent' identities id_rsa nphase.github.com

# init zsh-completions plugin - right way
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+=$HOME/.zsh-complete

# should be AFTER fpath changes!
source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
export BROWSER="google-chrome"
export READER="zathura"
export EDITOR="nvim"
export PAGER="bat"

source $HOME/.aliases

# each time ranger starts RANGER_LEVEL is increased, so exit if we are in ranger already
rg() {
    if [ -z "$RANGER_LEVEL" ]
    then
        local temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
        python3 ~/work/apps/ranger/ranger.py --choosedir="$temp_file" -- "$@"
        if [ -f "$temp_file" ]; then
            local chosen_dir="$(cat "$temp_file")"
            [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ] && cd "$chosen_dir"
            rm -f "$temp_file"
        fi
    else
        exit 0
    fi
}
[ -n "$RANGER_LEVEL" ] && PS1="$PS1"'[rg] '


export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"


timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}


export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin:$HOME/.local/bin/


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Lazy loading for pyenv
pyenv() {
    unset -f pyenv
    eval "$(pyenv init --path)"
    pyenv "$@"
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh 
[ -f ~/.claude.zsh ] && source ~/.claude.zsh 

# jdtls for claude
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

kp() {
  # Локальная переменная с базовой командой и нужными флагами
  local cmd="procs --color always"
  local pid

  # Вызываем fzf, прокидывая цвета через --ansi
  pid=$(fzf --ansi \
            --query "$1" \
            --layout=reverse \
            --header-lines=1 \
            --info=inline \
            --ghost 'Enter process...' \
            --header='[ENTER] Kill | [CTRL-R] Reload' \
            --preview "$cmd --no-header --only command {1}" \
            --preview-window="right:40%:wrap" \
            --bind "start:reload(echo '')" \
            --bind "change:reload(if [ -n {q} ]; then $cmd {q}; else echo ''; fi)" \
            --bind "ctrl-r:reload($cmd {q} || :)" \
            | awk '{print $1}'
        )

  if [ -n "$pid" ]; then
    # 15 (SIGTERM), override with : kp "" 9
    kill -${2:-15} "$pid" && echo "Process $pid terminated."
  fi
}

export _JAVA_AWT_WM_NONREPARENTING=1

# zprof
