export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="philips"
plugins=(brew gem git history-substring-search npm node osx zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias of="open ."
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
[[ -s "/Users/jedahan/.rvm/scripts/rvm" ]] && source "/Users/jedahan/.rvm/scripts/rvm"
