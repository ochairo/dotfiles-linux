" ~/.vimrc
" Configuration file for vim

" Enable syntax highlighting
syntax on

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting)
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled,
" keep the same indent as the line you're currently on.
set autoindent

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Display the cursor position on the last line of the screen or in the status line
set ruler

" Always display the status line
set laststatus=2

" Use visual bell instead of beeping
set visualbell

" Set the command window height to 2 lines
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Indentation settings for using 4 spaces instead of tabs
set shiftwidth=4
set softtabstop=4
set expandtab

" Map Y to act like D and C, i.e. to yank until EOL
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>

" Enable mouse support in terminal
set mouse=a

" Set color scheme
colorscheme desert

" Enable file type detection
filetype on
filetype plugin on
filetype indent on
