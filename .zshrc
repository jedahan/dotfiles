bindkey -e

export PATH=/usr/local/bin:$PATH
[[ -z "$TMUX" && -z "$SSH_CLIENT" ]] && { tmux attach || tmux }
_icons=( ⚡                       )
[[ -z "$TMUX" ]] || tmux rename-window "${_icons[RANDOM % $#_icons + 1]} "

setopt autocd
setopt autopushd
setopt pushd_ignore_dups
setopt interactivecomments

autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste $_

export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
export PROMPT_GEOMETRY_EXEC_TIME=true
export GEOMETRY_SYMBOL_RUSTUP=
export GEOMETRY_TIME_NEUTRAL='yellow'
export GEOMETRY_PLUGIN_HYDRATE_SYMBOL=
export GEOMETRY_PLUGIN_SEPARATOR='%F{242}  %f'
export TIPZ_TEXT=' '

export FZF_DEFAULT_COMMAND='rg --files --follow'

export GEOMETRY_PROMPT_PLUGINS_SECONDARY=(exec_time git +rustup hydrate)

test -d ~/.zr || mkdir $_
test -f ~/.zr/init.zsh || touch $_
[[ ~/.zshrc -nt ~/.zr/init.zsh ]] && {
  zr load sorin-ionescu/prezto/modules/git/alias.zsh \
    sorin-ionescu/prezto/modules/history/init.zsh \
    sorin-ionescu/prezto/modules/osx/init.zsh \
    sorin-ionescu/prezto/modules/homebrew/init.zsh \
    junegunn/fzf/shell/key-bindings.zsh \
    zsh-users/zsh-autosuggestions \
    zdharma/fast-syntax-highlighting \
    molovo/tipz \
    changyuheng/zsh-interactive-cd \
    geometry-zsh/geometry \
    jedahan/geometry-hydrate \
    ael-code/zsh-colored-man-pages
}
source ~/.zr/init.zsh

alias manual=$functions[man]
alias man=tldr
alias help=tldr
alias h=tldr
alias x=exit
alias o=open
alias a=atom
alias v=nvim
alias c=lolcat
alias _=sudo
alias s=rg
alias l=$LS
alias ll="$LS -l"
function , { clear && $LS }
function t { (($#)) && echo -E - "$*" >> ~/todo.md || s '###' ~/todo.md --replace '⌫ ' 2>/dev/null | lolcat }; t # todo

alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
function twitch { streamlink twitch.tv/$@ best }

function up { # upgrade everything
  uplog=$(mktemp -t up)

  window_name=`tmux list-windows | grep '*' | cut -d'*' -f1 | cut -d' ' -f2`
  tmux select-window -t  2>/dev/null || tmux rename-window 
  tmux split-window -d -p 40 -t  "tail -f $uplog"

  function fun { (( $+functions[$1] || $+commands[$1] )) && echo -n "updating $2..." }
  function e { if [ $? -eq 0 ]; then c <<< $1; else echo ":("; fi }
  c <<< "  $uplog"
  fun config 'dotfiles' && { config pull }                         &>> $uplog; e 
  fun zr 'zsh plugins'  && { zr update }                           &>> $uplog; e ▲ && s 'Updating [a-f0-9]{6}\.\.[a-f0-9]{6}' -B1 $uplog
  fun tldr 'tldr'       && { tldr --update }                       &>> $uplog; e ⚡
  fun brew 'brews'      && { brew upgrade; brew cleanup }          &>> $uplog; e 
  fun nvim 'neovim'     && { nvim +PlugUpdate! +PlugClean! +qall } &>> $uplog; e  && s 'Updated!\s+(.+/.+)' -r '$1' -N $uplog | paste -s -
  fun rustup 'rust'     && { rustup update }                       &>> $uplog; e  && s 'updated.*rustc' -N $uplog | cut -d' ' -f7 | paste -s -
  fun cargo 'crates'    && { cargo +nightly install-update clippy; cargo install-update --all }          &>> $uplog; e  && s '(.*)Yes$' --replace '$1' $uplog | paste -s -
  fun mas 'apps'        && { mas upgrade }                         &>> $uplog; e && s -A1 'outdated applications' -N $uplog | tail -n1

  tmux kill-pane -t 0:.{bottom}
  tmux rename-window $window_name
}
