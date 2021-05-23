#!env zsh
err() { echo -e "\n! $*" >&2 }
log() { echo -e "# $*" >&2 }

[[ "$(uname)" == "Darwin" ]] && {
  err "Not on macOS, quitting"
  exit -1
}

echo " hi"

log "closing system preferences to avoid conflicts"; {
  osascript -e 'tell application "System Preferences" to quit'
}

log "setting computer name to moya"; {
  [[ "$(scutil --get ComputerName)" == "moya" ]] \
    || scutil --set ComputerName moya
  [[ "$(scutil --get LocalHostName)" == "moya" ]] \
    || scutil --set LocalHostName moya
}

log "enable tap-to-click on trackpad"; {
  defaults write com.apple.AppleMultiTouchTrackpad Clicking -bool true
}

log "enable control+scroll zooming"; {
  defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
}

log "autohide the dock"; {
  defaults write com.apple.dock autohide -bool true \
    && killall Dock > /dev/null 2>&1
}

log "set Keyboard caps lock to control"; {
  defaults -currentHost write -globalDomain -array \
	  '{ HIDKeyboardModifierMappingDst = 30064771300; HIDKeyboardModifierMappingSrc = 30064771129; }'
}

log "set Finder default new window to $HOME"; {
  defaults write com.apple.finder NewWindowTargetPath "file://${HOME}"
}

log "set Safari search to duckduckgo"; {
  defaults write -globalDomain NSPreferredWebServices \
    '{ NSWebServicesProviderWebSearch = { NSDefaultDisplayName = DuckDuckGo; NSProviderIdentifier = "com.duckduckgo"; }; }'
}

log "install homebrew"; {
  test -d /opt/homebrew 2>/dev/null \
    || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  (( $+commands[brew] )) || eval $(/opt/homebrew/bin/brew shellenv)

  grep -q 'brew shellenv$' $HOME/.zprofile \
    || echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile
}

log "install rust"; {
  brew install --quiet rust
  grep -q cargo ~/.zprofile \
    || echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zprofile
}

log "installing inconsolata nerd font"; {
    brew install --quiet homebrew/cask-fonts/inconsolata-nerd-font
}

log "installing krunvm"; {
  brew tap --quiet slp/krun
  brew install --quiet krunvm
}

log "installing r and rstudio"; {
  brew install --quiet rstudio
  brew install --quiet --cask r
}

log "installing adb, bat, bw, croc, fast, fzf, fd, gh, jq, node, mpw, podman, postgresql, ripgrep, signal-cli, tealdeer, vscode, and wireguard"; {
  brew install --quiet \
    android-platform-tools \
    bat \
    bitwarden-cli \
    croc \
    docker \
    fzf \
    fd \
    gh \
    jq \
    node \
    node@14 \
    mpw \
    podman \
    postgresql \
    ripgrep \
    signal-cli \
    tealdeer \
    visual-studio-code \
    wireguard-tools

  (($+commands[tldr])) && tldr --update 
  (($+commands[fast])) || cargo install --git https://github.com/KabirKwatra/fast.git
}

log "install docker desktop preview"; {
  test -d /Applications/Docker.app \
    || curl -Os https://desktop.docker.com/mac/m1preview/Docker-AppleSilicon-Preview7.dmg
  test -f Docker-AppleSilicon-Preview7.dmg \
    && open  Docker-AppleSilicon-Preview7.dmg
}

log "install bitwarden, lulu, qbittorrent, rocket, signal, slack, spotify, and steam"; {
  brew install --quiet \
    bitwarden \
    lulu \
    qbittorrent \
    rocket \
    signal \
    slack \
    spotify \
    steam
}

log "install neovim"; {
  brew install --quiet --HEAD tree-sitter luajit neovim
}

log "install llvm"; {
  brew install llvm
  grep -q llvm ~/.zprofile \
    || printf '%s\n%s\n%s\n' \
    'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' \
    'export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"' \
    'export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"' >> ~/.zprofile
}

log "install transporter"; {
  test -f /Applications/Transporter.app \
    || open https://apps.apple.com/us/app/transporter/id1450874784
}

log "install xcode"; {
  test -f /Applications/XCode.app \
    || open https://apps.apple.com/us/app/xcode/id497799835
  sudo xcode-select --switch /Applications/XCode.app
  sudo xcodebuild -license
}

log "login to gh cli"; {
  gh auth status >/dev/null \
    || gh auth login --hostname github.com --web
}

log "install zr"; {
  (( $+commands[zr] )) || cargo install zr
}

log "set terminal theme to new moon"; {
  color_scheme=${XDG_CACHE_HOME:-$HOME/.config}/new-moon.terminal
  test -f $color_scheme \
    || curl -s https://raw.githubusercontent.com/taniarascia/new-moon/master/Terminal.app/new-moon.terminal -o $color_scheme
  open $color_scheme
}

log "download and install Around"; {
  test -f /Application/Around.app || open "https://meet.around.co/download"
}

log "setup neovim"; {
  log "install 0.5.0"; {
      log "download and put in ~/.local"
  }
  log "install packer"; {
    git clone https://github.com/wbthomason/packer.nvim \
      ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
  }
}

echo " gonna have to do these by hand:"
log "update apps from app store"
log "set display arrangement to vertical"
log "set Terminal font to 18" 
log "set Terminal title to blank"
log "set Firefox search for duckduckgo"
log "install Alfred, register powerpack, and add bitwarden workflow"
log "install Hush from the app store, enable in safari"

log "enable touchID for sudo"; {
  grep -q 'pam_tid.so$' /etc/pam.d/sudo \
    || sudo sed -i '2s;^;auth       sufficient     pam_tid.so'
}

echo " bye"
cargo install --git https://github.com/osa1/tiny.git
