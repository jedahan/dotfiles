# homebrew
HOMEBREW_PATH="/opt/homebrew/bin"
HOMEBREW_PATH="/opt/homebrew/sbin:$HOMEBREW_PATH"
export PATH=$HOMEBREW_PATH:$PATH
export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
export HOMEBREW_NO_ENV_HINTS=true

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# android sdk
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
ANDROID_PATH=$ANDROID_HOME/platform-tools
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/tools
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/tools/bin
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_PATH

# ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zsh
export NO_UPDATE_NOTIFIER=true
export EDITOR=hx

# zsh history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt \
  HIST_EXPIRE_DUPS_FIRST \
  HIST_IGNORE_ALL_DUPS \
  HIST_IGNORE_DUPS \
  HIST_IGNORE_SPACE \
  HIST_REDUCE_BLANKS  \
  HIST_FIND_NO_DUPS \
  INC_APPEND_HISTORY \
  INC_APPEND_HISTORY_TIME \
  EXTENDED_HISTORY \

# icons for ls
EZA_ICONS_AUTO=true

# work qt5
export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
