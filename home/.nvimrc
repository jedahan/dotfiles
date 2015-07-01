syntax on

if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

set undofile                 " Save undo's after file closes
set undodir=$HOME/.nvim/undo " where to save undo histories
set undolevels=1000          " How many undos
set undoreload=10000         " number of lines to save for

set tabstop=2 shiftwidth=2 expandtab

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

call plug#begin('~/.nvim/plugged')
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'scrooloose/syntastic'
  Plug 'Valloric/YouCompleteMe'
  Plug 'vim-scripts/a.vim'
  Plug 'tikhomirov/vim-glsl'
  Plug 'sotte/presenting.vim'
  Plug 'jtratner/vim-flavored-markdown'
  Plug 'chriskempson/base16-vim'
call plug#end()

let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_check_on_open = 1

let g:ycm_confirm_extra_conf = 0

set backspace=indent,eol,start
set list listchars=tab:→\ ,trail:·
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

au FileType ghmarkdown let b:presenting_slide_separator = '\v(^|\n)\-{2,}'
colorscheme base16-eighties
