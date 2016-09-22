" PLUGINS
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'neomake/neomake'
  Plug 'joonty/vdebug'
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
  Plug 'shougo/deoplete.nvim'              " autocompletion
  Plug 'shougo/vimproc', { 'do': 'make' }    " required for deoplete
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy finder
  Plug 'junegunn/fzf.vim'                  " use to search for files, on search in files
  Plug 'mhinz/vim-startify'                " better startup - choose from recently open files, etc
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'racer-rust/vim-racer'
  if system('hostname') =~ 'etsy.com'
    Plug 'git@github.etsycorp.com:Engineering/vim-rodeo.git'
  endif
call plug#end()

nnoremap ; :
nnoremap : ;

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
nnoremap <C-h> :bprevious!<CR>
nnoremap <C-l> :bnext!<CR>
nmap <silent> <a-w> :bdelete!<CR>
nmap <silent> <c-w> :bdelete!<CR>

" FUZZY FIND
nnoremap <silent> <leader><space> :Files<CR>

function! s:with_git_root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  return v:shell_error ? {} : {'dir': root}
endfunction

command! -nargs=* FzfGit call fzf#vim#ag(<q-args>, extend(s:with_git_root(), g:fzf#vim#default_layout))
map <C-s> :FzfGit 

" COMPLETION
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()

" RUST
let g:racer_cmd = "/Users/jedahan/.cargo/bin/racer"
let $RUST_SRC_PATH = "/Users/jedahan/.rust/src"

" NEOMAKE
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd! BufWritePost * Neomake

" ETSY
if system("hostname") =~ 'etsy.com'
  let g:airline#extensions#tabline#formatter = 'rodeoicons'
  let g:vdebug_options = {}
  let g:vdebug_options["port"] = 9192
  let g:vdebug_options["host"] = 127.0.0.1

  autocmd FileType php setlocal tabstop=4
  autocmd FileType php setlocal shiftwidth=4

  au BufEnter *.php :call SetPHPCSStandard()

  function! SetPHPCSStandard()
      let test_std_root = expand($HOME) ."/development/Etsyweb/tests/standards/"
      let g:neomake_php_phpcs_args_standard = test_std_root ."stable-ruleset.xml"

      if expand("%:p") =~ ".*/Etsyweb/tests/phpunit.*"
          let g:neomake_php_phpcs_args_standard = test_std_root ."phpunit-ruleset.xml"
      endif
  endfunction

endif

nnoremap ; :
nnoremap : ;
