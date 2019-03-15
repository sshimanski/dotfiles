# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export BROWSER="firefox"
export READER="zathura"
export EDITOR="nvim"

# JAVA
export JAVA_HOME="$HOME/work/apps/java/jdk1.8.0_181"
# export JAVA_HOME="$HOME/work/apps/java/jdk-9.0.4"
# export JAVA_HOME="$HOME/work/apps/java/jdk-10.0.2"
# MVN
export M2_HOME="$HOME/work/apps/mvn/apache-maven-3.5.4"
# Groovy
export GROOVY_HOME="$HOME/work/apps/groovy/groovy-3.0.0-alpha-3"
# FZF
export FZF_BASE="$HOME/work/apps/fzf"
# Rust
export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

export PATH="$PATH:$HOME/work/appimage:$HOME/dotfiles/scripts:$JAVA_HOME/bin:$JAVA_HOME/jre:$M2_HOME/bin:$GROOVY_HOME/bin:$HOME/.cargo/bin"
