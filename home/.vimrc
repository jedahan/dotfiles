" vimrc by Jonathan Dahan <jonathan@jedahan.com>

" general behaviour
set nocompatible        "Allow all sorts of advanced features
set autoread              " Reload files that have been updated outside of vim
set encoding=utf-8        " Force utf-8 encoding
set showcmd               " display incomplete commands
syntax enable             " Enable syntax highlighting
filetype plugin indent on " load file type plugins + indentation

" scrolling behaviour
set scrolloff=8         "Scroll when 8 lines away from margins
set sidescrolloff=15    "Scroll when 15 characters away from an edge
set sidescroll=1        "Enable sidescrolling

" whitespace
set tabstop=2 shiftwidth=2      " a tab is two spaces (change this to your linking)
set expandtab                   " use spaces, not tabs (remove this if you mostly use tabs)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" use git for backups
set noswapfile
set nobackup

" number lines
set number

" colors
set background=dark

" ignore dumb files
set wildignore=*.swp,*.bak,*.pyc,*.class

" tweaks
set title
set visualbell
set noerrorbells
set mouse=a

" show trailing whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" faster searching
map <space> /
map <c-space> ?

" enable json as a filetype
autocmd BufNewFile,BufRead *.json set ft=json

" font
set guifont=Inconsolata:h24
