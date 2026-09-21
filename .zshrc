# Uncomment below (also at the end of file) for profiling
# zmodload zsh/zprof


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# Disabled: prompt is now handled by starship (see eval at end of file).
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

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

# omz defaults SAVEHIST (10000) below HISTSIZE (50000), which trims
# ~/.zsh_history on rewrite despite share_history being on. Keep them equal.
HISTSIZE=50000
SAVEHIST=50000

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
    colored-man-pages common-aliases copyfile copypath eza

    # Language/framework specific plugins (lazy loaded when possible)
    docker docker-compose gh git-extras gradle kind kubectl mvn nvm rust sdk ssh-agent tig you-should-use

    # Should be last one
    zsh-syntax-highlighting
)

# NVM required for VIM
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd npm npx node prettier typescript tsc

zstyle ':omz:plugins:ssh-agent' identities id_rsa nphase.github.com

# init zsh-completions plugin - right way
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
fpath+=$HOME/.zsh-complete

# should be AFTER fpath changes!
source $ZSH/oh-my-zsh.sh

# Make the mvn plugin's whole alias set (mvnci, mvncist, mvnct, ...) run
# through mvnd instead of plain mvn, keeping the mvnw-in-project override.
# mvnd availability is checked at call time (not at shell startup), since
# sdkman-init.sh (which puts mvnd on PATH) is sourced later in this file.
# Falls back to plain mvn if mvnd isn't installed/on PATH.
mvn-or-mvnw() {
    local dir="$PWD"
    while [[ ! -x "$dir/mvnw" && "$dir" != / ]]; do
        dir="${dir:h}"
    done

    if [[ -x "$dir/mvnw" ]]; then
        "$dir/mvnw" "$@"
        return $?
    fi

    if command -v mvnd >/dev/null 2>&1; then
        command mvnd "$@"
    else
        command mvn "$@"
    fi
}

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
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

source $HOME/.aliases

# each time ranger starts RANGER_LEVEL is increased, so exit if we are in ranger already
rn() {
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

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"


timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}


export PATH="$HOME/.local/share/bob/nvim-bin:$HOME/go/bin:$HOME/.local/bin:/usr/local/go/bin:$PATH"


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init --path)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh 
[ -f ~/.fzf.custom.zsh ] && source ~/.fzf.custom.zsh 
[ -f ~/.claude.zsh ] && source ~/.claude.zsh 

# CLAUDE: jdtls-lsp -> OS jdtls command
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

export _JAVA_AWT_WM_NONREPARENTING=1

eval "$(starship init zsh)"

# zprof
