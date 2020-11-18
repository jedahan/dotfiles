[jedahan](http://jonathan.is)'s dotfiles for [foot](https://codeberg.org/dnkl/foot),
[git](https://git-scm.com),
[mpv](https://mpv.io),
[neovim](https://neovim.io)+[spacevim](https://spacevim.org),
[parity](https://parity.io),
[spotifyd](https://github.com/Spotifyd/spotifyd),
[streamlink](https://streamlink.github.io),
[sway](https://swaywm.org),
[tmux](https://github.com/tmux/tmux),
and [zsh](https://zsh.org) on [kiss](https://k1ss.org).

Customizations should be minimal, understandable, and independent, so newcomers can dive in.

### Installation

Clone this repository

    git clone https://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Backup existing files

    git -C $HOME/.dotfiles ls-files -z | xargs -0 -I _ mv -vi "$HOME/_" "$HOME/_.backup"

Symlink files

    git -C $HOME/.dotfiles ls-files -z | xargs -0 -I _ ln -sf "$HOME/.dotfiles/_" "$HOME/_"

### Usage

To add or remove files, just move them into .dotfiles and symlink.

As a convinience in the home directory, you might want the following function

git() { if [[ $PWD != $HOME ]]; then command git "$@"; else command git -C .dotfiles "$@"; fi }
