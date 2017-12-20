# language
export LC_ALL="en_US.UTF-8"
# editor
export EDITOR=nvim
export VISUAL=$EDITOR
# use exa for ls
export LS=exa
# use fd for find
export FIND=fd
# colored less output
export LESS='-r'
# history
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
# android
export ANDROID_HOME=/usr/local/share/android-sdk
export ANDROID_HOME=${HOME}/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
# clojars
export CLOJARS_USER=$USER
# carp
export PATH=$HOME/.local/bin:$PATH
export CARP_DIR=$HOME/src/Carp/
# secrets
test -f ~/.zshsecrets && source $_
