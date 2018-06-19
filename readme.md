[Jonathan Dahan](http://jonathan.is)'s dotfiles for macOS

### Software

[alacritty](https://github.com/jwilm/alacritty),
[git](https://git-scm.com),
[mpv](https://mpv.io),
[neovim](https://neovim.io),
[parity](https://parity.io),
[streamlink](https://streamlink.github.io),
[tmux](https://tmux.github.io),
[zsh](https://zsh.org)

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
