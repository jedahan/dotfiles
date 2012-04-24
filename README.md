[Jonathan Dahan](http://jonathan.is)'s dotfiles

### Requirements
* [vim](http://www.vim.org/)
* [homesick](https://github.com/technicalpickles/homesick)

### Installation

Install homesick

    gem install homesick

Clone the castle

    homesick clone git://github.com/h0st1le/dotfiles.git

Symlink the castle contents to your home dir

    homesick symlink dotfiles

Initialize and update the submodules

    cd ~/.homesick/repos/dotfiles
    git submodule init
    git submodule update
    vim -c BundleInstall
    :qa
