export LC_ALL="en_US.UTF-8"

export EDITOR=nvim
export VISUAL=nvim

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
  export HOMEBREW_PREFIX="$HOME/.homebrew"
  export HOMEBREW_CASK_OPTS="--binarydir=$HOMEBREW_PREFIX/bin"
  export PATH="$HOMEBREW_PREFIX/sbin:$PATH"
  export PATH="$HOMEBREW_PREFIX/bin:$PATH"
}

(( $+commands[cargo] )) && {
  export PATH=/"$HOME/.cargo/bin:$PATH"
  export RUST_SRC_PATH=/"$HOME/.rust/src"
}

# Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

export TERMINFO="$HOME/.terminfo"
export HISTSIZE=1048576
