#Custom stuff to load
export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg 2> /dev/null)
export PATH=/home/jabenze/go/bin:/home/jabenze/flutter/bin:$PATH
export CHROME_EXECUTABLE=google-chrome-stable

ZSH=/usr/share/oh-my-zsh/
ZSH_CUSTOM=/home/jabenze/.dotfiles/zsh_custom
export EDITOR=nvim

alias tmux="tmux -2"
alias vi=nvim

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="frosted"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras dircycle vi-mode)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
alias hisg="history | grep"
alias fix_monitors='swaymsg "output HDMI-A-1 pos 0 0 res 1920x1200" && swaymsg "output DP-2 pos 1920 0 res 1920x1200"'

alias ibazel="npx @bazel/ibazel"
