# Clone zgen if not found
source $HOME/.zgen/zgen.zsh || git clone git@github.com:tarjoilija/zgen.git $HOME/.zgen
ZGEN_RESET_ON_CHANGE=($HOME/.zshrc $HOME/.zshrc.local)

if zgen saved; then
  zgen init
else
  # prezto
  zgen prezto

  # prezto options
  zgen prezto editor dot-expansion 'yes' # convert .... to ../..

  # prezto plugins
  zgen prezto git
  zgen prezto history-substring-search
  zgen prezto homebrew
  zgen prezto osx

  # zsh plugins
  zgen load rimraf/k
  zgen load djui/alias-tips
  zgen load b4b4r07/enhancd
  zgen load tarruda/zsh-autosuggestions
  zgen load jimmijj/zsh-syntax-highlighting

  # local
  zgen load .zshrc.local

  # prompt
  zgen load mafredri/zsh-async # required for pure
  zgen load sindresorhus/pure

  zgen save
fi
