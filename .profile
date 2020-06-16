export LC_ALL=en_US.UTF-8

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

export CARGO_HOME=$XDG_CACHE_HOME/cargo
export PATH=$PATH:$CARGO_HOME/bin

export NPM_CONFIG_PREFIX=$XDG_CONFIG_HOME/npm
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

export DENO_DIR=$XDG_CACHE_HOME/deno
export PATH=$DENO_DIR/bin:$PATH

export GOPATH=$XDG_CACHE_HOME/go
export PATH=$GOPATH/bin:$PATH

export ASDF_DATA_DIR=$XDG_CACHE_HOME/asdf
export ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdfrc

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
