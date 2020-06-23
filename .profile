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

export KISS_HOME=$XDG_CACHE_HOME/repos
export KISS_PATH=$KISS_PATH:$KISS_HOME/kiss-garbage
export KISS_PATH=$KISS_PATH:$KISS_HOME/kiss-himmalerin/modified
export KISS_PATH=$KISS_PATH:$KISS_HOME/jedahan
export KISS_PATH=$KISS_PATH:$KISS_HOME/community/community
export KISS_PATH=$KISS_PATH:$KISS_HOME/kiss-himmalerin/extra
export KISS_PATH=$KISS_PATH:$KISS_HOME/mywayland/wayland
export KISS_PATH=$KISS_PATH:$KISS_HOME/mywayland/noxland
export KISS_PATH=$KISS_PATH:$KISS_HOME/admicos/custom
export KISS_PATH=$KISS_PATH:$KISS_HOME/sdsddsd1/kiss-games
export KISS_PATH=$KISS_PATH:$KISS_HOME/carbs/extra
export KISS_PATH=$KISS_PATH:/var/db/kiss/repo/xorg
export PATH=/usr/lib/ccache/bin:$PATH
