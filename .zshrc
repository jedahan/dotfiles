[[ -v ZSH_PROF ]] && zmodload zsh/zprof
bindkey -e

[[ -z "$TMUX" && -z "$SSH_CLIENT" ]] && { tmux attach || tmux }
_icons=( ⚡                       )
[[ -z "$TMUX" ]] || tmux rename-window "${_icons[RANDOM % $#_icons + 1]} "

function s { rg $@ }
function t { (($#)) && echo -E - "$*" >> ~/todo.md || s '###' ~/todo.md --replace '⌫ ' 2>/dev/null | lolcat }; t # todo

setopt autocd
setopt autopushd
setopt pushd_ignore_dups
setopt interactivecomments

autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic

export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
export PROMPT_GEOMETRY_EXEC_TIME=true
export GEOMETRY_SYMBOL_RUSTUP=
export GEOMETRY_TIME_NEUTRAL='yellow'
export GEOMETRY_PLUGIN_HYDRATE_SYMBOL=
export GEOMETRY_PLUGIN_SEPARATOR='%F{242}  %f'
export TIPZ_TEXT=' '

export FZF_DEFAULT_COMMAND='rg --files --follow'

export GEOMETRY_PROMPT_PLUGINS=(exec_time git +rustup hydrate)

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
    frmendes/geometry \
    jedahan/geometry-hydrate
}
source ~/.zr/init.zsh

function h help { man $@ }
function x { exit }
function o { open "${@:-'.'}" }
function a { atom "${@:-'.'}" }
function v { nvim $@ }
function c { lolcat $@ }
function _ { sudo $@ }
function l { $LS $@ }
function ls { $LS $@ }
function ll { $LS -l $@ }
function , { clear && $LS }
function b { mv "$@" /Volumes/data/b/ }

function config { git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@ }

function badge { printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$@" | base64) }
function twitch { livestreamer twitch.tv/$@ high || livestreamer twitch.tv/$@ 720p60 || livestreamer twitch.tv/$@ 720p30 || livestreamer twitch.tv/$@ best }

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

  tmux kill-pane -t 0:.{bottom}
  tmux rename-window $window_name
}

export PROMPT_GEOMETRY=$(prompt_geometry_colorize $PROMPT_GEOMETRY_COLOR $PROMPT_GEOMETRY_SYMBOL)

if [[ -n "$SSH_CLIENT" ]]; then # remote pbcopy, pbpaste, notify
  export PROMPT_GEOMETRY=$(prompt_geometry_colorize $PROMPT_GEOMETRY_COLOR ⬡)

  for command in pb{copy,paste}; do
    (( $+commands[$command] )) && unfunction $command
    function $command {
      ssh `echo $SSH_CLIENT | awk '{print $1}'` "zsh -i -c \"$command $@\"";
    }
  done
fi
