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
  Plug 'hellerve/carp-vim'
  Plug 'w0rp/ale'
  Plug 'rhysd/github-complete.vim'         " emoji, mostly
  Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' } " language client
  Plug 'Shougo/deoplete.nvim'
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
  Plug 'mhinz/vim-startify'                " better startup - choose from recently open files, etc
  Plug 'mhinz/vim-signify'                 " Show git diffs in gutter
  Plug 'tpope/vim-fugitive'                " git commands
call plug#end()

" COMPLETION
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  \ 'vue': ['vls'],
  \ }
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

" BUFFER NAV
nnoremap <c-h> :bprevious!<CR>
nnoremap <c-l> :bnext!<CR>

" FUZZY FIND
nnoremap <silent> <C-o> :FuzzyOpen<CR>
nnoremap <silent> <C-p> :FuzzyGrep<CR>
nnoremap <C-s> :FuzzyGrep 

" DEOPLETE
set noshowmode
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_auto_close_preview = 1
inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" LINTING
let g:ale_linters = {
\   'javascript': ['standard'],
\}
let g:ale_fixers = {
\   'javascript': ['standard'],
\}
let g:ale_fix_on_save = 1 " auto-lint
