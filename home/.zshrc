#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

alias of='open .'
alias c='lolcat'
alias h='head'
alias ,='clear && ls .'
alias ,.='cd .. && ,'
alias ,-='cd - && ,'
alias duth='dut | head'
alias dfh='df -hl'
alias s='subl'
alias rm='nocorrect trash'
