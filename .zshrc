export ZSH=$HOME/.oh-my-zsh
# themes: miloshadzic, lukerandall, lambda, fwalch, daveverwer, cloud, arrow
export ZSH_THEME="cloud"
plugins=(autojump git hub history-substring-search osx zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias of="open ."

function swarm() {
  cd "$HOME/code/buglabs/bugswarm-tools"
  [ "$1" = "" ] && ls *py | cut -d'.' -f1 || python $1.py $*[2,$#-1]
  cd -
}

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

alias cat='lolcat'
alias git=hub
#. ~/.nvm/nvm.sh
