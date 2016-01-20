[[ $SHLVL != "2" ]] && tmux new

# Clone zgen if not found
source ~/.zplug/zplug || { curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug && source ~/.zplug/zplug }

# zsh plugins
zplug "rimraf/k"
zplug "djui/alias-tips"
zplug "b4b4r07/zplug"
zplug "b4b4r07/enhancd", of:enhancd.sh
zplug "b4b4r07/emoji-cli", of:emoji-cli.zsh
zplug "joshuarubin/zsh-homebrew"
zplug "junegunn/fzf", of:shell/key-bindings.zsh
zplug "jimmijj/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "sorin-ionescu/prezto", of:modules/git/alias.zsh
zplug "mrowa44/emojify", as:command, of:emojify

# prompt
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", of:"*.plugin.zsh"

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡 '
export EMOJI_CLI_KEYBIND='^ '

zplug load

source ~/.zshrc.local
