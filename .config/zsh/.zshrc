# zsh options
bindkey -e
setopt autocd autopushd pushd_ignore_dups interactivecomments no_clobber
setopt bang_hist extended_history inc_append_history share_history hist_ignore_space hist_verify
autoload -Uz select-word-style && select-word-style bash
autoload -Uz compinit && compinit
export HISTFILE=${HOME}/.zhistory HISTSIZE=100000 SAVEHIST=100000 ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
zstyle ":history-search-multi-word" page-size "$(( $LINES * 3 / 4 ))"

export EDITOR=${commands[amp]:-$commands[nvim]}
export VISUAL=$EDITOR

export LESS='-r'

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
gitbug() { git rev-parse 2>/dev/null && { git bug ls --status open | wc -l } }
GEOMETRY_RPROMPT+=(gitbug)
test -f /etc/zsh_command_not_found && source $_ || true

# kiss package manager
(( $+commands[kiss] )) && alias \
  k='sudo --preserve-env=KISS_PATH,CFLAGS,CXXFLAGS,MAKEFLAGS kiss' \
  kb='k b' ki='k i' ks='k s'

# aliases
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'
(( $+commands[exa] )) \
  && alias tree='exa --tree --level=2' \
  && abbrev-alias ls='exa --icons --group-directories-first'

alias f=fd \
 s=rg \
 o=xdg-open \
 _=sudo \
 code=codium \
 h=help \
 c='bat -p' \
 l='exa -s type --icons --group-directories-first' \
 ll='exa -lbGF --git' \
 sys='systemctl --user' \
 ,='clear && l'

# expand aliases
globalias() {
   zle _expand_alias
   zle expand-word
   zle self-insert
}
zle -N globalias
bindkey " " globalias
bindkey "^ " magic-space
bindkey -M isearch " " magic-space # normal space during searches

# functions
rfc() { zcat $(fd ".*$@.*.txt.gz" /usr/share/doc/RFC|head -1) | less }
t() { cd $(mktemp -d /tmp/$1.XXXX) }
down() { t; http -d "$1"; ll }
config() { command git --git-dir=$HOME/.dotfiles --work-tree=$HOME/. "$@" }
git() { [[ $PWD != $HOME ]] && { command git "$@"; return } || config "$@" }
mpw() { . ~/.secrets/mpw && command mpw-rs -t x "$@" | wl-copy -n; unset MP_FULLNAME }
alert() { notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')" }
