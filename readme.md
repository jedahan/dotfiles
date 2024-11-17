[jedahan][]'s dotfiles for [ghostty][], [zsh][], [hx][], [jj][], [ssh][], [git][], and [mpv][] on [macOS][].

Customizations are minimal, understandable, and independent, so newcomers can dive in.

> check out [the linux branch](https://github.com/jedahan/dotfiles/tree/linux)

![screenshot](screenshot.png)

### Installation

Clone this repository

    git clone https://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Backup existing files

    git -C $HOME/.dotfiles ls-files -z | xargs -0 -I _ mv -vi "$HOME/_" "$HOME/_.backup"

Symlink dotfiles to home directory

    git -C $HOME/.dotfiles ls-files -z | xargs -0 -I _ ln -sf "$HOME/.dotfiles/_" "$HOME/_"

Setup function for managing dotfiles when in home directory

    git() { command git -C ${PWD:/${HOME}/.dotfiles} $* }

### Usage

Manage changes with `git` in your home directory

    git status

Add a config file to git

    cd
    mv .config/app.toml .dotfiles/.config/app.toml
    ln -sf .dotfiles/.config/app.toml ~/.config/app.toml
    git add .config/app.toml
    git commit -m 'track app config'

### Uninstallation

Backup existing files

    git -C $HOME/.dotfiles ls-files -z | xargs -0 -I _ mv -vi "$HOME/_" "$HOME/_.backup"

Copy dotfiles from repo back to home

    git -C $HOME/.dotfiles ls-files -z | xargs -0 -I _ cp -i "$HOME/.dotfiles/_" "$HOME/_"

[jedahan]: http://jonathan.is

[git]: https://git-scm.com
[jj]: https://martinvonz.github.io/jj
[macOS]: https://www.apple.com/macos/sequoia
[mpv]: https://mpv.io
[hx]: https://helix-editor.com
[openssh]: https://openssh.com
[zsh]: https://zsh.org
