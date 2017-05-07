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

" arrow key resize
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

call plug#begin('~/.config/nvim/plugged')
  " Completion
  Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' } " language client
  Plug 'rust-lang/rust.vim'                " rust language support
  Plug 'Shougo/echodoc.vim'                " statusline documentation
  Plug 'Shougo/denite.nvim'                " popup and refactoring
  Plug 'roxma/nvim-completion-manager'     " completion
  " Theming
  Plug 'chriskempson/base16-vim'           " medium-contrast color schemes
  Plug 'ryanoasis/vim-devicons'            " icons for filetypes
  Plug 'vim-airline/vim-airline'           " bottom and top gutters
  Plug 'vim-airline/vim-airline-themes'    " more themes for airline
  Plug 'airblade/vim-gitgutter'            " show git information in the gutter
  " Other
  Plug 'cloudhead/neovim-fuzzy'            " fuzzy-finder, try ^o, ^p, and ^s
  Plug 'bogado/file-line'                  " vim file.ext:line
  Plug 'terryma/vim-multiple-cursors'      " ^n like sublime text
  Plug 'mhinz/vim-startify'                " better startup - choose from recently open files, etc
  Plug 'mhinz/vim-signify'                 " Show git diffs in gutter
  Plug 'tpope/vim-fugitive'                " Git commands, Gblame etc
  if system('hostname') =~ 'etsy.com'
    Plug 'git@github.etsycorp.com:Engineering/vim-rodeo.git'
  endif
call plug#end()

" COMPLETION
let g:LanguageClient_serverCommands = { 'rust': ['rustup', 'run', 'nightly', 'rls'] }
let g:LanguageClient_autoStart = 1
let g:echodoc#enable_at_startup = 1
set noshowmode
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
inoremap <expr> <cr>    pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

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

" BUFFER NAV
nnoremap <c-h> :bprevious!<CR>
nnoremap <c-l> :bnext!<CR>

nnoremap ; :
nnoremap : ;

" FUZZY FIND
nnoremap <silent> <C-o> :FuzzyOpen<CR>
nnoremap <silent> <C-p> :FuzzyGrep<CR>
nnoremap <C-s> :FuzzyGrep 

" ETSY
if system("hostname") =~ 'vm.*etsy.com'
  let g:airline#extensions#tabline#formatter = 'rodeoicons'
  let g:vdebug_options = {}
  let g:vdebug_options["port"] = 9192
  let g:vdebug_options["host"] = 127.0.0.1

  autocmd FileType php setlocal tabstop=4
  autocmd FileType php setlocal shiftwidth=4
endif
