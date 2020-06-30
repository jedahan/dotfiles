# zsh options
bindkey -e
setopt autocd autopushd pushd_ignore_dups interactivecomments no_clobber
setopt bang_hist extended_history inc_append_history share_history hist_ignore_space hist_verify
autoload -Uz select-word-style && select-word-style bash
autoload -Uz compinit && compinit
export HISTFILE=${HOME}/.zhistory HISTSIZE=100000 SAVEHIST=100000 ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
zstyle ":history-search-multi-word" page-size "$(( $LINES * 3 / 4 ))"

export EDITOR=${commands[nvim]:-$commands[vim]}
export VISUAL=$EDITOR

export LESS='-r'

# plugins
ZR=${XDG_CONFIG_HOME:-${HOME}/.config}/zr.zsh
ZSHRC=${(%):-%N} # this file
if (( $+commands[zr] )) && { [[ ! -s $ZR ]] || [[ $ZSHRC -nt $ZR ]] }; then
  zr \
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
gitbug() { git rev-parse 2>/dev/null && (( $+commands[git-bug] )) && { git bug ls --status open | wc -l } }
GEOMETRY_RPROMPT+=(gitbug)
test -f /etc/zsh_command_not_found && source $_ || true

# aliases
(( $+commands[sudo] )) && alias _=sudo
(( $+commands[fd] )) && alias f=fd
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'
(( $+commands[rg] )) && alias s=rg
(( $+commands[exa] )) && alias tree='exa --tree --level=2'
(( $+commands[exa] )) && alias ls='exa --icons --group-directories-first'
(( $+commands[exa] )) && alias l='exa -s type --icons --group-directories-first'
(( $+commands[exa] )) && alias ll='exa -lbGF --git'
(( $+commands[l] )) && alias ,='clear && l'
(( $+commands[bat] )) && alias c='bat -p'
(( $+commands[kiss] )) && alias k='sudo --preserve-env=KISS_PATH,CFLAGS,CXXFLAGS,MAKEFLAGS kiss'
(( $+commands[kiss] )) && alias kb='k b' ki='k i' ks='k s'
(( $+commands[vscodium ])) && alias code='vscodium'

# auto-expand aliases while typing - hold control when pressing space to ignore
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
t() { cd $(mktemp -d /tmp/$1.XXXX) } # cd into temporary directory
download() { t; http -d "$1"; ll } # download a file to temporary directory
mpw() { . ~/.secrets/mpw && command mpw-rs -t x "$@" | wl-copy -n; unset MP_FULLNAME }
alert() { notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')" }

# dotfile management via git
config() { command git --git-dir=$HOME/.dotfiles --work-tree=$HOME/. "$@" }
git() { [[ $PWD != $HOME ]] && { command git "$@"; return } || config "$@" }
