" UNDO
set undofile                            " Save undo's after file closes
set undodir=$HOME/.local/share/nvim/undo " where to save undo histories
set undolevels=1000                     " How many undos
set undoreload=10000                    " number of lines to save for

" WHITESPACE
set tabstop=2 shiftwidth=2 expandtab
set list listchars=tab:→\ ,trail:·

" PLUG
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" PLUGINS
call plug#begin('~/.config/nvim/plugged')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'spf13/PIV'
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'scrooloose/syntastic'
  Plug 'vim-scripts/a.vim'
  Plug 'joonty/vdebug'
  Plug 'tikhomirov/vim-glsl'
  Plug 'sotte/presenting.vim'
  Plug 'plasticboy/vim-markdown'
  Plug 'chriskempson/base16-vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mhinz/vim-startify'
  Plug 'urthbound/hound.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

" SYNTAX HIGHLIGHTING
let g:syntastic_check_on_open = 1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

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
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>

" hound
let g:hound_base_url = "hound.etsycorp.com"

" TREE
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" fzf.vim bindings
map <C-s> :Ag 
