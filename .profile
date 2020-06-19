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

export KISS_PATH=$XDG_CACHE_HOME/repos/jedahan:$KISS_PATH
export KISS_PATH=$XDG_CACHE_HOME/repos/community/community:$KISS_PATH
export KISS_PATH=$XDG_CACHE_HOME/repos/kiss-himmalerin/extra:$KISS_PATH
export KISS_PATH=$XDG_CACHE_HOME/repos/kiss-himmalerin/modified:$KISS_PATH
export KISS_PATH=$XDG_CACHE_HOME/repos/mywayland/noxland:$KISS_PATH
export KISS_PATH=$XDG_CACHE_HOME/repos/mywayland/wayland:$KISS_PATH
export KISS_PATH=$XDG_CACHE_HOME/repos/admicos/custom:$KISS_PATH
export KISS_PATH=$XDG_CACHE_HOME/repos/sdsddsd1/kiss-games:$KISS_PATH
export KISS_PATH=$KISS_PATH:/var/db/kiss/repo/xorg
export PATH=/usr/lib/ccache/bin:$PATH
