export LC_ALL=en_US.UTF-8

export CACHE=/var/cache

export CARGO_HOME=$CACHE/cargo
export PATH=$PATH:$CARGO_HOME/bin

export GOPATH=$XDG_CACHE_HOME/go
export PATH=$GOPATH/bin:$PATH

export ANDROID_SDK=$HOME/Android/Sdk/
export PATH=$ANDROID_SDK/emulator:$PATH

export SPACEVIMDIR=$XDG_CONFIG_HOME/spacevim/

export PATH=$PATH:$HOME/.local/bin

export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket

export MOZ_ENABLE_WAYLAND=1

export CFLAGS="-O2 -march=native"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j$(nproc)"

export KISS_PATH=/var/db/kiss/repos/jedahan:$KISS_PATH

export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
mkdir -p $XDG_RUNTIME_DIR
