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

alias gist='gist -c'
alias of='open .'
alias c='lolcat'
alias h='head'
alias ,='clear && ls .'
alias ,.='cd .. && ,'
alias ,-='cd - && ,'
alias duth='dut | head'
alias dfh='df -hl'
alias rm='nocorrect trash'
alias deploy='gp && deliver'
alias dp='deploy'
alias ascii='asciiio -y'
alias gpum='git push upstream master'
function git {  hub "$@" } # must be a function for completions to work
function cd, { cd "$@" && clear && ls }

export MARKPATH=$HOME/.marks
function jump {
  cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark {
  mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
  rm -i $MARKPATH/$1
}
function marks {
  ls -l $MARKPATH | sed 's/  / /g' | cut -d' ' -f9- && echo
}

alias m='mark'
alias u='unmark'
alias M='marks'
alias j='jump'

function up {
  brew update
  brew upgrade
  brew cleanup
  brew prune
  ls -l /usr/local/Library/Formula | grep phinze-cask | awk '{print $9}' | for evil_symlink in $(cat -); do rm -v /usr/local/Library/Formula/$evil_symlink; done
  brew doctor
}

# open sublime in a given location, or this directory if no location was specified
function s() { [[ $# -eq 0 ]] && subl . || subl "$@" }

# open sublime in a given location, or this directory if no location was specified
function v() { [[ $# -eq 0 ]] && vim . || vim "$@" }

# open a given location, or this directory if no location was specified
function o() { [[ $# -eq 0 ]] && open . || open "$@" }

export GEM_HOME="${HOME}/.gems"
export GEM_PATH=$GEM_HOME

autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey '^X^Z' predict-on
bindkey '^X^A' predict-off
zstyle ':predict' verbose 'yes'
