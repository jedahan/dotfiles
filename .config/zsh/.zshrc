# zsh options
setopt autocd autopushd interactivecomments no_clobber pushd_ignore_dups

# history
setopt bang_hist extended_history hist_ignore_space hist_verify inc_append_history share_history
zstyle ":history-search-multi-word" page-size "$(( $LINES * 3 / 4 ))"

# navigation and completion
bindkey -e
autoload -Uz select-word-style && select-word-style bash
autoload -Uz compinit && compinit

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
test -f /etc/zsh_command_not_found && source $_ || true

# aliases
(( $+commands[sudo] )) && alias _=sudo
(( $+commands[doas] )) && alias _=doas
(( $+commands[fd] )) && alias f=fd
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'
(( $+commands[rg] )) && alias s=rg
(( $+commands[exa] )) && alias tree='exa --tree --level=2'
(( $+commands[exa] )) && alias ls='exa --icons --group-directories-first'
(( $+commands[exa] )) && alias l='exa -s type --icons --group-directories-first'
(( $+commands[exa] )) && alias ll='exa -lbGF --git'
(( $+commands[exa] )) && alias ,='clear && l'
(( $+commands[bat] )) && alias c='bat -p'
(( $+commands[kiss] )) && alias k='_ kiss'
(( $+commands[kiss] )) && alias kb='k b' ki='k i' ks='k s'
(( $+commands[vscodium ])) && alias code='vscodium'

# functions
debian() { _ efibootmgr --bootnext 2 && _ reboot }
rfc() { zcat $(fd ".*$@.*.txt.gz" /usr/share/doc/RFC|head -1) | less }
t() { cd $(mktemp -d -p /tmp) } # cd into temporary directory
download() { t; http -d "$1"; ll } # download a file to temporary directory
mpw() { . ~/.secrets/mpw && command mpw-rs -t x "$@" -x; unset MP_FULLNAME }
alert() { notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')" }

# dotfile management
config() { command git --git-dir=$HOME/.dotfiles --work-tree=$HOME/. "$@" }
git() { [[ $PWD != $HOME ]] && { command git "$@"; return } || config "$@" }

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

# start ssh-agent if it isnt started, and then load
pgrep -f 'ssh-agent' >/dev/null || ssh-agent | grep -v echo >! $HOME/.ssh-agent
source $HOME/.ssh-agent &>/dev/null
