bindkey -e

if [[ -z $TMUX && -z $SSH_CLIENT ]]; then
  tmux attach || tmux
  _icons=( ⚡                       )
  tmux rename-window "${_icons[RANDOM % $#_icons + 1]} "
fi
function s { rg $@ }
function t { (($#)) && echo -E - "$*" >> ~/todo.md || s '###' ~/todo.md --replace '⌫ ' | lolcat }; t # t: add or display todo items

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
export RIPZ_TEXT=' '

export FZF_DEFAULT_COMMAND='rg --files --follow'

test -f $HOME/.zpm-init.zsh && source $_ || {
  zpm zsh-users/prezto modules/git           # sensible git aliases
  zpm junegunn/fzf                           # fuzzy finder, try ^r, ^t, kill<tab>
  zpm zsh-users/zsh-autosuggestions          # suggest from history
  zpm zsh-users/zsh-syntax-highlighting      # commandline syntax highlighting
  zpm zsh-users/zsh-history-substring-search # partial fuzzy history search
  zpm jedahan/ripz                           # help remember aliases
  zpm frmendes/geometry                      # clean theme
  zpm jedahan/geometry-hydrate               # remind you to hydrate
}

source ~/.zpm/plugins/junegunn/fzf/shell/key-bindings.zsh         # fzf keybindings
source ~/.zpm/plugins/zsh-users/prezto/modules/git/*zsh           # sensible git aliases
source ~/.zpm/plugins/zsh-users/prezto/modules/history/*zsh       # sensible history defaults
source ~/.zpm/plugins/zsh-users/prezto/modules/homebrew/*zsh      # sensible homebrew shortcuts

export GEOMETRY_PROMPT_PLUGINS=(exec_time git +rustup hydrate)

#source <(kubectl completion zsh 2>/dev/null)

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

[[ `gist --version | cut -d'.' -f1` = "3" ]] || _gist_copy='--copy'
alias gist="gist --private $_gist_copy"
function badge { printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$@" | base64) }
function twitch { livestreamer twitch.tv/$@ high || livestreamer twitch.tv/$@ 720p30}
function notify { osascript -e "display notification \"$2\" with title \"$1\"" }

function anybar { echo -n $1 | nc -4u -w10 localhost ${2:-1738} }

function up { # upgrade everything
  uplog=$(mktemp -t up.XXXXXX)
  (($+commands[tmux])) && {
    tmux select-window -t update 2>/dev/null || tmux rename-window update
    tmux split-window -d -p 40 -t update "echo    $uplog; tail -f $uplog"
  }

  function fun { (( $+functions[$1] || $+commands[$1] )) && echo -n "updating $2..." }
  fun homeshick 'dotfiles' && { homeshick pull }                           &>> $uplog ; c <<< 
  fun zplug 'zsh plugins'  && { zplug install; zplug update }              &>> $uplog ; c <<< ▲
  fun tldr 'tldr'          && { tldr --update }                            &>> $uplog ; c <<< ⚡
  fun brew 'brews'         && { brew update; brew upgrade; brew cleanup }  &>> $uplog ; c <<< 
  fun nvim 'neovim'        && { nvim +PlugUpdate! +PlugClean! +qall }      &>> $uplog ; c <<< 
  fun rustup 'rust'        && { rustup update stable; rustup update beta } &>> $uplog ; c <<< 
  fun cargo 'crates'       && { cargo install-update --all }               &>> $uplog ; c <<< 

  s 'Updated!\s+(.+/.+)' -r '$1' -N $uplog
  s 'updated.*rustc' -N $uplog | cut -d' ' -f7
  s 'Upgrading' -A1 -N $uplog | head -2 | tail -1
  s '(.*)Yes$' --replace '$1' $uplog

  (($+commands[tmux])) && tmux kill-pane -t 0:update.-1
}

if [[ -n $SSH_CLIENT ]]; then # remote pbcopy, pbpaste, notify
  for command in pb{copy,paste} notify anybar; do
    (( $+commands[$command] )) && unfunction $command
    function $command {
      ssh `echo $SSH_CLIENT | awk '{print $1}'` "zsh -i -c \"$command $@\"";
    }
  done

  (( $+commands[dbaliases] )) && source $(dbaliases)
  (( $+commands[review] )) && r() { (( ! $# )) && echo "$0 reviewer [cc [cc...]]" || EDITOR=true review -g -r $1 ${2+-c "${(j.,.)@[2,-1]}"} }

  alias p='~/development/Etsyweb/bin/dev_proxy'; alias pon='p on'; alias pof='p off'; alias prw='p rw'
  alias -g INFO='/var/log/httpd/info.log'
  alias -g ERROR='/var/log/httpd/php.log'
else
  alias try="ssh vm 'try -P'"
  function vm {
    tmux select-pane -t:.0 -P 'bg=colour236'
    ssh vm $@
    tmux select-pane -t:.0 -P 'bg=black'
  }

  function bat {
    battery=$(ioreg -rc AppleSmartBattery)
    function _stat {
      echo $battery | rg --no-line-number ".*?$1.*?(\d+)" --replace '$1'
    }
    current_capacity=$(_stat CurrentCapacity)
    max_capacity=$(_stat MaxCapacity)
    percent=$(( 100 * $current_capacity / $max_capacity ))
    echo "$current_capacity mAh (${percent}%)"
  }
fi

if [[ $HOST == *etsy.com ]]; then cd ~/development/Etsyweb; fi
