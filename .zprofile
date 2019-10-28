export LC_ALL=en_US.UTF-8

export EDITOR=${commands[amp]:-$commands[nvim]}
export VISUAL=$EDITOR

export LESS='-r'

# colored man pages
export LESS_TERMCAP_md=$(tput bold; tput setaf 4)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_mb=$(tput blink)
export LESS_TERMCAP_us=$(tput setaf 2)
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_so=$(tput smso)
export LESS_TERMCAP_se=$(tput rmso)
export PAGER="${commands[less]:-$PAGER}"

CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}
export RUSTUP_HOME=$CACHE_DIR/rustup
export CARGO_HOME=$CACHE_DIR/cargo
export PATH=$CARGO_HOME/bin:$PATH

export NPM_CONFIG_PREFIX=$CACHE_DIR/npm/global
export NPM_CONFIG_CACHE=$CACHE_DIR/npm/cache
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

export DENO_DIR=$CACHE_DIR/deno
export PATH=$DENO_DIR/bin:$PATH

export GOPATH=$CACHE_DIR/go
export PATH=$GOPATH/bin:$PATH

export PATH=$HOME/.local/bin:$PATH
