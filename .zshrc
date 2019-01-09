icons=(                     )
existing=($(tmux list-windows -F'#W'|paste -s -))
available=(${icons:|existing})
tmux bind-key c new-window -n ${available[RANDOM % $#available + 1]}

bindkey -e
setopt autocd autopushd pushd_ignore_dups interactivecomments
setopt bang_hist extended_history inc_append_history share_history hist_ignore_space hist_verify

autoload -Uz select-word-style && select-word-style bash
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste $_

(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'

export HISTFILE=${HOME}/.zhistory HISTSIZE=10000 SAVEHIST=10000 ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd \
  GEOMETRY_PROMPT=(geometry_status) \
  GEOMETRY_RPROMPT=(geometry_exec_time geometry_rustup geometry_node geometry_path geometry_git) \
  GEOMETRY_INFO=(geometry_todo)

(( $+commands[brew] )) && {
  test -f ~/.brew_env || brew shellenv > ~/.brew_env; source ~/.brew_env

  alias \
    brewi='brew install' \
    brewl='brew list' \
    brews='brew search' \
    brewu='brew upgrade' \
    brewx='brew uninstall' \
    cask='brew cask' \
    caski='cask install' \
    caskl='cask list' \
    casku='cask upgrade' \
    caskx='cask uninstall'
}

export FZF_FINDER_BINDKEY='^B'

if [[ ! -f ~/.zr/init.zsh ]] || [[ ~/.zshrc -nt ~/.zr/init.zsh ]]; then
  /Volumes/data/tmp/cargo/bin/zr load \
    sorin-ionescu/prezto/modules/git/alias.zsh \
    wfxr/forgit \
    zsh-users/zsh-autosuggestions \
    zdharma/fast-syntax-highlighting \
    zdharma/history-search-multi-word \
    leophys/zsh-plugin-fzf-finder \
    changyuheng/zsh-interactive-cd \
    jedahan/geometry-hydrate \
    jedahan/geometry-todo \
    geometry-zsh/geometry \
    ael-code/zsh-colored-man-pages \
    momo-lab/zsh-abbrev-alias \
    jedahan/laser \
    csurfer/tmuxrepl
fi
source ~/.zr/init.zsh || { sleep 3 && source ~/.zr/init.zsh }

alias manual=$commands[man] \
 find=${commands[fd]:-$commands[find]} \
 grep=${commands[rg]:-$commands[grep]} \
 ls=${commands[exa]:-$commands[ls]} \
 cat=${commands[bat]:-$commands[cat]} \
 sed=${commands[sd]:-$commands[sed]} \
 awk=${commands[sd]:-$commands[awk]}

(( $+commands[tldr] )) && function man {
  tldr -q $* || tldr -q -o linux $*
}

abbrev-alias help=man \
 h=man \
 x=exit \
 o=open \
 c=lolcat \
 _=sudo \
 s=grep \
 f=find \
 l=ls \
 ll='ls -l' \
 ,='clear && ls'

git() {
  [[ $PWD != $HOME ]] && { command git "$@"; return }
  command git --git-dir=.dotfiles --work-tree=. "$@"
}

function up { # upgrade everything
  uplog=/tmp/up; rm -rf $uplog >/dev/null; touch $uplog

  (( $+commands[tmux] )) && {
    window_name=`tmux list-windows -F '#{?window_active,#{window_name},}'`
    tmux select-window -t  2>/dev/null || tmux rename-window 
    tmux split-window -d -p 40 -t  "tail -f $uplog"
  }

  function e { if [ $? -eq 0 ]; then c <<< $1; else echo ":("; fi }
  function fun { (( $+aliases[$1] || $+functions[$1] || $+commands[$1] )) && echo -n "updating $2..." }

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

function par {
  parity --config=$HOME/.config/parity/config.toml &
  sleep 5 && sudo cputhrottle $(ps aux | awk '/[p]arity/ {print $2}') 50
}

test -f ~/.env && source ~/.env
