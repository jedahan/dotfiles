export HISTFILE=${HOME}/.zhistory HISTSIZE=100000 SAVEHIST=100000 ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
export EDITOR=${commands[nvim]:-$commands[vim]}
export VISUAL=$EDITOR
export LESS='-R'
export LC_ALL=en_US.UTF-8

export PASSWORD_STORE_DIR=$HOME/.secrets/pass
export GNUPGHOME=$HOME/.secrets/gpg

export CACHE=/var/cache

export CARGO_HOME=$CACHE/cargo
export PATH=$PATH:$CARGO_HOME/bin

export GOPATH=$XDG_CACHE_HOME/go
export PATH=$GOPATH/bin:$PATH

export ANDROID_SDK=$HOME/Android/Sdk/
export PATH=$ANDROID_SDK/emulator:$PATH

export SPACEVIMDIR=$XDG_CONFIG_HOME/spacevim/

export PATH=$PATH:$HOME/.local/bin

export PATH=$PATH:$HOME/.config/emacs/bin

export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket

export MOZ_ENABLE_WAYLAND=1

export CFLAGS="-O2 -march=native"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j$(nproc)"

export KISS_PATH=/var/db/kiss/repos/jedahan:$KISS_PATH

export XDG_RUNTIME_DIR=$(mktemp -d)

export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export MOZ_WEBRENDER=1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway

eval $(ssh-agent | grep -v echo)
