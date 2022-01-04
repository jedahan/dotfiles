PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"
export PATH

export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
ANDROID_PATH=$ANDROID_HOME/platform-tools
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/tools
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/tools/bin
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_PATH

export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

export NO_UPDATE_NOTIFIER=true

export \
  HISTSIZE=1000000 \
  SAVEHIST=1000000

export EDITOR=nvim

export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

setopt \
  HIST_IGNORE_ALL_DUPS \
  HIST_REDUCE_BLANKS  \
  INC_APPEND_HISTORY_TIME \
  EXTENDED_HISTORY
