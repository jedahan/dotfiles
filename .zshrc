## zsh options
setopt \
  emacs \
  no_clobber \
  interactivecomments \
  extendedglob \
  autocd autopushd pushd_ignore_dups

## when pasting urls with glob characters (?*), surround in quotes
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

## geometry prompt theme, improved history and tab-completion
if [[ ! -f ~/.config/_zr ]] || [[ ~/.zshrc -nt ~/.config/_zr ]]; then
  zr \
    aloxaf/fzf-tab \
    geometry-zsh/geometry \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    jedahan/consistent-git-aliases \
    joshskidmore/zsh-fzf-history-search \
    >! ~/.config/_zr
fi
source ~/.config/_zr

eval "$(zoxide init zsh)"

# theme prompt
export GEOMETRY_PROMPT=(\
  geometry_newline \
  geometry_path geometry_newline \
  geometry_status \
)

# add node version to right prompt
geometry_node_version() {
  (( $+commands[node] )) || return
  test -f package.json || test -f yarn.lock || return 1
  node -v 2>/dev/null
}
GEOMETRY_RPROMPT+=(geometry_node_version geometry_virtualenv)
export GEOMETRY_RPROMPT

# cache completions
zstyle ':completion:*' completer _expand_alias _complete _ignored
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do compinit; done
compinit -C

## add cargo and rustup completions
fpath+=~/.zfunc

# commands

## pkgx to run software
source <(pkgx --shellcode)

## aliases to nicer cli
(($+commands[eza])) && alias \
  ls='eza' \
  ll='eza -l' \
  la='eza -a' \
  ,='eza'

(($+commands[z])) && alias cd='z'
(($+commands[fcp])) && alias cp='fcp'
(($+commands[dog])) && alias dig='dog'
(($+commands[codium])) && alias code='codium'
(($+commands[yt-dlp])) && alias yt='yt-dlp'

## manage dotfiles with plain old git
git() { command git -C ${PWD:/${HOME}/.dotfiles} $* }

# ssh as root into whatever wired connection you got
ssh-link-local() {
   user=${1:-${USER}}
   interface=${2:-en9}
   >&2 echo searching for remote link local address for interface $interface
   local_regex='fe80::[a-z0-9:]+'
   my_addr=$(ifconfig "$interface" | rg --only-matching "${local_regex}")
   address=$(ping6 -c2 "ff02::1%${interface}" | grep -v $my_addr | rg --only-matching "${local_regex}")
   ssh_location="${user}@${address}%${interface}"

   read -r "confirm?ssh $ssh_location (y/N) "
   [[ $confirm == [yY] || $confirm == [yY][eE][sS ]] \
     && ssh $ssh_location
}

# update your plan file
plan() {
  PLAN=$(mktemp)
  curl --silent --output $PLAN https://plan.cat/~micro
  $EDITOR $PLAN
  curl --silent --user micro --form "plan=<$PLAN" https://plan.cat/stdin
}

# show local devices
lookaroundyou() {
  networkrange=${1:-192.168.1.0/24}
  sudo nmap -sS -PS -O $networkrange
}
