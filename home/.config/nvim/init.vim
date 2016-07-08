" UNDO
set undofile                             " save undo history after file closes
set undodir=$HOME/.local/share/nvim/undo " where to save undo histories
set undolevels=1000                      " how many undos
set undoreload=10000                     " number of lines to save for

" REDO
noremap Q @q

" WHITESPACE
set tabstop=2 shiftwidth=2 expandtab    " tab just inserts 2 spaces
set list listchars=tab:→\ ,trail:·      " show tabs, and trailing spaces
autocmd FileType php setlocal tabstop=4
autocmd FileType php setlocal shiftwidth=4

" Install vim-plug as a plugin manager, if it isn't already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

let isEtsy = system('hostname') =~ 'etsy.com'

" PLUGINS
call plug#begin('~/.config/nvim/plugged')
  Plug 'shougo/deoplete.nvim'
  Plug 'shougo/vimproc', { 'do': 'make' }
  Plug 'fatih/vim-go'
  Plug 'rust-lang/rust.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy finder
  Plug 'junegunn/fzf.vim' " use to search for files, on search in files
  " Syntax highlighting
  Plug 'scrooloose/syntastic'   " show syntax and precompiler errors on the sidebar
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' } " coffee-script
  Plug 'ekalinin/Dockerfile.vim'                       " Dockerfile
  Plug 'tikhomirov/vim-glsl'                           " opengl shader language
  Plug 'fatih/vim-go'
  Plug 'plasticboy/vim-markdown'                       " markdown
  Plug 'm2mdas/phpcomplete-extended'
  " Theming
  Plug 'chriskempson/base16-vim'           " medium-contrast color schemes
  Plug 'ryanoasis/vim-devicons'            " icons for filetypes
  Plug 'vim-airline/vim-airline'           " bottom and top gutters
  Plug 'vim-airline/vim-airline-themes'    " more themes for airline
  Plug 'airblade/vim-gitgutter'            " show git information in the gutter
  " Other
  Plug 'vim-scripts/a.vim'
  Plug 'joonty/vdebug'
  Plug 'mhinz/vim-startify'                " better startup - choose from recently open files, etc
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'majutsushi/tagbar'
  Plug 'racer-rust/vim-racer'
  if isEtsy
    Plug 'git@github.etsycorp.com:Engineering/vim-rodeo.git'
  endif
call plug#end()

" SYNTAX HIGHLIGHTING
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

" buffer navigation
nnoremap <C-h> :bprevious!<CR>
nnoremap <C-l> :bnext!<CR>
nmap <silent> <a-w> :bdelete!<CR>
nmap <silent> <c-w> :bdelete!<CR>

" fzf!
nnoremap <silent> <leader><space> :FZF<CR>
map <C-a> :Ag 

function! s:with_git_root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  return v:shell_error ? {} : {'dir': root}
endfunction

command! -nargs=* SearchGitRoot
  \ call fzf#vim#ag(<q-args>, extend(s:with_git_root(), g:fzf#vim#default_layout))

map <C-s> :SearchGitRoot 

" javascript
let g:syntastic_javascript_checkers = ['standard']
autocmd bufwritepost *.js silent !standard-format -w %

" completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

" rust
let g:racer_cmd = "/Users/jedahan/.cargo/bin/racer"
let $RUST_SRC_PATH = "/Users/jedahan/.rust/src"

if isEtsy
  let g:airline#extensions#tabline#formatter = 'rodeoicons'
endif
