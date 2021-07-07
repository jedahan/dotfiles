setopt no_clobber \
  interactivecomments \
  autocd autopushd pushd_ignore_dups

autoload -U select-word-style
select-word-style bash

# docker completions
user_completions=$HOME/.local/share/zsh/completions
echo $fpath | grep -q $user_completions || fpath+=($user_completions)
test -f $user_completions/_docker || \
  env DOCKER_CLI_VERSION=$(docker version --format '{{.Client.Version}}') \
    curl --location --output $user_completions/_docker \
    https://raw.githubusercontent.com/docker/cli/v${DOCKER_CLI_VERSION}/contrib/completion/zsh/_docker

source <(zr \
  geometry-zsh/geometry \
  aloxaf/fzf-tab \
  zsh-users/zsh-autosuggestions \
  zdharma/fast-syntax-highlighting \
  jedahan/consistent-git-aliases \
  jedahan/track \
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
  la='exa -a' \
  ,='exa'

(($+commands[fcp])) && alias cp='fcp'

git() { command git -C ${PWD:/${HOME}/.dotfiles} $* }

# replacing nvm.sh and autoenv
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

insights() { smug start insights -f ~/work/reaktor/sony/filtr/rti-scripts/real-time-insights.yml }
