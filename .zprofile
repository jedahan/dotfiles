export LC_ALL="en_US.UTF-8"
export HISTSIZE=$((2 ** 20))

export EDITOR=nvim
export VISUAL=$EDITOR

export LS=exa
export FIND=fd
export LESS='-r'

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_UPGRADE_CLEANUP=1

export TMPHOME=/Volumes/data/tmp

export GEM_HOME=$TMPHOME/gems
export PATH=$GEM_HOME/bin:$PATH

export GOPATH=$TMPHOME/go
export PATH=$GOPATH/bin:$PATH

export CARGO_HOME=$TMPHOME/cargo
export RUSTUP_HOME=$TMPHOME/rustup
export PATH=$CARGO_HOME/bin:$PATH
export RUST_SRC_PATH=$RUSTUP_HOME/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src

export NPM_CONFIG_PREFIX=$TMPHOME/npm/global
export NPM_CONFIG_CACHE=$TMPHOME/npm/cache
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

export PATH=$HOME/Library/Python/3.6/bin:$PATH

test -f $HOME/.zshsecrets && source $_
