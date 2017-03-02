[Jonathan Dahan](http://jonathan.is)'s dotfiles for OSX and linux

### Software

  * [zsh](https://zsh.org)
  * [neovim](https://neovim.io)
  * [tmux](https://tmux.github.io)
  * [iTerm3](https://iterm2.com/version3.html)
  * [mpv](https://mpv.io)
  * [alfred](https://alfredapp.com)
  * [alacritty](https://github.com/jwilm/alacritty)
  * [advanced-ssh-config](https://github.com/moul/advanced-ssh-config)
  * [git](https://git-scm.com)

### Installation

Install homeshick

    git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick && source ${_}/homeshick.sh

Install zplug

    git clone https://github.com/zplug/zplug $HOME/.zplug

Clone and link the castle

    homeshick --force clone jedahan/dotfiles

Start zsh

    exec zsh
