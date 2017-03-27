bindkey -e

[[ -z $TMUX && -z $SSH_CLIENT ]] && { tmux attach || tmux }
_icons=( ⚡                       )
tmux rename-window "${_icons[RANDOM % $#_icons + 1]} "

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

export GEOMETRY_PROMPT_PLUGINS=(exec_time git +rustup hydrate)

test -f $HOME/.zpm-init.zsh && source $_ || {
  zpm zsh-users/prezto modules/git           # sensible git aliases
  zpm junegunn/fzf                           # fuzzy finder, try ^r, ^t, kill<tab>
  zpm zsh-users/zsh-autosuggestions          # suggest from history
  zpm zsh-users/zsh-syntax-highlighting      # commandline syntax highlighting
  zpm zsh-users/zsh-history-substring-search # partial fuzzy history search
  zpm jedahan/ripz                           # help remember aliases
  zpm changyuheng/zsh-interactive-cd
  zpm frmendes/geometry                      # clean theme
  zpm jedahan/geometry-hydrate               # remind you to hydrate
  exec zsh
}

source ~/.zpm/plugins/junegunn/fzf/shell/key-bindings.zsh         # fzf keybindings
source ~/.zpm/plugins/zsh-users/prezto/modules/git/*zsh           # sensible git aliases
source ~/.zpm/plugins/zsh-users/prezto/modules/history/*zsh       # sensible history defaults
source ~/.zpm/plugins/zsh-users/prezto/modules/homebrew/*zsh      # sensible homebrew shortcuts

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

function up { # upgrade everything
  uplog=$(mktemp -t up)
  (($+commands[tmux])) && {
    tmux select-window -t update 2>/dev/null || tmux rename-window update
    tmux split-window -d -p 40 -t update "tail -f $uplog"
  }

  function fun { (( $+functions[$1] || $+commands[$1] )) && echo -n "updating $2..." }
  c <<< "  $uplog"
  fun config 'dotfiles'  && { config pull }                              &>> $uplog && c <<< 
  fun zpm 'zsh plugins'  && { zpm update }                               &>> $uplog && c <<< ▲ && s 'Updating [a-f0-9]{6}\.\.[a-f0-9]{6}' -B1 $uplog | s '\.\.\.' | cut -d' ' -f2 | paste -s -d'.' -
  fun tldr 'tldr'        && { tldr --update }                            &>> $uplog && c <<< ⚡
  fun brew 'brews'       && { brew upgrade; brew cleanup }               &>> $uplog && c <<< 
  fun nvim 'neovim'      && { nvim +PlugUpdate! +PlugClean! +qall }      &>> $uplog && c <<<  && s 'Updated!\s+(.+/.+)' -r '$1' -N $uplog | paste -s -
  fun rustup 'rust'      && { rustup update stable; rustup update beta } &>> $uplog && c <<<  && s 'updated.*rustc' -N $uplog | cut -d' ' -f7 | paste -s -
  fun cargo 'crates'     && { cargo install-update --all }               &>> $uplog && c <<<  && s '(.*)Yes$' --replace '$1' $uplog | paste -s -

  (($+commands[tmux])) && tmux kill-pane -t 0:update.-1
}

if [[ -n "$SSH_CLIENT" ]]; then # remote pbcopy, pbpaste, notify
  export PROMPT_GEOMETRY=$(prompt_geometry_colorize $PROMPT_GEOMETRY_COLOR ⬡)
  for command in pb{copy,paste}; do
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
  export PROMPT_GEOMETRY=$(prompt_geometry_colorize $PROMPT_GEOMETRY_COLOR $PROMPT_GEOMETRY_SYMBOL)
  alias try="ssh vm 'try -P'"
  function vm {
    tmux select-pane -t:.0 -P 'bg=colour236'
    ssh vm
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
