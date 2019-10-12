# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Alias
alias vim="nvim"

# Functions

## Get npm package version
function gversion(){
  cat ./node_modules/$1/package.json | grep version
}

## Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_";
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Get rid of error message
# https://stackoverflow.com/questions/56716993/error-message-when-starting-vim-failed-to-set-locale-category-lc-numeric-to-en
export LC_ALL=en_US.UTF-8

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
