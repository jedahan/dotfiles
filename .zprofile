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

export RUSTUP_HOME=$HOME/tmp/rustup
export CARGO_HOME=$HOME/tmp/cargo
export PATH=$CARGO_HOME/bin:$PATH

export NPM_CONFIG_PREFIX=$HOME/tmp/npm/global
export NPM_CONFIG_CACHE=$HOME/tmp/npm/cache
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

export DENO_DIR=$HOME/tmp/deno
export PATH=$DENO_DIR/bin:$PATH

export GOPATH=$HOME/tmp/go
export PATH=$GOPATH/bin:$PATH

export PATH=$HOME/.local/bin:$PATH
