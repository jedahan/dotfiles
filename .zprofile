# login shell settings - things that don't change often
# Keep these in ~/.zprofile on macos because /etc/profile loads after ~/.zshenv

## config files
export XDG_CONFIG_HOME="$HOME/.config"

## homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=true

## podman
source <(podman completion zsh)
export DOCKER_HOST='unix:///var/folders/0q/lkfzs_zd2353r6f5fs18p5180000gn/T/podman/podman-machine-default-api.sock'

## llvm for lldb-dap
export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"

## work
export PATH="$(brew --prefix qt@5)/bin:$PATH"

## personal
export PATH="$HOME/bin:$PATH"
