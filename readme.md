[jedahan](http://jonathan.is)'s dotfiles for [alacritty](https://github.com/jwilm/alacritty),
[amp](https://amp.rs),
[git](https://git-scm.com),
[mpv](https://mpv.io),
[neovim](https://neovim.io),
[parity](https://parity.io),
[streamlink](https://streamlink.github.io),
[tmux](https://tmux.github.io),
and [zsh](https://zsh.org) on [macOS](https://github.com/jedahan/oh-my-macOS).

### Installation

Backup existing dotfiles

    mkdir .dotfiles-backup && git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}

Clone to a bare repository

    git clone --bare https://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Checkout to your home directory

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

Hide untracked files

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no

### Usage

Manage dotfiles in the home directory with this git function

    git() ( test -d .dotfiles && export GIT_DIR=$PWD/.dotfiles GIT_WORK_TREE=$PWD; command git "$@" )
