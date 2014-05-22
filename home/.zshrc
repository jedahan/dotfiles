# Source Prezto.
local preztoinit="${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
[[ -s $preztoinit ]] && source $preztoinit
unset preztoinit

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
alias localip='ipconfig getifaddr en0'
# JavaScriptCore REPL
jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
[[ -s $jscbin ]] && alias jsc=$jscbin
unset jscbin

function git {  hub "$@" } # must be a function for completions to work
function cd, { cd "$@" && clear && ls }

function b { brew "$@" }
function bl { brew list "$@" }
function bi { brew info "$@" }
function bh { brew home"$@" }
function bs { brew search "$@" }
function bI { brew install "$@" }

function B { brew cask "$@" }
function Bl { brew cask list "$@" }
function Bi { brew cask info "$@" }
function Bh { brew cask home "$@" }
function Bs { brew cask search "$@" }
function BI { brew cask install "$@" }

function up {
  brew update
  brew upgrade
  brew cleanup
  brew prune
  ls -l /usr/local/Library/Formula | grep phinze-cask | awk '{print $9}' | for evil_symlink in $(cat -); do rm -v /usr/local/Library/Formula/$evil_symlink; done
  brew doctor
}

# open atom in a given location, or this directory if no location was specified
function a() { [[ $# -eq 0 ]] && atom . || atom "$@" }

# open vim in a given location, or this directory if no location was specified
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
