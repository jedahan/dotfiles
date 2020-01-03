export TERM=alacritty
export LC_ALL=en_US.UTF-8

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export RUSTUP_HOME=$XDG_CACHE_HOME/rustup
export CARGO_HOME=$XDG_CACHE_HOME/cargo
export PATH=$CARGO_HOME/bin:$PATH

export NPM_CONFIG_PREFIX=$XDG_CONFIG_HOME/npm
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

export DENO_DIR=$XDG_CACHE_HOME/deno
export PATH=$DENO_DIR/bin:$PATH

export GOPATH=$XDG_CACHE_HOME/go
export PATH=$GOPATH/bin:$PATH

export ASDF_DATA_DIR=$XDG_CACHE_HOME/asdf
export ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdfrc

export PATH=$XDG_CONFIG_HOME/poetry/bin:$PATH

export PATH=$HOME/.local/bin:$PATH

export PATH=/sbin:$PATH

export SPACEVIMDIR=$XDG_CONFIG_HOME/spacevim/
export MOZ_ENABLE_WAYLAND=1
unset DISPLAY
