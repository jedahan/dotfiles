setopt no_clobber \
  interactivecomments \
  autocd autopushd pushd_ignore_dups

autoload -U select-word-style
select-word-style bash

autoload -Uz bracketed-paste-url-magic # quote urls
zle -N bracketed-paste bracketed-paste-url-magic

source <(zr \
  geometry-zsh/geometry \
  aloxaf/fzf-tab \
  zsh-users/zsh-autosuggestions \
  zdharma-continuum/fast-syntax-highlighting \
  jedahan/consistent-git-aliases \
  jedahan/track \
)

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

git() { command git -C ${PWD:/${HOME}/.dotfiles} $* }

# automatically switch to the correct node version in projects
node@16() { export PATH="/opt/homebrew/opt/node@16/bin:$PATH" }
node@14() { export PATH="/opt/homebrew/opt/node@14/bin:$PATH" }

switch_node_lts_current() {
  (( $+commands[node] )) || return
  test -f package.json || return
  engines=$(jq -r '.engines.node' package.json)
  [[ "$engines" == "null" ]] && return
  using=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
  echo $engines | rg --quiet '[^.]*(14)' && want=14 || want=16
  [[ "$want" != "$using" ]] && node@$want
}
chpwd_functions+=(switch_node_lts_current)
switch_node_lts_current || true
