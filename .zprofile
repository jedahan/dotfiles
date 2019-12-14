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

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

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
