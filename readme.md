[Jonathan Dahan](http://jonathan.is)'s dotfiles for OSX and linux

### Software

[zsh](https://zsh.org),
[neovim](https://neovim.io),
[tmux](https://tmux.github.io),
[iTerm3](https://iterm2.com/version3.html),
[mpv](https://mpv.io),
[alfred](https://alfredapp.com),
[alacritty](https://github.com/jwilm/alacritty),
[advanced-ssh-config](https://github.com/moul/advanced-ssh-config),
[git](https://git-scm.com)

### Installation

Clone the dotfiles to a bare repository

    git clone --bare git://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Setup the config alias

    alias config="git --git-dir=$HOME/.dotfiles/.git --work-dir=$HOME"

Checkout the files

    config checkout
