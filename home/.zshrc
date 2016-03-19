bindkey -e
source ~/.zplug/init.zsh || {
  git clone https://github.com/b4b4r07/zplug2.git ~/.zplug && \
  source ~/.zplug/init.zsh
}

zplug "rimraf/k"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "djui/alias-tips"
zplug "andsens/homeshick", use:"homeshick.sh"
zplug "b4b4r07/enhancd", use:"zsh/enhancd.zsh"
zplug "joshuarubin/zsh-homebrew"
zplug "sorin-ionescu/prezto", use:modules/git/alias.zsh
zplug "sorin-ionescu/prezto", use:modules/history/init.zsh
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename_to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "junegunn/fzf", use:shell/key-bindings.zsh, nice:10
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡  '
export EMOJI_CLI_KEYBIND='^ '
zplug load

setopt autocd
setopt autopushd
setopt pushd_ignore_dups
setopt pushd_to_home
setopt interactivecomments

function t { (( $# )) && echo -E - "$*" >> ~/todo.md || c ~/todo.md } # t: add or display todo items

function x { exit }
function s { sift --git --group $@ }
function o { open "${@:-'.'}" }
function a { atom "${@:-'.'}" }
function v { nvim $@ }
function c { lolcat $@ }
function _ { sudo $@ }
function , { clear && k }

function help { man $@ }
alias h='help'

# upgrade everything
(( $+commands[brew] )) && {
  function up {
    brew update
    brew upgrade
    () { # brew upgrade --head --weekly
      local last_upgrade=$(brew --prefix)/.last-head-upgrade
      [[ -f ${last_upgrade}(.mh+168) ]] && {
        brew info --json=v1 --installed \
        | jq 'map(select(.installed[0].version == "HEAD") | .name)' \
        | sift '"(.*?)"' --replace='$1' \
        | xargs brew reinstall
        touch $last_upgrade
      }
    }
    brew cleanup
    brew cask cleanup
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
    test -z "$pid" && kill -${1:-9} $pid
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
    mpv http://twitch.tv/$@
  }
}

# iterm3 supports badges which is a note in the background
[[ $TERM_PROGRAM = iTerm.app ]] && {
  function badge {
    printf "\e]1337;SetBadgeFormat=%s\a" \
      $(echo -n "$@" | base64)
  }
}

# remote pbcopy, pbpaste, notify
test ${SSH_CLIENT} && {
  for command in pb{copy,paste} notify; do
    (( ! $+commands[$command] )) && {
      function $command {
        ssh `echo $SSH_CLIENT | awk '{print $1}'` "$command \"$@\"";
      }
    }
  done
}

test -f ~/.zshrc.local && source $_
clear && test -f ~/todo.md && c $_ # show todo on new shell
