export LC_ALL=en_US.UTF-8

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export RUSTUP_HOME=$XDG_CACHE_HOME/rustup
if test -d /var/cache/cargo; then export CARGO_HOME=/var/cache/cargo; else export CARGO_HOME=$XDG_CACHE_HOME/cargo; fi
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

export SPACEVIMDIR=$XDG_CONFIG_HOME/spacevim/

grep -q ':/sbin' "$PATH" || export PATH=/sbin:$PATH
command -v systemd-path >/dev/null 2>&1 && user_binaries="$(systemd-path user-binaries)"
test -d "$user_binaries" && export PATH=$user_binaries:$PATH

command -v alacritty >/dev/null 2>&1 && export TERM=alacritty
export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket

export MOZ_ENABLE_WAYLAND=1
unset DISPLAY
if [[ -z "$WAYLAND_DISPLAY" ]]; then setfont Uni3-Terminus32x16 || true; fi
if [[ "$TERM" = "linux" ]]; then setfont /usr/share/consolefonts/ter-u32n.psf.gz || true; fi

export CFLAGS="-O2 -march=native -pipe"
export CXXFLAGS="$CFLAGS"
PROCESSORS=$(getconf _NPROCESSORS_ONLN)
command -v getconf >/dev/null 2>&1 && export MAKEFLAGS="-j${PROCESSORS}"

unset LESS
export BAT_PAGER="less"

