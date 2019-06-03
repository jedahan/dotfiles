icons=(                     )
existing=($(tmux list-windows -F'#W'|paste -s -))
available=(${icons:|existing})
export ICON=${available[RANDOM % $#available + 1]}

tmux bind-key -n C-t new-window -n $ICON
tmux bind-key -n C-n new-window -n $ICON

bindkey -e
setopt autocd autopushd pushd_ignore_dups interactivecomments
setopt bang_hist extended_history inc_append_history share_history hist_ignore_space hist_verify

autoload -Uz select-word-style && select-word-style bash

export HISTFILE=${HOME}/.zhistory HISTSIZE=100000 SAVEHIST=100000 ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd

export FZF_FINDER_BINDKEY='^B'

(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'

(( $+commands[apt] )) && apt() {
  test "$1" = "add-repository" && cmd='sudo add-apt-repository'
  test "$1" = "add-key" && cmd='sudo apt-key add'
  test "$cmd" && { $cmd "$@" } || { command apt "$@" }
}

alias manual=$commands[man] \
 find=${commands[fd]:-$commands[find]} \
 grep=${commands[rg]:-$commands[grep]} \
 cat=${commands[bat]:-$commands[cat]} \
 sed=${commands[sd]:-$commands[sed]} \
 awk=${commands[sd]:-$commands[awk]} \
 fzf=${commands[sk]:-$commands[fzf]}

if [[ ! -s ~/.zr/init.zsh ]] || [[ ~/.zshrc -nt ~/.zr/init.zsh ]]; then
  zr load \
    sorin-ionescu/prezto/modules/git/alias.zsh \
    wfxr/forgit \
    rupa/z \
    DarrinTisdale/zsh-aliases-exa \
    zsh-users/zsh-autosuggestions \
    zdharma/fast-syntax-highlighting \
    zdharma/history-search-multi-word \
    changyuheng/zsh-interactive-cd \
    geometry-zsh/geometry \
    jedahan/geometry-hydrate \
    jedahan/geometry-todo \
    ael-code/zsh-colored-man-pages \
    momo-lab/zsh-abbrev-alias \
    jedahan/laser \
    zsh-users/zsh-completions
fi
source ~/.zr/init.zsh || { sleep 3 && source ~/.zr/init.zsh }
test -f /etc/zsh_command_not_found && source $_ || true
__zic_fzf_prog() { echo "sk --height 40%" }

abbrev-alias x=exit \
 o=open \
 c=lolcat \
 _=sudo \
 s=grep \
 f=find \
 code=vscodium \
 ,='clear && l'

config() { command git --git-dir=$HOME/.dotfiles --work-tree=$HOME/. "$@" }
git() { [[ $PWD != $HOME ]] && { command git "$@"; return } || config "$@" }
mpw() { MPW_ASKPASS=ssh-askpass command mpw -u "Jonathan Dahan" -t x -q "$@" | tee >(xsel -ib) >(xsel -i) 1>/dev/null }
alert() { notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')" }

(( $+commands[tldr] )) && function help {
  if [[ $# = 0 ]]; then \cat <<<'help v0.1.0

help [--os <type>] <command|all>

  <type>    linux, osx, sunos, other
     all    List all commands

Try `help --os linux tar`'; return; fi
  echo $* | grep -q all && tldr --list && return
  tldr -q $* || { tldr -q -o linux $* || manual $* }
} && abbrev-alias man=help h=help

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
  fun config 'dotfiles' && { config pull }                          &>> $uplog; e 
  fun zr 'zsh plugins'  && { zr update }                            &>> $uplog; e ▲ && s 'Updating [a-f0-9]{6}\.\.[a-f0-9]{6}' -B1 $uplog
  fun tldr 'tldr'       && { tldr --update }                        &>> $uplog; e ⚡
  fun apt 'apt'         && { sudo apt update; sudo apt -y upgrade } &>> $uplog; e 
  fun nvim 'neovim'     && { nvim '+PlugUpdate!' '+PlugClean!' '+qall' } &>> $uplog; e  && s 'Updated!\s+(.+/.+)' -r '$1' -N $uplog | paste -s -
  fun rustup 'rust'     && { rustup update }                        &>> $uplog; e  && s 'updated.*rustc' -N $uplog | cut -d' ' -f7 | paste -s -
  fun cargo 'crates'    && { cargo install-update --all }           &>> $uplog; e  && s '(.*)Yes$' --replace '$1' $uplog | paste -s -

  (( $+commands[tmux] )) && {
    tmux kill-pane -t :.{bottom}
    tmux rename-window ${window_name//[[:space:]]/}
  }
}
