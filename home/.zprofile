export LC_ALL="en_US.UTF-8"

export EDITOR=nvim
export VISUAL=nvim

# Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;47;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export TERMINFO="$HOME/.terminfo"
export HISTSIZE=$((2 ** 20))

(( $+commands[go] )) && {
  export GOPATH=$HOME/.go
  export PATH=$GOPATH/bin:$PATH
}

(( $+commands[gem] )) && {
  export GEM_HOME=$HOME/.gems
  export PATH=$PATH:$GEM_HOME/bin
}

(( $+commands[brew] )) && {
  export HOMEBREW_NO_ANALYTICS=1
  export PATH="$(brew --prefix)/{s,}bin:$PATH"
}

export XDEBUG_CONFIG="idekey=xdebug"
