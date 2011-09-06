export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="philips"
plugins=(brew gem git history-substring-search npm node osx zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias of="open ."
source "/Volumes/jedahan/.nvm/nvm.sh"

function swarm() {
  python $HOME/code/buglabs/bugswarm-tools/$1.py $*[2,$#-1]
}
