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
# todo: update zr to handle recursive _completion search
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

export PATH=$(brew --prefix --installed node@16)/bin:$PATH

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
brew-up() { brew upgrade $(brew outdated | cut -f1 | grep -v gcc-arm-embedded | tr '\n' ' ') }
