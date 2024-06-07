# Export path
PATH=$PATH:$HOME/bin:$HOME/.bin:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

## oh-my-zsh theme to use
#ZSH_THEME="robbyrussell" #➜  carplay_usb git:(master) ✗ foo
#ZSH_THEME="miloshadzic" #carplay_usb|master⚡ ⇒ foo
#ZSH_THEME="garyblessington" #carplay_usb(master) ✗: foo
#ZSH_THEME="zhann" #carplay_usb [master●●] foo
ZSH_THEME="shortgit"

## fzf config
# Set fzf installation directory path
export FZF_BASE=$HOME/.fzf

## colorize config
ZSH_COLORIZE_TOOL=pygmentize
ZSH_COLORIZE_STYLE="monokai"

# From Shell History Is Your Best Productivity Tool: https://martinheinz.dev/blog/110
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(cd|ls|gk|gls|gst)*"
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands

## bgnotify config
# Commands taking at leas this amount of seconds to execute will
# trigger a notification
bgnotify_threshold=180 #180s=3min

# Function called to format the notification
function bgnotify_formatted {
  # $1=exit_status, $2=command, $3=elapsed_time
  [ $1 -eq 0 ] && bgnotify "#win (took $3)" "$2" || bgnotify "#fail (took $3)" "$2"
}

## oh-my-zsh plugins to use
plugins=(
  fzf
  colorize
  bgnotify
  command-not-found
  colored-man-pages
)

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# Setup gpg-agent
# https://github.com/drduh/YubiKey-Guide#replace-agents
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

[ -f $HOME/.localrc ] && source $HOME/.localrc
