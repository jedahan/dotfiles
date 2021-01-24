[jedahan](http://jonathan.is)'s dotfiles for 
[zsh](https://zsh.org),
[git](https://git-scm.com), and
[neovim](https://neovim.io)
on [macOS](https://www.apple.com/macos/big-sur/).

Customizations are minimal, understandable, and independent, so newcomers can dive in.

### Installation

Clone this repository

    git clone https://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Backup existing files

    git -C $HOME/.dotfiles ls-files -z | xargs -0 -I _ mv -vi "$HOME/_" "$HOME/_.backup"

Symlink new files

    git -C $HOME/.dotfiles ls-files -z | xargs -0 -I _ ln -sf "$HOME/.dotfiles/_" "$HOME/_"

### Usage

Manage changes with `git` in your home directory

    git status

This zshrc adds track/untrack functions for managing your dotfiles

Add a new file to the repository

    track ~/.config/app/config

Remove a file from the repository

    untrack ~/.config/app/config
