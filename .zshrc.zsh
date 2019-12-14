# tmux
icons=(                     )
existing=($(tmux list-windows -F'#W'|paste -s -))
available=(${icons:|existing})
export ICON=${available[RANDOM % $#available + 1]}
grep -q zsh <(tmux list-windows -F'#W') && tmux rename-window $ICON
tmux bind-key -n C-n new-window -n $ICON

# zsh options
bindkey -e
setopt autocd autopushd pushd_ignore_dups interactivecomments
setopt bang_hist extended_history inc_append_history share_history hist_ignore_space hist_verify
autoload -Uz select-word-style && select-word-style bash
export HISTFILE=${HOME}/.zhistory HISTSIZE=100000 SAVEHIST=100000 ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
zstyle ":history-search-multi-word" page-size "$(( $LINES * 3 / 4 ))"

# plugins
ZR=${XDG_CONFIG_HOME:-${HOME}/.config}/zr.zsh
if [[ ! -s $ZR ]] || [[ ~/.zshrc -nt $ZR ]]; then
  zr \
    asdf-vm/asdf.git/asdf.sh \
    asdf-vm/asdf.git/completions/asdf.bash \
    denisidoro/navi \
    sorin-ionescu/prezto.git/modules/git/alias.zsh \
    zsh-users/zsh-autosuggestions \
    momo-lab/zsh-abbrev-alias \
    zdharma/history-search-multi-word \
    zdharma/fast-syntax-highlighting \
    geometry-zsh/geometry \
    rupa/z \
    jedahan/laser \
    jedahan/help.zsh \
    jedahan/up.zsh > $ZR
fi; source $ZR
test -f /etc/zsh_command_not_found && source $_ || true

# default commands
alias manual=$commands[man] \
 find=${commands[fd]:-$commands[find]} \
 grep=${commands[rg]:-$commands[grep]} \
 cat=${commands[bat]:-$commands[cat]} \
 sed=${commands[sd]:-$commands[sed]} \
 awk=${commands[sd]:-$commands[awk]} \
 fzf=${commands[sk]:-$commands[fzf]}

# aliases
(( $+commands[rg] )) && export FZF_DEFAULT_COMMAND='rg --files --follow'
(( $+commands[exa] )) && alias tree='exa --tree --level=2'

abbrev-alias x=exit \
 o=xdg-open \
 c=lolcat \
 _=sudo \
 s=grep \
 code=vscodium \
 h=help \
 ls=exa \
 l='exa -s type' \
 ll='exa -lbGF --git' \
 ,='clear && l'

# functions
rfc() { zcat $(fd "$@" /usr/share/doc/RFC) | less }
t() { cd $(mktemp -d /tmp/$1.XXXX) }
config() { command git --git-dir=$HOME/.dotfiles --work-tree=$HOME/. "$@" }
git() { [[ $PWD != $HOME ]] && { command git "$@"; return } || config "$@" }
mpw() { . ~/.secrets && command mpw -t x "$@" | tee >(xsel -ib) >(xsel -i) 1>/dev/null; unset MPW_FULLNAME MPW_ASKPASS }
alert() { notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')" }
