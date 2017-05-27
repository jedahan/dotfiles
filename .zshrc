bindkey -e

[[ -z "$TMUX" && -z "$SSH_CLIENT" ]] && { tmux attach || tmux }
_icons=( ⚡                      )
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

test -f ~/.zr/init.zsh && source $_ || {
  zr add zsh-users/prezto modules/git/alias.zsh    # sensible git aliases
  zr add zsh-users/prezto modules/history/init.zsh # sensible history settings
  zr add zsh-users/prezto modules/osx/init.zsh     # some osx shortcuts
  zr add junegunn/fzf shell/key-bindings.zsh       # fuzzy finder, try ^r, ^t, kill<tab>
  zr add zsh-users/zsh-autosuggestions             # suggest from history
  zr add zdharma/fast-syntax-highlighting          # commandline syntax highlighting
  zr add zsh-users/zsh-history-substring-search    # partial fuzzy history search
  zr add molovo/tipz                               # help remember aliases
  zr add changyuheng/zsh-interactive-cd            # fuzzy finding on tabcomplete for cd
  zr add frmendes/geometry                         # clean theme
  zr add jedahan/geometry-hydrate                  # remind you to hydrate
  source ~/.zr/init.zsh
}

bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

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

function config { git --git-dir=$HOME/.dotfiles --work-tree=$HOME $@ }

function badge { printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$@" | base64) }
function twitch { livestreamer twitch.tv/$@ high || livestreamer twitch.tv/$@ 720p30}

function up { # upgrade everything
  uplog=$(mktemp -t up)
  (($+commands[tmux])) && {
    tmux select-window -t update 2>/dev/null || tmux rename-window update
    tmux split-window -d -p 40 -t update "tail -f $uplog"
  }

  function fun { (( $+functions[$1] || $+commands[$1] )) && echo -n "updating $2..." }
  function e { if [ $? -eq 0 ]; then c <<< $1; else echo ":("; fi }
  c <<< "  $uplog"
  fun config 'dotfiles' && { config pull }                         &>> $uplog; e 
  fun zr 'zsh plugins'  && { zr update }                           &>> $uplog; e ▲ && s 'Updating [a-f0-9]{6}\.\.[a-f0-9]{6}' -B1 $uplog
  fun tldr 'tldr'       && { tldr --update }                       &>> $uplog; e ⚡
  fun brew 'brews'      && { brew upgrade; brew cleanup }          &>> $uplog; e 
  fun nvim 'neovim'     && { nvim +PlugUpdate! +PlugClean! +qall } &>> $uplog; e  && s 'Updated!\s+(.+/.+)' -r '$1' -N $uplog | paste -s -
  fun rustup 'rust'     && { rustup update }                       &>> $uplog; e  && s 'updated.*rustc' -N $uplog | cut -d' ' -f7 | paste -s -
  fun cargo 'crates'    && { cargo install-update --all }          &>> $uplog; e  && s '(.*)Yes$' --replace '$1' $uplog | paste -s -

  (($+commands[tmux])) && tmux kill-pane -t 0:update.-1
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

if [[ $HOST == *vpn*etsy* ]]; then
    alias try="ssh vm 'try -P'"
    function vm {
      tmux select-pane -t:.0 -P 'bg=colour236'
      old_name=`tmux list-windows | grep '*' | cut -d' ' -f2 | cut -d'*' -f1`
      tmux rename-window .$old_name
      ssh vm
      tmux rename-window "$old_name"
      tmux select-pane -t:.0 -P 'bg=black'
    }
fi

if [[ $HOST == *vm*etsy* ]]; then
  (( $+commands[dbaliases] )) && source $(dbaliases)
  (( $+commands[review] )) && r() { (( ! $# )) && echo "$0 reviewer [cc [cc...]]" || EDITOR=true review -g -r $1 ${2+-c "${(j.,.)@[2,-1]}"} }

  alias p='~/development/Etsyweb/bin/dev_proxy'; alias pon='p on'; alias pof='p off'; alias prw='p rw'
  alias -g INFO='/var/log/httpd/info.log'
  alias -g ERROR='/var/log/httpd/php.log'
fi

test -d ~/development/Etsyweb >/dev/null && cd $_ || echo -n
