die() {
  echo "$*" >&2
  return 1
}


## zsh options
setopt \
  emacs \
  no_clobber \
  interactivecomments \
  extendedglob \
  share_history \
  autocd autopushd pushd_ignore_dups

# set larger shared history in ~/.zshrc because macOS ships broken /etc/zshrc 
export HISTSIZE=1000000
export SAVEHIST=1000000

# zsh defaults
export NO_UPDATE_NOTIFIER=true
(($+commands[hx])) && export EDITOR=hx

# zsh history
setopt \
  HIST_EXPIRE_DUPS_FIRST \
  HIST_IGNORE_ALL_DUPS \
  HIST_IGNORE_DUPS \
  HIST_IGNORE_SPACE \
  HIST_REDUCE_BLANKS  \
  HIST_FIND_NO_DUPS \
  INC_APPEND_HISTORY \
  INC_APPEND_HISTORY_TIME \
  EXTENDED_HISTORY \

export HISTORY_IGNORE="(ls|cd|pwd|exit)*"

# icons for ls
export EZA_ICONS_AUTO=true

## when pasting urls with glob characters (?*), surround in quotes
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

## geometry prompt theme, improved history and tab-completion
if [[ ! -f ~/.config/_zr ]] || [[ ~/.zshrc -nt ~/.config/_zr ]]; then
  zr \
    aloxaf/fzf-tab \
    geometry-zsh/geometry \
    sunlei/zsh-ssh \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    jedahan/consistent-git-aliases \
    joshskidmore/zsh-fzf-history-search \
    >! ~/.config/_zr
fi
source ~/.config/_zr

(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

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

# add jj revset to right prompt
geometry_jj() {
  (( $+commands[jj] )) || return 1
  jj root --quiet >/dev/null 2>/dev/null || return 2

  jj log --revisions @ --no-graph --limit 1 --template \
    'change_id.shortest() ++ commit_id.shortest()'
}
GEOMETRY_RPROMPT+=(geometry_node_version geometry_virtualenv geometry_jj)
export GEOMETRY_RPROMPT

# cache completions
zstyle ':completion:*' completer _expand_alias _complete _ignored
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do compinit; done
compinit -C

## add cargo and rustup completions
fpath+=~/.zfunc

bindkey "^[[1;3D" backward-word # Alt + Left
bindkey "^[[1;3C" forward-word  # Alt + Right

# commands

## aliases to nicer cli
(($+commands[eza])) && alias \
  ls='eza' \
  ll='eza -l' \
  la='eza -a' \
  ,='eza'

(($+functions[z])) && alias cd='z'
(($+commands[bat])) && alias cat='bat'
(($+commands[dog])) && alias dig='dog'
(($+commands[yt-dlp])) && alias yt='yt-dlp'
(($+commands[podman])) && alias docker='podman'

## manage dotfiles with version control
jj() { command jj --repository ${PWD:/${HOME}/.dotfiles} $* }

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

# show local network devices
lookaroundyou() {
  (($+commands[nmap])) || die 'missing nmap'
  (($+commands[rg])) || die 'missing rg'
  myip=$(ifconfig en0 | rg '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' --only-matching --max-count=1 | head -n1)
  sudo nmap -sS -PS -O ${myip}/24
}

lookaroundyou6() {
  (($+commands[ping6])) || die 'missing ping6'
  ping6 ff02::1%en0
}

# broadcast over udp
broadcast() {
  (($+commands[socat])) || die 'missing socat'
  message=${1:-"hello world"}
  dstport=${2:-12345}
  srcport=$(rev <<< "$dstport")
  echo -ne $message | socat -u - udp-datagram:127.0.0.1:${dstport},sourceport=${srcport},broadcast,reuseaddr
}

# list local servers that are listening on a port
listening() { lsof -iTCP -sTCP:LISTEN -n -P +c 0 }

# print an unused port
find-unused-port() {
  port=$((RANDOM % 16384 + 49152))
  while netstat -an | grep LISTEN | grep -q "\.$port "; do
    port=$((RANDOM % 16384 + 49152))
  done
  echo $port
}

# ghostty terminfo
compdef ssh-copy-ghostty-terminfo=ssh
ssh-copy-ghostty-terminfo() {
  (( $# == 1 )) || die "usage: $0 <ssh_remote_host>"
  infocmp -x | ssh ${1} -- tic -x -
}

# jujutsu
(( $+commands[jj] )) && source <(jj util completion zsh)

# work
test -f ~/.config/zsh/work.zsh && . ~/.config/zsh/work.zsh || true
