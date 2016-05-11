bindkey -e

setopt autocd
setopt autopushd
setopt pushd_ignore_dups
setopt pushd_to_home
setopt interactivecomments

test -f ~/.zplug/init.zsh || git clone --single-branch https://github.com/zplug/zplug.git ~/.zplug
source ~/.zplug/init.zsh

zplugs=()
zplug "rimraf/k"
zplug "sindresorhus/pure", use:"{async,pure}.zsh"
zplug "djui/alias-tips", hook-load: "export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡  '"
zplug "andsens/homeshick", use:"homeshick.sh"
zplug "b4b4r07/enhancd", use:"zsh/enhancd.zsh"
zplug "joshuarubin/zsh-homebrew"
zplug "sorin-ionescu/prezto", use:"modules/git/alias.zsh"
zplug "sorin-ionescu/prezto", use:"modules/history/init.zsh"
zplug 'junegunn/fzf-bin', as:command, from:"gh-r", rename-to:"fzf", use:"*${$(uname):l}*amd64*"
zplug "junegunn/fzf", as:command, use:"bin/fzf-tmux", if:"(( $+commands[fzf] ))"
zplug "junegunn/fzf", use:'shell/key-bindings.zsh', if:"(( $+commands[fzf] ))"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", lazy:"true"
zplug "zsh-users/zsh-history-substring-search"
zmodload zsh/terminfo && [[ $(uname) == Darwin ]] && {
  bindkey "$terminfo[cuu1]" history-substring-search-up
  bindkey "$terminfo[cud1]" history-substring-search-down
}

zplug load

function t { (( $# )) && echo -E - "$*" >> ~/todo.md || { test -f ~/todo.md && c $_ } } # t: add or display todo items

function h help { man $@ }
function x { exit }
function s { sift --git --group $@ }
function o { open "${@:-'.'}" }
function a { atom "${@:-'.'}" }
function v { nvim $@ }
function c { lolcat $@ }
function _ { sudo $@ }
function , { clear && k }
function gcA { git commit --amend -C HEAD }

(( $+commands[curl] )) && alias curl='noglob curl'
(( $+commands[http] )) && alias http='noglob http'

# upgrade everything
function up {
  (( $+commands[homeshick] )) && homeshick pull
  (( $+commands[zplug] )) && zplug update
  (( $+commands[brew] )) && {
    brew update && \
    brew upgrade && \
    () { # brew upgrade --head --weekly
      last_week=`date -v -7d +%s`
      for pkg in `brew ls`; do
        install_date=`brew info $pkg | sift "source on ([\-\d+]+)" --replace '$1'`
        if (( $install_date )); then
          install_date=`date -j -f %Y-%m-%d $install_date +%s`
          (( $last_week > $install_date )) && brew reinstall $pkg
        fi
      done
    }
    brew cleanup && \
    brew cask cleanup && \
    brew doctor
  }
}

# fzf-enhanced functions
(( $+commands[fzf] )) && {
  # gl - git commit browser
  (( $+aliases[gl] )) && unalias gl
  function gl {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
        --bind "ctrl-m:execute:
                  echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % | less -R'"
  }

  # easy to kill
  function fkill {
    pid=$(ps -ef | sed 1d | fzf -m -e | awk '{print $2}')
    test $pid && kill -${1:-9} $_
  }
}

# cli notifications
(( ! $+commands[notify] )) && (( $+commands[osascript] )) && {
  function notify {
    osascript -e "display notification \"$2\" with title \"$1\""
  }
}

# shorthand for watching twitch on mpv
(( $+commands[mpv] )) && {
  function twitch {
    livestreamer --player-passthrough hls --player mpv twitch.tv/$@ source
  }
}

# iterm3 supports shell integration - like right click scp!
[[ $TERM_PROGRAM = iTerm.app ]] && {
  test -f ~/.iterm2_shell_integration.zsh && source $_
}

# remote pbcopy, pbpaste, notify
test ${SSH_CLIENT} && {
  for command in pb{copy,paste} notify; do
    (( ! $+commands[$command] )) && {
      function $command {
        ssh `echo $SSH_CLIENT | awk '{print $1}'` "zsh -i -c \"$command $@\"";
      }
    }
  done
}

test -f ~/.zshrc.local && source $_
(( $+commands[t] )) && t # show todo on new shell
