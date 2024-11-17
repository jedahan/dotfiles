# login shell settings - things that don't change often
# Keep these in ~/.zprofile on macos because /etc/profile loads after ~/.zshenv

## config files
export XDG_CONFIG_HOME="$HOME/.config"

## homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=true

## personal
export PATH="$HOME/bin:$PATH"
