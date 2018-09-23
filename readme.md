[jedahan](http://jonathan.is)'s dotfiles for macOS

Configures [alacritty](https://github.com/jwilm/alacritty),
[amp](https://amp.rs),
[git](https://git-scm.com),
[mpv](https://mpv.io),
[neovim](https://neovim.io),
[parity](https://parity.io),
[streamlink](https://streamlink.github.io),
[tmux](https://tmux.github.io),
and [zsh](https://zsh.org)

### Installation

Backup existing dotfiles

    mkdir .dotfiles-backup && git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}

Clone to a bare repository

    git clone --bare https://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Checkout to your home directory

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

Hide untracked files

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no

Manage dotfiles with the `config` git alias

    alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
