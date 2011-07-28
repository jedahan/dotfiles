export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="philips"
plugins=(brew gem git git-flow history-substring-search npm node osx ruby rvm zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export CLICOLORS=1

export NODE_PATH="/usr/local/lib/node:$NODE_PATH"
alias of="open ."
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
[[ -s "/Users/jedahan/.rvm/scripts/rvm" ]] && source "/Users/jedahan/.rvm/scripts/rvm"
