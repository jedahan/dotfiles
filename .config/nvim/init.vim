syntax on
set hidden                " not sure
set nofoldenable          " not sure
set mouse=r               " enable mouse
let mapleader="\<Space>"  " set leader to space

" UNDO / REDO
set undofile                            " save undo history after file closes
set undodir=${XDG_DATA_HOME}/nvim/undo  " where to save undo histories
set undolevels=1000                     " how many undos
set undoreload=10000                    " number of lines to save for

" WHITESPACE
set tabstop=2 shiftwidth=2 expandtab    " tab just inserts 2 spaces
set list listchars=tab:→\ ,trail:·      " show tabs, and trailing spaces

" PLUGINS
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'sheerun/vim-polyglot'   " lots of syntax highlighting
  Plug 'natebosch/vim-lsc'      " completion with language server
  Plug 'bogado/file-line'       " vim file.ext:line
  Plug 'mhinz/vim-startify'     " better startup - choose from recently open files, etc
  Plug 'dylanaraps/wal.vim'     " wal color scheme
call plug#end()

" COMPLETION
let g:lsc_server_commands = {'javascript': 'typescript-language-server'}

" COLORS
colorscheme wal

