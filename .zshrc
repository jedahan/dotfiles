export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.npm-global/bin:$PATH

icons=(🌀                        )
icon="${icons[RANDOM % $#icons + 1]}"
[[ (( $+commands[tmux] )) && -z "$TMUX$SSH_CLIENT" ]] && { tmux ls 2>/dev/null | rg -v attached>/dev/null && tmux attach || tmux new -s $icon -n $icon }
[[ -n "$TMUX" ]] && tmux rename-window $icon

bindkey -e
autoload -U select-word-style
select-word-style bash

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

export GEOMETRY_PROMPT_PLUGINS_PRIMARY=(path hostname)
export GEOMETRY_PROMPT_PLUGINS_SECONDARY=(exec_time todo git rustup hydrate)
export GEOMETRY_PLUGIN_HYDRATE_BINDKEY='^L'

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
    jedahan/geometry-hydrate \
    jedahan/geometry-todo \
    geometry-zsh/geometry \
    ael-code/zsh-colored-man-pages \
    momo-lab/zsh-abbrev-alias \
    jedahan/alacritty-completions \
    zpm-zsh/ssh
}
source ~/.zr/init.zsh

alias manual=$functions[man]
abbrev-alias man=tldr
abbrev-alias help=tldr
abbrev-alias h=tldr
abbrev-alias x=exit
abbrev-alias o=open
abbrev-alias a=atom
abbrev-alias v=nvim
abbrev-alias c=lolcat
abbrev-alias _=sudo
abbrev-alias s=rg
abbrev-alias l=$LS
abbrev-alias ll="$LS -l"
function ls { $LS $@ }
abbrev-alias f=$FIND
function , { clear && $LS }

alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
function twitch { streamlink --player "mpv --vo=opengl -hwdec=videotoolbox --fs --native-fs=no" twitch.tv/$@ best }

function up { # upgrade everything
  uplog=/tmp/up; rm -rf $uplog >/dev/null; touch $uplog

  window_name=`tmux list-windows | grep '*' | cut -d'*' -f1 | cut -d' ' -f2`
  tmux select-window -t  2>/dev/null || tmux rename-window 
  tmux split-window -d -p 40 -t  "tail -f $uplog"

  function fun { (( $+aliases[$1] || $+functions[$1] || $+commands[$1] )) && echo -n "updating $2..." }
  function e { if [ $? -eq 0 ]; then c <<< $1; else echo ":("; fi }
  c <<< "  $uplog"
  fun config 'dotfiles' && { config pull }                         &>> $uplog; e 
  fun zr 'zsh plugins'  && { zr update }                           &>> $uplog; e ▲ && s 'Updating [a-f0-9]{6}\.\.[a-f0-9]{6}' -B1 $uplog
  fun tldr 'tldr'       && { tldr --update }                       &>> $uplog; e ⚡
  fun brew 'brews'      && { brew cask upgrade; brew upgrade }     &>> $uplog; e  && s 🍺 $uplog | cut -d'/' -f5-6 | cut -d':' -f1
  fun nvim 'neovim'     && { nvim '+PlugUpdate!' '+PlugClean!' '+qall' } &>> $uplog; e  && s 'Updated!\s+(.+/.+)' -r '$1' -N $uplog | paste -s -
  fun rustup 'rust'     && { rustup update }                       &>> $uplog; e  && s 'updated.*rustc' -N $uplog | cut -d' ' -f7 | paste -s -
  fun cargo 'crates'    && { cargo install-update --all }          &>> $uplog; e  && s '(.*)Yes$' --replace '$1' $uplog | paste -s -
  fun mas 'apps'        && { mas upgrade }                         &>> $uplog; e && s -A1 'outdated applications' -N $uplog | tail -n1

  tmux kill-pane -t :.{bottom}
  tmux rename-window $window_name
}
