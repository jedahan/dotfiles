bindkey -e

setopt autocd
setopt autopushd
setopt pushd_ignore_dups
setopt interactivecomments

autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡  '

export GEOMETRY_PROMPT_PLUGINS=(exec_time git rustup)
export GEOMETRY_SYMBOL_RUSTUP=
export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
export PROMPT_GEOMETRY_EXEC_TIME=true
export GEOMETRY_TIME_NEUTRAL='yellow'

export FZF_DEFAULT_COMMAND='rg --files --follow'

source ~/.zplug/init.zsh
zplug "andsens/homeshick", use:"homeshick.sh"                 # `homesick` dotfiles manager
zplug "sorin-ionescu/prezto", use:"modules/git/alias.zsh"     # sensible git aliases
zplug "sorin-ionescu/prezto", use:"modules/history/init.zsh"  # sensible history defaults
zplug "sorin-ionescu/prezto", use:"modules/homebrew/init.zsh" # sensible homebrew shortcuts
zplug "junegunn/fzf", use:"shell/*.zsh"                       # fuzzy finder, try ^r, ^t, kill<tab>
zplug "zsh-users/zsh-autosuggestions"                         # suggest from history
zplug "zsh-users/zsh-syntax-highlighting"                     # commandline syntax highlighting
zplug "zsh-users/zsh-history-substring-search"                # partial fuzzy history search
zplug "djui/alias-tips"                                       # help remember aliases
zplug "frmendes/geometry"                                     # clean theme
zplug load

bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

function h help { man $@ }
function x { exit }
function s { rg $@ }
function o { open "${@:-'.'}" }
function a { atom "${@:-'.'}" }
function v { nvim $@ }
function c { lolcat $@ }
function _ { sudo $@ }
function l { $LS $@ }
function ls { $LS $@ }
function ll { $LS -l $@ }
function , { clear && $LS }

alias vm='tmux rename-window vm && ssh vm'
alias gist='gist --private --copy'
function badge { printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$@" | base64) }
function twitch { livestreamer twitch.tv/$@ high || livestreamer twitch.tv/$@ 720p30}
function t { (($#)) && echo -E - "$*" >> ~/todo.md || s '###' ~/todo.md --replace '⌫ ' | lolcat -p 1}; t # t: add or display todo items
function notify { osascript -e "display notification \"$2\" with title \"$1\"" }

function anybar { echo -n $1 | nc -4u -w10 localhost ${2:-1738} }

function up { # upgrade everything
  (( $+functions[homeshick] )) && { echo "updating dotfiles..." && homeshick pull }
  (( $+functions[zplug] )) && { echo "updating zsh plugins..." && zplug update }
  (( $+commands[nvim] )) &&  { echo "updating nvim..." && nvim +PlugUpdate! +PlugClean! +qall }
  (( $+commands[brew] )) && { echo "updating homebrew packages..." && brew update; brew upgrade; brew cleanup }
  (( $+commands[rustup] )) && { echo "updating rust..." && rustup update stable; rustup update beta }
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
fi

function anybar { echo -n $1 | nc -4u -w10 $USER.prodvpn.etsy.com ${2:-1738}; }

if [[ -z $TMUX ]]; then { tmux attach || tmux }; fi
if [[ $HOST == *etsy.com ]]; then cd ~/development/Etsyweb; fi
