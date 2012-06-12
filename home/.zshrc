zstyle ':omz:module:editor' keymap 'emacs'
zstyle ':omz:module:editor' dot-expansion 'no'
zstyle ':omz:*:*' case-sensitive 'no'
zstyle ':omz:*:*' color 'yes'
zstyle ':omz:module:terminal' auto-title 'yes'
zstyle ':omz:load' omodule 'environment' 'terminal' 'editor' 'history' 'directory' 'spectrum' 'utility' 'completion' 'prompt' \
  'archive' 'git' 'history-substring-search' 'osx' 'syntax-highlighting' 'z'
zstyle ':omz:module:prompt' theme 'sorin'

source "$OMZ/init.zsh"

alias of='open .'
alias cat='lolcat'
alias c='lolcat'
alias ,='clear && ls .'
alias ,.='cd .. && ,'
alias ,-='cd - && ,'
alias duhh='duh | head'
alias dfh='df -h | ack -v "map|devfs"'
