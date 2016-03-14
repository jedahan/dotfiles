" UNDO
set undofile                             " save undo history after file closes
set undodir=$HOME/.local/share/nvim/undo " where to save undo histories
set undolevels=1000                      " how many undos
set undoreload=10000                     " number of lines to save for

" WHITESPACE
set tabstop=2 shiftwidth=2 expandtab    " tab just inserts 2 spaces
set list listchars=tab:→\ ,trail:·      " show tabs, and trailing spaces

" Install vim-plug as a plugin manager, if it isn't already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" PLUGINS
call plug#begin('~/.config/nvim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy finder
  Plug 'junegunn/fzf.vim' " use to search for files, on search in files
  " Syntax highlighting
  Plug 'scrooloose/syntastic'   " show syntax and precompiler errors on the sidebar
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' } " coffee-script
  Plug 'ekalinin/Dockerfile.vim'                       " Dockerfile
  Plug 'tikhomirov/vim-glsl'                           " opengl shader language
  Plug 'plasticboy/vim-markdown'                       " markdown
  " Theming
  Plug 'chriskempson/base16-vim'           " medium-contrast color schemes
  Plug 'ryanoasis/vim-devicons'            " icons for filetypes
  Plug 'vim-airline/vim-airline'           " bottom and top gutters
  Plug 'vim-airline/vim-airline-themes'    " more themes for airline
  Plug 'airblade/vim-gitgutter'            " show git information in the gutter
  " Other
  Plug 'vim-scripts/a.vim'
  Plug 'joonty/vdebug'
  Plug 'sotte/presenting.vim'
  Plug 'mhinz/vim-startify'                " better startup - choose from recently open files, etc
  Plug 'urthbound/hound.vim'
  Plug 'scrooloose/nerdtree'               " file browser sidebar
  Plug 'Xuyuanp/nerdtree-git-plugin'       " ...with icons for git stuff
  Plug 'terryma/vim-multiple-cursors'      " like sublime/atom command-D
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'spf13/PIV'
call plug#end()

" SYNTAX HIGHLIGHTING
let g:syntastic_check_on_open = 0
let g:syntastic_php_phpcs_args = "--standard=~/development/Etsyweb/tests/standards/stable-ruleset.xml"
let g:syntastic_cpp_compiler_options = '-std=c++11'

" FOLDING
set nofoldenable
let g:DisableAutoPHPFolding = 1

" COLORS
syntax on
set background=dark
colorscheme base16-eighties
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" fzf!
nnoremap <silent> <leader>o :FZF<CR>

" buffers
nnoremap <C-h> :bprevious<CR>
nnoremap <C-l> :bnext<CR>

" hound
let g:hound_base_url = "hound.etsycorp.com"

" TREE
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" fzf.vim bindings
map <C-a> :Ag 

function! s:with_git_root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  return v:shell_error ? {} : {'dir': root}
endfunction

command! -nargs=* SearchGitRoot
  \ call fzf#vim#ag(<q-args>, extend(s:with_git_root(), g:fzf#vim#default_layout))

map <C-s> :SearchGitRoot 

nmap <silent> <a-k> :wincmd k<CR>
nmap <silent> <a-j> :wincmd j<CR>
nmap <silent> <a-h> :wincmd h<CR>
nmap <silent> <a-l> :wincmd l<CR>

nmap <silent> <a-w> :bdelete<CR>
nmap <silent> <c-w> :bdelete<CR>

au BufReadPost * if getfsize(bufname("%")) > 100*1024 | set syntax= | endif
