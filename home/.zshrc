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

function m() { cheat "$@" }
function f() { find . -name "$1" }
# View HTTP traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

function yell { figlet -f slant "$@" | sed "s/\(.\+\)/    \1/g"}

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

  cask-up()
  brew cask cleanup
  ls -l /usr/local/Library/Formula | grep homebrew-cask | awk '{print $9}' | for evil_symlink in $(cat -); do rm -v /usr/local/Library/Formula/$evil_symlink; done

  brew doctor
}

function cask-up() {
  CASKROOM = '/opt/homebrew-cask/Caskroom/'
  for cask_location in ${CASKROOM}*; do
    # get the latest version for each cask
    cask_name = $(basename $cask_location)
    latest_version = $(brew cask info ${cask_name} | grep ${cask_name}: | cut -d':' -f2 | tr -d ' ')

    # uninstall all casks that are not the latest version
    for installed_version in ${cask_location}/*; do
      if [ $(basename $installed_version) != $latest_version ]; then
        mv ${cask_location}+'/'+${installed_version} ~/.Trash
      fi
    done

    # if there are no installed version, install the latest version
    if [ -z "$(ls -A $cask_location)" ]; then
      brew cask uninstall ${cask_name}
      brew cask install ${cask_name}
    fi
  done
}

# open atom in a given location, or this directory if no location was specified
function a() {  atom ${@:-'.'} }

# open vim in a given location, or this directory if no location was specified
function v() {  vim ${@:-'.'} }

# open a given location, or this directory if no location was specified
function o() {  open ${@:-'.'} }

export GEM_HOME="${HOME}/.gems"
export GEM_PATH=$GEM_HOME
