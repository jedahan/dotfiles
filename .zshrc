plugins=(brew git hub history-substring-search osx zsh-syntax-highlighting)
export DISABLE_UPDATE_PROMPT=true # autoupdate
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="cloud" # themes: miloshadzic, lukerandall, lambda, fwalch, daveverwer, cloud, arrow
source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

alias of="open ."
alias cat='lolcat'
alias ctags="`brew --prefix`/bin/ctags"

function swarm() {
  cd "$HOME/code/buglabs/bugswarm-tools"
  [ "$1" = "" ] && ls *py | cut -d'.' -f1 || python $1.py $*[2,$#-1]
  cd -
}
