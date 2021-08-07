PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"
export PATH

export NO_UPDATE_NOTIFIER=true

export \
  HISTSIZE=1000000 \
  SAVEHIST=1000000

setopt \
  HIST_IGNORE_ALL_DUPS \
  HIST_REDUCE_BLANKS  \
  INC_APPEND_HISTORY_TIME \
  EXTENDED_HISTORY
