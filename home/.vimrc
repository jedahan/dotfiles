" vimrc by Jonathan Dahan <jonathan@jedahan.com>

" general behaviour
set nocompatible          " allow all sorts of advanced features
set autoread              " reload files that have been updated outside of vim
set encoding=utf-8        " force utf-8 encoding
set showcmd               " display incomplete commands
syntax enable             " enable syntax highlighting
filetype plugin indent on " load filetype plugins and indentation

" scrolling behaviour
set scrolloff=4         " scroll when 4 lines away from a marigin
set sidescroll=1        " enable sidescrolling
set sidescrolloff=10    " sidescroll when 10 characters away from an edge


" whitespace
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces instead of tabs
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
