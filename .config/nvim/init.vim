" PLUGINS
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

set hidden
set nofoldenable
let mapleader="\<SPACE>"
set mouse=r

call plug#begin('~/.config/nvim/plugged')
  " Completion
  Plug 'sheerun/vim-polyglot'              " lots of syntax highlighting
  Plug 'roxma/nvim-yarp'                   " completion dependency
  Plug 'ncm2/ncm2'                         " completion
  Plug 'ncm2/ncm2-github'                  " repos and emoji
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
  " Theming
  Plug 'chriskempson/base16-vim'           " medium-contrast color schemes
  Plug 'ryanoasis/vim-devicons'            " icons for filetypes
  Plug 'vim-airline/vim-airline'           " bottom and top gutters
  Plug 'vim-airline/vim-airline-themes'    " more themes for airline
  Plug 'airblade/vim-gitgutter'            " show git information in the gutter
  " Other
  Plug 'bogado/file-line'                  " vim file.ext:line
  Plug 'mhinz/vim-startify'                " better startup - choose from recently open files, etc
  Plug 'mhinz/vim-signify'                 " Show git diffs in gutter
call plug#end()

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" COMPLETION
let g:LanguageClient_serverCommands = { 'rust': ['rustup', 'run', 'rls'] }
let g:LanguageClient_autoStart = 1
let g:echodoc#enable_at_startup = 1

" COLORS
syntax on
colorscheme base16-eighties
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" UNDO / REDO
set undofile                             " save undo history after file closes
set undodir=$HOME/.local/share/nvim/undo " where to save undo histories
set undolevels=1000                      " how many undos
set undoreload=10000                     " number of lines to save for
noremap Q @q

" WHITESPACE
set tabstop=2 shiftwidth=2 expandtab    " tab just inserts 2 spaces
set list listchars=tab:→\ ,trail:·      " show tabs, and trailing spaces

