[Jonathan Dahan](http://jonathan.is)'s dotfiles for OSX and linux

### Software

[zsh](https://zsh.org),
[neovim](https://neovim.io),
[tmux](https://tmux.github.io),
[iTerm3](https://iterm2.com/version3.html),
[mpv](https://mpv.io),
[alfred](https://alfredapp.com),
[alacritty](https://github.com/jwilm/alacritty),
[advanced-ssh-config](https://github.com/moul/advanced-ssh-config),
[git](https://git-scm.com)

### Installation

Clone the dotfiles to a bare repository

    git clone --bare git://github.com/jedahan/dotfiles.git $HOME/.dotfiles

Checkout the files

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout

Hide untracked files

    git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no

### Usage

To manage the dotfiles, use the `config` git alias.

### Backup

If files would be overwritten, you can run this to back them up

    mkdir .dotfiles-backup && git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
