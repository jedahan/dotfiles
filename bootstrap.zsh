#!env zsh
err() { echo -e "\n! $*" >&2 }
log() { echo -e "# $*" >&2 }

[[ "$(uname)" == "Darwin" ]] && {
  err "Not on macOS, quitting"
  exit -1
}

echo " hi"

log "save current settings"; {
  defaults read >! defaults-$(date +%s)
}

log "set hostname to talon"; {
  scutil --set ComputerName talon
  scutil --set LocalHostName talon
}

log "closing system preferences to avoid conflicts"; {
  osascript -e 'tell application "System Preferences" to quit'
}

log "enable control+scroll zooming"; {
  defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
}

log "autohide and empty dock"; {
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock persistent-apps -array ""
  killall Dock > /dev/null 2>&1
}

log "set Keyboard caps lock to control"; {
  defaults -currentHost write -globalDomain -array \
	  '{ HIDKeyboardModifierMappingDst = 30064771300; HIDKeyboardModifierMappingSrc = 30064771129; }'
}

log "enable tap-to-click"; {
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
  defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
}

log "update system software"; {
  softwareupdate --install --all
}

log "install homebrew"; {
  (( $+commands[brew] )) || {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    grep --quiet homebrew ~/.zprofile || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    grep HOMEBREW_NO_ENV_HINTS ~/.zprofile || echo 'export HOMEBREW_NO_ENV_HINTS=true' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  }
  brew analytics off
}

log "install rustup"; {
  (( $+commands[rustup] )) || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

log "block ad domains in /private/etc/hosts"; {
  grep --quiet StevenBlack /private/etc/hosts || {
    curl 'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts' \
      --append --output /private/etc/hosts
  }
}

log "install shell apps"; {
  cargo install zr
  brew install fd fzf helix mpv node podman podman-compose rg tldr zoxide
  brew install typescript-language-server
}

log "install desktop apps"; {
  brew install discord firefox protonmail-bridge signal tidal
}

log "clone dotfiles"; {
  test -f ~/.dotfiles || git clone https://github.com/jedahan/dotfiles ~/.dotfiles
}

log "enable containers"; {
  podman machine init
  podman machine start
}

log "disable studentd"; {
  launchctl disable system/studentd
  killall studentd
  launchctl disable system/com.apple.ManagedClient.enroll
}

log "block mdm hosts"; {
  grep --quiet 'block mdm' || {
    echo <<MDM
    # block mdm
    0.0.0.0 iprofiles.apple.com
    0.0.0.0 deviceenrollment.apple.com
    0.0.0.0 mdmenrollment.apple.com
    0.0.0.0 gdmf.apple.com
    0.0.0.0 acmdm.apple.com
    0.0.0.0 albert.apple.com
    MDM | sudo tee -a /etc/hosts
  }
}

log "print instructions for disabling mdm"; {
  log <<CLOUD
  reboot to recovery by holding down power until options show up
  menu -> utilities -> terminal, then run the following:
  
  cd /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings
  mv .cloudConfigHasActivationRecord .cloudConfigHasActivationRecord.bak
  mv .cloudConfigRecordFound .cloudConfigRecordFound.bak
  touch .cloudConfigProfileInstalled
  touch .cloudConfigRecordNotFound
  CLOUD
}

log "print firefox manual steps"; {
  echo <<FIREFOX
  - install iCloud Passwords addon
  - install Kagi search
  - install uBlock Origin, Privacy Badger, ClearURLs, Facebook Container
  - remove amazon, bing, google from search shortcuts
  - remove search suggesstions from firefox or sponsors
  - switch search engine to kagi

  - remove sponsored links from start page
  - set start page background to fox in snow
  - remove shortcuts from start page
  FIREFOX
}

log "print manual steps"; {
  echo <<TODO
  - turn on apple private relay
  - login to github
  - install ghostty
  - transfer ssh keys from old laptop
  - create 'work' user or learn to use spaces
  - symlink dotfiles
  TODO
}

echo " bye"
