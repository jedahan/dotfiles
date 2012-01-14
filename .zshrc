plugins=(brew git hub history-substring-search osx zsh-syntax-highlighting)
export DISABLE_UPDATE_PROMPT=true # autoupdate
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="cloud" # miloshadzic, lukerandall, lambda, fwalch, daveverwer, cloud, arrow, norm, wedisagree
source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

alias of="open ."
alias cat='lolcat'
alias ctags="`brew --prefix`/bin/ctags"

export TODO=~/Documents/todo
function todo() { if [ $# == "0" ]; then cat $TODO; else echo "• $@" >> $TODO; fi }
function todone() { sed -i -e "/$*/d" $TODO; }
