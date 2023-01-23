setopt no_clobber \
  interactivecomments \
  autocd autopushd pushd_ignore_dups

set -o emacs # this is needed if 'vi' is found in EDITOR, thanks zsh

zstyle ':completion:*' completer _expand_alias _complete _ignored

if [[ ! -f ~/.config/_zr ]] || [[ ~/.zshrc -nt ~/.config/_zr ]]; then
  zr \
    aloxaf/fzf-tab \
    geometry-zsh/geometry \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    jedahan/consistent-git-aliases \
    asdf-vm/asdf \
    joshskidmore/zsh-fzf-history-search \
    >! ~/.config/_zr
fi
source ~/.config/_zr
eval "$(zoxide init zsh)"
# todo: update zr to handle recursive _completion search
fpath=(/Users/micro/src/solar-protocol/dev $fpath)
fpath=(${ASDF_DIR}/completions $fpath); compinit

autoload -Uz bracketed-paste-url-magic # quote urls
zle -N bracketed-paste bracketed-paste-url-magic

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

export PATH=$(brew --prefix)/opt/node@16/bin:$PATH

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

# Remind self to use meta+u to clear a line instead of SIGINT
zle-line-init() { trap "zle -M 'use meta+u ya dummy'" INT }
zle-line-finish() { trap - INT }
zle -N zle-line-init
zle -N zle-line-finish

title() { echo -en "\033]0;${*}\a" }
# workaround brew pin not supporting casks
brew-upgrade-ignore() {
  outdated=$(brew outdated | cut -f1 | grep -v ${*:-gcc-arm-embedded} | tr '\n' ' ')
  if [ -n "$outdated" ]; then brew upgrade ${=outdated}; fi
}

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

export PATH=$PATH:/Users/micro/src/solar-protocol

nvim-to-pdf() { nvim +"hardcopy > out.ps" $1 +qall && ps2pdf out.ps ${1/.*/.pdf} && rm out.ps;}

prompt() {
  read -r "confirm?$* (y/N) " && \
    [[ $confirm == [yY] || $confirm == [yY][eE][sS ]]
}

# ssh as root into whatever wired connection you got
ssh-link-local() {
   user=${1:-${USER}}
   interface=${2:-en9}
   >&2 echo searching for remote link local address for interface $interface
   local_regex='fe80::[a-z0-9:]+'
   my_addr=$(ifconfig "$interface" | rg --only-matching "${local_regex}")
   address=$(ping6 -c2 "ff02::1%${interface}" | grep -v $my_addr | rg --only-matching "${local_regex}")
   ssh_location="${user}@${address}%${interface}"
   prompt "ssh $ssh_location" && ssh $ssh_location || true
}

add-zsh-hook -Uz chpwd(){ source <(tea -Eds) }
