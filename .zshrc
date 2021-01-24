setopt no_clobber \
  interactivecomments \
  autocd autopushd pushd_ignore_dups

source <(zr \
  geometry-zsh/geometry \
  aloxaf/fzf-tab \
  zsh-users/zsh-autosuggestions \
  zdharma/fast-syntax-highlighting \
  jedahan/consistent-git-aliases \
)

export GEOMETRY_PROMPT=(\
  geometry_newline \
  geometry_path geometry_newline \
  geometry_status \
)

(($+commands[exa])) && alias \
  ls='exa' \
  ll='exa -l' \
  la='exa -a'
