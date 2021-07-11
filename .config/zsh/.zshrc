# zsh options
setopt autocd autopushd interactivecomments no_clobber pushd_ignore_dups

# history
setopt bang_hist extended_history hist_ignore_space hist_verify inc_append_history share_history
zstyle ":history-search-multi-word" page-size "$(( $LINES * 3 / 4 ))"

# navigation
bindkey -e
autoload -Uz select-word-style && select-word-style bash

# completion
autoload -U compinit; compinit

# autocomplete
zstyle ':autocomplete:tab:*' fzf-completion yes
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''

# fzf-tab
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

# marlonrichert/zsh-autocomplete

# plugins
(( $+commands[zr] )) && {
  ZR=${XDG_CACHE_HOME:-${HOME}/.cache}/zr/zr.zsh
  # if there is no ZR file, or this file is newer
  [[ ! -s $ZR || ${(%):-%N} -nt $ZR ]] && {
    zr \
      matteocellucci/globalias \
      zsh-users/zsh-autosuggestions \
      zsh-packages/ls_colors \
      zdharma/fast-syntax-highlighting \
      zdharma/history-search-multi-word \
      aloxaf/fzf-tab \
      geometry-zsh/geometry \
      jedahan/consistent-git-aliases \
      jedahan/laser \
      jedahan/help.zsh \
      jedahan/up.zsh \
      | grep -v compinit \
      >! $ZR
  }
  source $ZR
}

# plugin options
export GLOBALIAS_EXCLUDE=(l ls ll e)

# aliases
(( $+commands[ssu] )) && alias _=ssu || alias _=sudo
(( $+commands[btm] )) && alias top=btm
(( $+commands[fd] )) && alias f=fd
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'
(( $+commands[rg] )) && alias s=rg rgh='rg --hidden'
(( $+commands[exa] )) && alias tree='exa --tree --level 2' lst=tree
(( $+commands[exa] )) && alias ls='exa --icons --group-directories-first'
(( $+commands[exa] )) && alias l='exa --icons --group-directories-first --sort type'
(( $+commands[exa] )) && alias ll='exa --long --binary --grid --classify --git'
(( $+commands[exa] )) && alias ,='clear && l'
(( $+commands[bat] )) && alias c='bat -p' || alias c='cat'
(( $+commands[kiss] )) && alias k='kiss'
(( $+commands[kiss] )) && alias kb='k b' ki='k i' ks='k s' kbi='k bi'
(( $+commands[vscodium ])) && alias code='vscodium'
(( $+commands[wget ])) || alias wget='curl -Os'
(( $+EDITOR )) && alias e="$EDITOR"

# file suffix aliases
alias -s md=e gmi=e
alias -s png=imv jpg=imv

# functions
t() { cd $(mktemp -d) } # cd into temporary directory
tget() { t; http -d "$1"; ll } # download a file to temporary directory
mpw() { . ~/.secrets/mpw && command mpw-rs -t x "$@" -x; unset MP_FULLNAME } # password manager
tm() { tmux new-session -n "${1:-${RANDOM}}" "${${@:2}:-zsh}" } # tmux session management
git() { if [[ $PWD != $HOME ]]; then command git "$@"; else command git -C .dotfiles "$@"; fi } # dotfiles
wall() { imv -c 'bind <Return> exec ogurictl output \* --image "$imv_current_file" ; quit' ~/images/walls/* }
patchbay() { curl https://patchbay.pub/pubsub/hello-pi-a ${@:+-d "$*"} }
wifi-add() { printf $2 | iwd_passphrase $1 | sls tee /var/lib/iwd/"$1".psk }
wg-up() { sls wg-quick up $HOME/data/wireguard/pi.conf }
wg-down() { sls wg-quick down $HOME/data/wireguard/pi.conf }
channel-id() { curl -s https://www.youtube.com/c/$1 | htmlparser 'meta[itemprop="channelId"] attr{content}' }
showme() { curl -s $1 | img2sixel -w $((2 * $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).rect.width'))) }
