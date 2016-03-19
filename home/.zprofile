export LC_ALL="en_US.UTF-8"

export EDITOR=nvim
export VISUAL=nvim

export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH

export GEM_HOME="$HOME/.gems"
export GEM_PATH=$GEM_HOME
export PATH=$GEM_PATH/bin:$PATH

export HOMEBREW_PREFIX="$HOME/.homebrew"
export HOMEBREW_CASK_OPTS="--binarydir=$HOMEBREW_PREFIX/bin"
export PATH="$HOMEBREW_PREFIX/sbin:$PATH"
export PATH="$HOMEBREW_PREFIX/bin:$PATH"

# Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.
