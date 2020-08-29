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
    zsh-users/zsh-autosuggestions \
    zdharma/history-search-multi-word \
    zdharma/fast-syntax-highlighting \
    geometry-zsh/geometry \
    matteocellucci/globalias \
    Aloxaf/fzf-tab \
    jedahan/consistent-git-aliases \
    jedahan/laser \
    jedahan/help.zsh \
    jedahan/up.zsh >! $ZR
fi; source $ZR

# plugin options
export GLOBALIAS_EXCLUDE=(l ls ll)

# aliases
(( $+commands[sudo] )) && alias _=sudo
(( $+commands[doas] )) && alias _=doas
(( $+commands[fd] )) && alias f=fd
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'
(( $+commands[rg] )) && alias s=rg rgh='rg --hidden'
(( $+commands[exa] )) && alias tree='exa --tree --level=2'
(( $+commands[exa] )) && alias ls='exa --icons --group-directories-first'
(( $+commands[exa] )) && alias l='exa -s type --icons --group-directories-first'
(( $+commands[exa] )) && alias ll='exa -lbGF --git'
(( $+commands[exa] )) && alias ,='clear && l'
(( $+commands[bat] )) && alias c='bat -p'
(( $+commands[kiss] )) && alias k='kiss'
(( $+commands[kiss] )) && alias kb='k b' ki='k i' ks='k s' kbi='k bi'
(( $+commands[vscodium ])) && alias code='vscodium'

# functions
t() { cd $(mktemp -d) } # cd into temporary directory
down() { t; http -d "$1"; ll } # download a file to temporary directory
mpw() { . ~/.secrets/mpw && command mpw-rs -t x "$@" -x; unset MP_FULLNAME } # password manager
tm() { tmux -f $HOME/.config/tmux.conf new-session -n "${1:-${RANDOM}}" } # tmux session management
git() { if [[ $PWD != $HOME ]]; then command git "$@"; else command git -C .dotfiles "$@"; fi } # dotfiles
