export LC_ALL="en_US.UTF-8"

export EDITOR=${commands[amp]:-$commands[vim]}
export VISUAL=$EDITOR

export LESS='-r'

export TMPHOME=$HOME/tmp

export RUSTUP_HOME=$TMPHOME/rustup
export CARGO_HOME=$TMPHOME/cargo
export PATH=$CARGO_HOME/bin:$PATH

export NPM_CONFIG_PREFIX=$TMPHOME/npm/global
export NPM_CONFIG_CACHE=$TMPHOME/npm/cache
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

export DENO_DIR=$TMPHOME/deno
export PATH="$DENO_DIR/bin:$PATH"

export GOPATH=$TMPHOME/go
export PATH=$GOPATH/bin:$PATH

export PATH=$HOME/bin:$PATH

test -f $HOME/.zshsecrets && source $_ || true
