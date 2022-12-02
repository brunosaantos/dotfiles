# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
  git
  kubectl
)

# Start tmux by default
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t default || tmux new -s default
fi

source $ZSH/oh-my-zsh.sh

# Alias
alias vim="nvim"
alias delete_git_branchs='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

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

# Load secrets
source $HOME/.zshrc.secrets

# PNPM
export PNPM_HOME="/Users/$USER/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Add homebrew path when apple silicon
eval "$(/opt/homebrew/bin/brew shellenv)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "/Users/$USER/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "/Users/$USER/Downloads/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "/Users/$USER/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "/Users/$USER/Downloads/google-cloud-sdk/completion.zsh.inc"; fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/$USER/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
