[jedahan](http://jonathan.is)'s dotfiles for [alacritty](https://github.com/jwilm/alacritty),
[git](https://git-scm.com),
[mpv](https://mpv.io),
[neovim](https://neovim.io)+[spacevim](https://spacevim.org),
[parity](https://parity.io),
[spotifyd](https://github.com/Spotifyd/spotifyd),
[streamlink](https://streamlink.github.io),
[sway](https://swaywm.org),
[tmux](https://github.com/tmux/tmux),
[vscode](https://github.com/Microsoft/vscode),
and [zsh](https://zsh.org) on [kiss](https://k1ss.org).

Customizations should be minimal, understandable, and independent, so newcomers can dive in.

### Installation

Clone to a bare repository

    git clone --bare --recursive https://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Checkout to your home directory

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

Hide untracked files

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no

### Usage

Manage dotfiles in the home directory with these functions (which are included if you use zsh)

    config() { command git --git-dir=$HOME/.dotfiles --work-tree=$HOME/. "$@" }
    git() { [[ $PWD != $HOME ]] && { command git "$@"; return } || config "$@" }
