bindkey -e # for ^A ^E

source ~/.zshenv

source ~/.zplug/init.zsh || {
  git clone https://github.com/b4b4r07/zplug2.git ~/.zplug && \
  source ~/.zplug/init.zsh && \
  zplug install && \
  source ~/.zshrc
}

# plugins
zplug "rimraf/k"
zplug "djui/alias-tips"
zplug "b4b4r07/zplug"
zplug "b4b4r07/enhancd", use:"zsh/enhancd.zsh"
zplug "b4b4r07/emoji-cli"
zplug "joshuarubin/zsh-homebrew"
zplug "sorin-ionescu/prezto", use:modules/git/alias.zsh
zplug "sorin-ionescu/prezto", use:modules/history/init.zsh
zplug "mrowa44/emojify", as:command, use:emojify
zplug "tarruda/zsh-autosuggestions", at:v0.2.x
zplug "zsh-users/zsh-history-substring-search"
zplug "jimmijj/zsh-syntax-highlighting", nice:10
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename_to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "junegunn/fzf", use:shell/key-bindings.zsh, nice:10

# prompt
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡 '
export EMOJI_CLI_KEYBIND='^ '

zplug load

setopt autocd
setopt autopushd
setopt pushd_ignore_dups
setopt pushd_to_home
setopt interactivecomments

function a { atom ${@:-'.'} }
alias v='nvim'
alias n='nvim'
function o { open ${@:-'.'} }
function x { exit }
function c { lolcat $@ }
function s { sift --git --group $@ }
function , { clear && k }

alias please='sudo $(fc -ln -1)'
alias gist='gist -c'
alias space='df -hl'
alias big='dut | head'
alias ip='ipconfig getifaddr en0'

function git {  hub "$@" }

# update system
function upgrade_head {
  brew info --json=v1 --installed \
  | jq 'map(select(.installed[0].version == "HEAD") | .name)' \
  | sift '"(.*?)"' --replace='$1' \
  | xargs brew reinstall
}
function up {
  brew update
  brew upgrade
  brew_upgrade_head
  brew cleanup
  brew cask cleanup
  brew doctor
}

# play a song from youtube
function play {
    youtube-dl --default-search=ytsearch: \
               --youtube-skip-dash-manifest \
               --output="${TMPDIR:-/tmp/}%(title)s-%(id)s.%(ext)s" \
               --restrict-filenames \
               --format="bestaudio[ext!=webm]" \
               --exec=afplay "$*"
}

# download the first mp3 from youtube
function mp3 {
    youtube-dl --default-search=ytsearch: \
               --restrict-filenames \
               --format=bestaudio \
               --extract-audio \
               --audio-format=mp3 \
               --audio-quality=1 "$*"
}

# more readable manpages
function man {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    PAGER=/usr/bin/less \
    _NROFF_U=1 \
      man "$@"
}

alias gl >/dev/null && unalias gl
# gl - git commit browser
function gl {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}

function fkill {
  pid=$(ps -ef | sed 1d | fzf -m -e | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

if (( ! $+commands[pbcopy] )); then
  function pbcopy {
    ssh `echo $SSH_CLIENT | awk '{print $1}'` pbcopy;
  }
fi

if (( ! $+commands[pbpaste] )); then
  function pbpaste {
    ssh `echo $SSH_CLIENT | awk '{print $1}'` pbpaste;
  }
fi

if (( ! $+commands[notify] )); then
  if [ -z ${SSH_CLIENT+x} ]; then
    function notify {
      /Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier -title $1 -message $2 -open $3
    }
  else
    function notify {
      ssh `echo $SSH_CLIENT | awk '{print $1}'` /Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier -title $1 -message $2 -open $3;
    }
  fi
fi

function twitch {
  mpv http://twitch.tv/$@
}

ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)

test -f ~/.zshrc.local && source ~/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
