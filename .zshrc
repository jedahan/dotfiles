icons=(🌀                        )
icon="${icons[RANDOM % $#icons + 1]}"
tmux bind-key c new-window -n $icon

bindkey -e
setopt autocd autopushd pushd_ignore_dups interactivecomments

autoload -Uz select-word-style && select-word-style bash
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste $_

export FZF_FINDER_BINDKEY='^B'
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'

export GEOMETRY_PROMPT=(geometry_status geometry_hydrate)
export GEOMETRY_RPROMPT=(geometry_exec_time geometry_path geometry_git geometry_jobs geometry_rustup geometry_todo)
export GEOMETRY_RUSTUP_PIN=true
export GEOMETRY_GIT_SEPARATOR=" "
if [[ ! -f ~/.zr/init.zsh ]] || [[ ~/.zshrc -nt ~/.zr/init.zsh ]]; then
  zr load \
    sorin-ionescu/prezto/modules/git/alias.zsh \
    sorin-ionescu/prezto/modules/history/init.zsh \
    sorin-ionescu/prezto/modules/homebrew/init.zsh \
    zsh-users/zsh-autosuggestions \
    zdharma/fast-syntax-highlighting \
    changyuheng/zsh-interactive-cd \
    jedahan/geometry-hydrate \
    jedahan/geometry-todo \
    geometry-zsh/geometry \
    ael-code/zsh-colored-man-pages \
    momo-lab/zsh-abbrev-alias \
    jedahan/alacritty-completions \
    jedahan/laser \
    csurfer/tmuxrepl \
    zpm-zsh/ssh
fi
source ~/.zr/init.zsh

alias manual=$commands[man] \
 find=${commands[fd]:-$commands[find]} \
 grep=${commands[rg]:-$commands[grep]} \
 ls=${commands[exa]:-$commands[ls]} \
 cat=${commands[bat]:-$commands[cat]}

(( $+commands[tldr] )) && function man {
  tldr -q $* && return
  tldr -q -o linux $* && return
  local info=("${(@f)$(brew info --json=v1 $1 2>/dev/null | jq -r '.[].homepage,.[].desc')}")
  test $#info -gt 1 || info=("${(@f)$(cargo show $1 2>/dev/null | awk '/^homepage|description/ { $1=""; print }')}")
  test $#info -gt 1 || return
  hub -C ~/code/tldr issue | grep -q $1 || echo hub -C ~/code/tldr $repo issue create -F <(echo "page request: $1\n\nAdd documentation for [$1]($info[1])\n$info[2]")
}

abbrev-alias help=man \
 h=man \
 x=exit \
 o=open \
 a=atom \
 v=nvim \
 c=lolcat \
 _=sudo \
 s=grep \
 f=find \
 repl=tmuxrepl \
 l=ls \
 ll='ls -l'
function , { clear && ls }

git() { if [[ -d .dotfiles ]]; then GIT_DIR=$PWD/.dotfiles GIT_WORK_TREE=$PWD command git $@; else command git $@; fi }

function twitch { streamlink --twitch-oauth-token=$STREAMLINK_TWITCH_OAUTH_TOKEN twitch.tv/$1 ${2:-best} }

function up { # upgrade everything
  uplog=/tmp/up; rm -rf $uplog >/dev/null; touch $uplog

  (( $+commands[tmux] )) && {
    window_name=`tmux list-windows -F '#{?window_active,#{window_name},}'`
    tmux select-window -t  2>/dev/null || tmux rename-window 
    tmux split-window -d -p 40 -t  "tail -f $uplog"
  }

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

  (( $+commands[tmux] )) && {
    tmux kill-pane -t :.{bottom}
    tmux rename-window ${window_name//[[:space:]]/}
  }
}

function par() {
  parity \
    --config=$HOME/.config/parity/config.toml \
    --cache-size 1024 \
    --db-compaction ssd \
    --pruning fast \
    --mode active \
    --jsonrpc-threads 4 &
  sleep 5 && sudo cputhrottle $(ps aux | awk '/[p]arity/ {print $2}') 50
}
