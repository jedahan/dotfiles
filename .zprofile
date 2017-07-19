export LC_ALL="en_US.UTF-8"

export EDITOR=nvim
export VISUAL=$EDITOR

export LS=exa

export LESS='-r'

# Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[00;47;30m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export TERMINFO=$HOME/.terminfo
export HISTSIZE=$((2 ** 20))

# ruby
export GEM_HOME=$HOME/.gems
export PATH=$PATH:$GEM_HOME/bin
# homebrew
export HOMEBREW_NO_ANALYTICS=1
export PATH=/usr/local/sbin:/usr/local/bin:$PATH
# go
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH
# rust
export PATH=$HOME/.cargo/bin:$PATH
export DYLD_LIBRARY_PATH=$(rustc --print sysroot)/lib
export RUST_SRC_PATH=$DYLD_LIBRARY_PATH/rustlib/src/rust/src
export RLS_ROOT=$HOME/src/rls
# local
export PATH=$HOME/.bin:$PATH
export PATH=$HOME/bin:$PATH

[[ $HOST == *etsy.com ]] && {
  export GITHUB_URL=https://github.etsycorp.com/
  export XDEBUG_CONFIG="idekey=xdebug"
}

export ANDROID_HOME=/usr/local/share/android-sdk
export ANDROID_HOME=${HOME}/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

export PATH=${PATH}:/usr/local/Cellar/node/8.1.4/bin

test -f ~/.zshsecrets && source $_
