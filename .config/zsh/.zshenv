export HISTFILE=${HOME}/.zhistory HISTSIZE=100000 SAVEHIST=100000 ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd
export EDITOR=${commands[nvim]:-$commands[vim]}
export VISUAL=$EDITOR
export LESS='-R'

