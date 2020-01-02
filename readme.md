[jedahan](http://jonathan.is)'s dotfiles for [alacritty](https://github.com/jwilm/alacritty),
[git](https://git-scm.com),
[i3status-rust](https://github.com/greshake/i3status-rust),
[mpv](https://mpv.io),
[neovim](https://neovim.io)+[spacevim](https://spacevim.org),
[parity](https://parity.io),
[streamlink](https://streamlink.github.io),
[sway]*(https://swaywm.org),
[tmux](https://tmux.github.io),
[vscode](https://github.com/Microsoft/vscode),
and [zsh](https://zsh.org) on [elementaryOS](https://elementaryos.com)

I try and keep customizations to a minimum, or at least easy to understand what each thing does so it is easily changeable for newcomers.

### Installation

Backup existing dotfiles

    mkdir .dotfiles-backup && git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}

Clone to a bare repository

    git clone --bare --recursive https://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Checkout to your home directory

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

Hide untracked files

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no

### Usage

Manage dotfiles in the home directory with these functions

    config() { command git --git-dir=$HOME/.dotfiles --work-tree=$HOME/. "$@" }
    git() { [[ $PWD != $HOME ]] && { command git "$@"; return } || config "$@" }
