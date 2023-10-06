# zsh

## options
setopt \
  emacs \
  no_clobber \
  interactivecomments \
  extendedglob \
  autocd autopushd pushd_ignore_dups

## when pasting urls with glob characters (?*), surround in quotes
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

## prompt theme, and nicer history and tab-completion
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

# theme prompt
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
GEOMETRY_RPROMPT+=(geometry_node_version geometry_virtualenv)
export GEOMETRY_RPROMPT

# completions
zstyle ':completion:*' completer _expand_alias _complete _ignored
autoload -Uz compinit && compinit

## bun completions
[ -s "/Users/micro/.bun/_bun" ] && source "/Users/micro/.bun/_bun"

## z completions
eval "$(zoxide init zsh)"

## cargo and rustup completions
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

## stable diffusion cli
stable() {
	text=$1 
  test -z "$text" && text=$(fortune -s | grep -v ':$' | head -n1)
	cd ~/src/stable-diffusion
  . venv/bin/activate
  directory=${text// /_} 
  mkdir -p $directory
  open $directory
	times=${2:-9} 
	repeat $times
	do
		seed=$RANDOM 
    python scripts/txt2img.py \
      --prompt "$text" \
      --n_samples 1 --n_iter 1 --plms \
      --outdir="$directory"
	done
}

## dalle generative images 
dalle() {
	text=$1 
  test -z "$text" && text=$(fortune -s | grep -v ':$' | head -n1)
	cd ~/src/min-dalle
  directory=${text// /_} 
  mkdir -p $directory
  open $directory
	times=${2:-9} 
	repeat $times
	do
		seed=$RANDOM 
		python3 image_from_text.py --text="$text" --seed=$seed --image_path="${directory}/${seed}.png"
	done
}

nvim-to-pdf() { nvim +"hardcopy > out.ps" $1 +qall && ps2pdf out.ps ${1/.*/.pdf} && rm out.ps;}

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

equinox() {
  tmux new-session -A \
    -c work/reaktor/equinox \
    -s equinox -n code \
    hx WearableData
}

plan() {
  PLAN=$(mktemp)
  curl --silent --output $PLAN https://plan.cat/~micro
  $EDITOR $PLAN
  curl --silent --user micro --form "plan=<$PLAN" https://plan.cat/stdin
}
