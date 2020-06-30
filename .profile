export LC_ALL=en_US.UTF-8

export CACHE=/var/cache

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

export CARGO_HOME=$CACHE/cargo
export PATH=$PATH:$CARGO_HOME/bin

export GOPATH=$XDG_CACHE_HOME/go
export PATH=$GOPATH/bin:$PATH

export ANDROID_SDK=$HOME/Android/Sdk/
export PATH=$ANDROID_SDK/emulator:$PATH

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export RUSTUP_HOME=$XDG_CACHE_HOME/rustup
export SPACEVIMDIR=$XDG_CONFIG_HOME/spacevim/

export PATH=$PATH:$HOME/.local/bin

export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket

export MOZ_ENABLE_WAYLAND=1

export CFLAGS="-O2 -march=native -pipe"
export CXXFLAGS="$CFLAGS"
PROCESSORS="$(nproc)"
export MAKEFLAGS="-j$PROCESSORS"

export KISS_REPO=/var/db/kiss/repo
export KISS_HOME=$XDG_CACHE_HOME/repos
export KISS_PATH=$KISS_REPO/core\
:$KISS_HOME/jedahan\
:$KISS_HOME/kiss-himmalerin/modified\
:$KISS_HOME/kiss-himmalerin/extra\
:$KISS_HOME/mywayland/noxland\
:$KISS_HOME/kiss-garbage/garbage\
:$KISS_HOME/admicos/custom\
:$KISS_HOME/community/community\
:$KISS_REPO/extra\
:$KISS_REPO/xorg

export PATH=/usr/lib/ccache/bin:$PATH

export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
mkdir -p $XDG_RUNTIME_DIR
