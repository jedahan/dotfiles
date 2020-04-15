# zsh options
bindkey -e
setopt autocd autopushd pushd_ignore_dups interactivecomments no_clobber
setopt bang_hist extended_history inc_append_history share_history hist_ignore_space hist_verify
autoload -Uz select-word-style && select-word-style bash
autoload -Uz compinit && compinit
export HISTFILE=${HOME}/.zhistory HISTSIZE=100000 SAVEHIST=100000 ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
zstyle ":history-search-multi-word" page-size "$(( $LINES * 3 / 4 ))"
test -f ~/.cache/wal/sequences && (cat ~/.cache/wal/sequences &)

export EDITOR=${commands[amp]:-$commands[nvim]}
export VISUAL=$EDITOR

export LESS='-r'

# colored man pages
export LESS_TERMCAP_md=$(tput bold; tput setaf 4)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_mb=$(tput blink)
export LESS_TERMCAP_us=$(tput setaf 2)
export LESS_TERMCAP_ue=$(tput sgr0)
export LESS_TERMCAP_so=$(tput smso)
export LESS_TERMCAP_se=$(tput rmso)
export PAGER="${commands[less]:-$PAGER}"

# plugins
ZR=${XDG_CONFIG_HOME:-${HOME}/.config}/zr.zsh
ZSHRC=${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/.zshrc
if [[ ! -s $ZR ]] || [[ $ZSHRC -nt $ZR ]]; then
  zr \
    asdf-vm/asdf.git/asdf.sh \
    asdf-vm/asdf.git/completions/asdf.bash \
    denisidoro/navi \
    sorin-ionescu/prezto.git/modules/git/alias.zsh \
    zsh-users/zsh-autosuggestions \
    zdharma/history-search-multi-word \
    zdharma/fast-syntax-highlighting \
    geometry-zsh/geometry \
    Aloxaf/fzf-tab \
    jedahan/laser \
    jedahan/help.zsh \
    jedahan/up.zsh >! $ZR
fi; source $ZR
test -f /etc/zsh_command_not_found && source $_ || true

# default commands
alias manual=$commands[man] \
 find=${commands[fd]:-$commands[find]} \
 grep=${commands[rg]:-$commands[grep]} \
 cat=${commands[bat]:-$commands[cat]} \
 cloc=${commands[tokei]:-$commands[cloc]} \
 dig=${commands[drill]:-$commands[dig]} \
 sed=${commands[sd]:-$commands[sed]} \
 awk=${commands[sd]:-$commands[awk]} \
 fzf=${commands[sk]:-$commands[fzf]}

# kiss package manager
(( $+commands[kiss] )) && alias \
  k='sudo --preserve-env=KISS_PATH,CFLAGS,CXXFLAGS,MAKEFLAGS kiss' \
  kb='k b' ki='k i' ks='k s'

# aliases
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'
(( $+commands[exa] )) \
  && alias tree='exa --tree --level=2' \
  && abbrev-alias ls=exa

abbrev-alias x=exit \
 f=find \
 s=grep \
 o=xdg-open \
 c='bat -p' \
 _=sudo \
 l='exa -s type' \
 ll='exa -lbGF --git' \
 code=vscodium \
 sys='systemctl --user' \
 h=help \
 ,='clear && l'

# functions
rfc() { zcat $(fd ".*$@.*.txt.gz" /usr/share/doc/RFC|head -1) | less }
t() { cd $(mktemp -d /tmp/$1.XXXX) }
down() { t; http -d "$1"; ll }
config() { command git --git-dir=$HOME/.dotfiles --work-tree=$HOME/. "$@" }
git() { [[ $PWD != $HOME ]] && { command git "$@"; return } || config "$@" }
mpw() { . ~/.secrets/mpw && command mpw-rs -t x "$@" | wl-copy -n; unset MP_FULLNAME }
alert() { notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')" }
