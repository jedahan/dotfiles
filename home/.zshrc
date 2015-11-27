# Clone zgen if not found
source $HOME/.zgen/zgen.zsh || git clone git@github.com:tarjoilija/zgen.git $HOME/.zgen
ZGEN_RESET_ON_CHANGE=($HOME/.zshrc $HOME/.zshrc.local)

if zgen saved; then
  zgen init
else
  # zsh plugins
  zgen load rimraf/k
  zgen load djui/alias-tips
  zgen load joshuarubin/zsh-homebrew
  zgen load tarruda/zsh-autosuggestions
  zgen load jimmijj/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen load sorin-ionescu/prezto modules/git/alias.zsh
  zgen load unixorn/autoupdate-zgen

  # local
  zgen load $HOME/.zshrc.local

  # prompt
  zgen load mafredri/zsh-async # required for pure
  zgen load sindresorhus/pure

  zgen save
fi
