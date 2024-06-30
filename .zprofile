# login shell settings - things that don't change often

# homebrew
export FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
export HOMEBREW_NO_ENV_HINTS=true

# android sdk
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
ANDROID_PATH=$ANDROID_HOME/platform-tools
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/tools
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/tools/bin
ANDROID_PATH=$ANDROID_PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_PATH

# ruby
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# put config files in a comfy place
export XDG_CONFIG_HOME="$HOME/.config"
