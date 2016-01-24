# Clone zgen if not found
source ~/.zshenv

source ~/.zplug/zplug.zsh || { git clone https://github.com/b4b4r07/zplug2.git ~/.zplug && source ~/.zplug/zplug.zsh }

# zsh plugins
zplug "rimraf/k"
zplug "djui/alias-tips"
zplug "b4b4r07/zplug"
zplug "b4b4r07/enhancd", of:"zsh/enhancd.zsh"
zplug "b4b4r07/emoji-cli"
zplug "joshuarubin/zsh-homebrew"
zplug "junegunn/fzf", of:shell/key-bindings.zsh
zplug "junegunn/fzf", as:command, of:bin/fzf-tmux
zplug "zsh-users/zsh-history-substring-search"
zplug "sorin-ionescu/prezto", of:modules/git/alias.zsh
zplug "sorin-ionescu/prezto", of:modules/history/init.zsh
zplug "mrowa44/emojify", as:command, of:emojify
zplug "ericfreese/zsh-autosuggest", at:rewrite
zplug "jimmijj/zsh-syntax-highlighting", nice:10

# prompt
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡 '
export EMOJI_CLI_KEYBIND='^ '

zplug load

bindkey -e

setopt autocd
setopt autopushd
setopt pushd_ignore_dups
setopt pushd_to_home

function a { atom ${@:-'.'} }
function v { vim ${@:-'.'} }
function o { open ${@:-'.'} }
function x { exit }
function c { lolcat $@ }
function s { sift --group $@ }
function , { clear && k }

alias please='sudo $(fc -ln -1)'
alias gist='gist -c'
alias space='df -hl'
alias big='dut | head'
alias ip='ipconfig getifaddr en0'

function git {  hub "$@" }

# update system
function up {
  brew update
  brew upgrade
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

unalias gl
# gl - git commit browser
function gl {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}

test -f ~/.zshrc.local && source ~/.zshrc.local
