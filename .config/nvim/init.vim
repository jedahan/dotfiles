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
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" arrow key resize
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>
" Disable arrow keys completely in Insert Mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

call plug#begin('~/.config/nvim/plugged')
  Plug 'w0rp/ale'
  Plug 'cloudhead/neovim-fuzzy'            " fuzzy-finder, try ^o, ^p, and ^s
  " Languages
  Plug 'plasticboy/vim-markdown'
  Plug 'rust-lang/rust.vim'
  Plug 'sebastianmarkow/deoplete-rust'
  " Theming
  Plug 'chriskempson/base16-vim'           " medium-contrast color schemes
  Plug 'ryanoasis/vim-devicons'            " icons for filetypes
  Plug 'vim-airline/vim-airline'           " bottom and top gutters
  Plug 'vim-airline/vim-airline-themes'    " more themes for airline
  Plug 'airblade/vim-gitgutter'            " show git information in the gutter
  " Other
  Plug 'bogado/file-line'                  " vim file.ext:line
  Plug 'terryma/vim-multiple-cursors'      " ^n like sublime text
  if has('python3')
    Plug 'shougo/deoplete.nvim', { 'do': 'UpdateRemotePlugins' } " autocompletion
  endif
  Plug 'shougo/vimproc', { 'do': 'make' }    " required for deoplete
  Plug 'mhinz/vim-startify'                " better startup - choose from recently open files, etc
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  if system('hostname') =~ 'etsy.com'
    Plug 'git@github.etsycorp.com:Engineering/vim-rodeo.git'
  endif
call plug#end()

" COLORS
syntax on
set background=dark
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
nnoremap <silent> <a-w> :bdelete!<CR>
nnoremap <silent> <c-w> :bdelete!<CR>

nnoremap ; :
nnoremap : ;

" FUZZY FIND
nnoremap <silent> <C-o> :FuzzyOpen<CR>
nnoremap <silent> <C-p> :FuzzyGrep<CR>
nnoremap <C-s> :FuzzyGrep 

" COMPLETION
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" RUST
if executable('rustc')
  let sysroot = substitute(system('rustc --print sysroot'), '\n', '', '')
  let srcpath = expand(sysroot . '/lib/rustlib/src/rust/src')
  let $RUST_SRC_PATH = isdirectory(srcpath) ? srcpath : ''
  let g:deoplete#sources#rust#racer_binary = expand("~/.cargo/bin/racer")
  let g:deoplete#sources#rust#rust_source_path = $RUST_SRC_PATH
  let g:racer_experimental_completer = 1
endif

" ETSY
if system("hostname") =~ 'vm.*etsy.com'
  let g:airline#extensions#tabline#formatter = 'rodeoicons'
  let g:vdebug_options = {}
  let g:vdebug_options["port"] = 9192
  let g:vdebug_options["host"] = 127.0.0.1

  autocmd FileType php setlocal tabstop=4
  autocmd FileType php setlocal shiftwidth=4
endif
