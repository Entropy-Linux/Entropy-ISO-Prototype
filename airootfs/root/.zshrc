# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init --cmd cd zsh)"

# Cd fix
cd() {
  builtin cd "$@"
}

# =================== BETTER RUN COMMAND ===================

# Detect currently used shell, and define it's .rc path as $SHRC
case "$SHELL" in
   */bash)
       export SHRC="$HOME/.bashrc"
       ;;
   */zsh)
       export SHRC="$HOME/.zshrc"
       ;;
   */ksh)
       export SHRC="$HOME/.kshrc"
       ;;
   */fish)
       export SHRC="$HOME/.config/fish/config.fish"
       ;;
   *)
       # Fallback for other shells
       export SHRC="$HOME/.profile"
       ;;
esac

# Reload shell automatically (source .$0rc)
alias reloadrc="source $SHRC"

# Copy: echo "Stuff" | copy, copy "Stuff", copy $VAR
copy() {
   # Copy from stdin (e.g., echo "text" | copy)
   if [ $# -eq 0 ]; then
       xclip -selection clipboard
   else
       # Copy directly from a string or variable
       echo -n "$*" | xclip -selection clipboard
   fi
}

# Paste: paste, <command> $(paste)
paste() {
   xclip -selection clipboard -o
}

# Eg: copyf <filename>
alias copyf="cat $1 | xclip -selection clipboard"

# Space usage for current folder
alias diskspace="du -sh * 2>/dev/null | sort -h"

# Display weather for your location or specified city
weather() {
   if [ -z "$1" ]; then
       curl "wttr.in?format=4"
   else
       curl "wttr.in/${1// /+}?format=4"
   fi
}

# Find any file and open with fzf
fopen() {
   local file
   file=$(find . -type f -iname "*$1*" | fzf) && xdg-open "$file"
}

# Find files by name
alias ffind="find . -type f -iname"

# Find directories by name
alias dfind="find . -type d -iname"

# Create a directory and immediatly cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Man Syntax Highlight
export LESS_TERMCAP_mb=$'\e[1;31m'  # Red
export LESS_TERMCAP_md=$'\e[1;35m'  # Magenta
export LESS_TERMCAP_me=$'\e[0m'     # Reset
export LESS_TERMCAP_se=$'\e[0m'     # Reset
export LESS_TERMCAP_so=$'\e[1;44;33m' # Yellow on blue
export LESS_TERMCAP_ue=$'\e[0m'     # Reset
export LESS_TERMCAP_us=$'\e[1;32m'  # Green

