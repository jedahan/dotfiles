export OMZ="$HOME/.oh-my-zsh"

zstyle ':omz:module:editor' keymap 'emacs'
zstyle ':omz:module:editor' dot-expansion 'no'
zstyle ':omz:*:*' case-sensitive 'no'
zstyle ':omz:*:*' color 'yes'
zstyle ':omz:module:terminal' auto-title 'yes'
zstyle ':omz:load' omodule 'environment' 'terminal' 'editor' 'history' 'directory' 'spectrum' 'alias' 'completion' 'utility' 'prompt' \
  'archive' 'git' 'history-substring-search' 'osx' 'syntax-highlighting'
zstyle ':omz:module:prompt' theme 'sorin'

source "$OMZ/init.zsh"

alias of='open .'
alias cat='lolcat'
alias ,='clear && ls .'
alias ,.='cd .. && ,'
alias ,-='cd - && ,'
