setopt no_clobber \
  interactivecomments \
  autocd autopushd pushd_ignore_dups

autoload -U select-word-style
select-word-style bash

autoload -Uz bracketed-paste-url-magic # quote urls
zle -N bracketed-paste bracketed-paste-url-magic

if [[ ! -f ~/.config/_zr ]] || [[ ~/.zshrc -nt ~/.config/_zr ]]; then
  zr \
    geometry-zsh/geometry \
    aloxaf/fzf-tab \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    jedahan/consistent-git-aliases \
    jedahan/track \
    >! ~/.config/_zr
fi
source ~/.config/_zr

# fzf
test -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh && source $_

# geometry
export GEOMETRY_PROMPT=(\
  geometry_newline \
  geometry_path geometry_newline \
  geometry_status \
)

geometry_node_version() {
  (( $+commands[node] )) || return
  test -f package.json || test -f yarn.lock || return 1
  node -v 2>/dev/null
}
GEOMETRY_RPROMPT+=(geometry_node_version)
export GEOMETRY_RPROMPT

(($+commands[exa])) && alias \
  ls='exa' \
  ll='exa -l' \
  la='exa -a' \
  ,='exa'

(($+commands[fcp])) && alias cp='fcp'
(($+commands[dog])) && alias dig='dog'
(($+commands[codium])) && alias code='codium'
(($+commands[yt-dlp])) && alias yt='yt-dlp'

git() { command git -C ${PWD:/${HOME}/.dotfiles} $* }

zstyle ':completion:*' completer _expand_alias _complete _ignored
