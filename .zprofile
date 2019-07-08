export LC_ALL=en_US.UTF-8

export EDITOR=${commands[amp]:-$commands[nvim]}
export VISUAL=$EDITOR

export LESS='-r'

export TMP=$HOME/tmp

export RUSTUP_HOME=$TMP/rustup
export CARGO_HOME=$TMP/cargo
export PATH=$CARGO_HOME/bin:$PATH

export NPM_CONFIG_PREFIX=$TMP/npm/global
export NPM_CONFIG_CACHE=$TMP/npm/cache
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

export DENO_DIR=$TMP/deno
export PATH=$DENO_DIR/bin:$PATH

export GOPATH=$TMP/go
export PATH=$GOPATH/bin:$PATH

test -f $HOME/.zshsecrets && source $_ || true
