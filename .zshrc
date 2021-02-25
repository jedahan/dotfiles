setopt no_clobber \
  interactivecomments \
  autocd autopushd pushd_ignore_dups

source <(zr \
  geometry-zsh/geometry \
  aloxaf/fzf-tab \
  zsh-users/zsh-autosuggestions \
  zdharma/fast-syntax-highlighting \
  jedahan/consistent-git-aliases \
  jedahan/track
)

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
  la='exa -a'

git() { command git -C ${PWD:/${HOME}/.dotfiles} $* }
