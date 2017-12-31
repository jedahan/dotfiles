[Jonathan Dahan](http://jonathan.is)'s dotfiles for OSX and linux

### Software

[zsh](https://zsh.org),
[neovim](https://neovim.io),
[tmux](https://tmux.github.io),
[alacritty](https://github.com/jwilm/alacritty),
[mpv](https://mpv.io),
[git](https://git-scm.com),
[livestreamer](docs.livestreamer.io),
[parity](https://parity.io)

### Installation

Clone the dotfiles to a bare repository

    git clone --bare https://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Checkout the files

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

Hide untracked files

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no

### Usage

To manage the dotfiles, use the `config` git alias.

### Backup

If files would be overwritten, you can run this to back them up

    mkdir .dotfiles-backup && git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
