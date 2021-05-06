" Set tabs to 4 spaces
set tabstop=4

" Display line numbering
set number

"===============================================================================
" From: thoughtstream/Damian-Conway-s-Vim-Setup - https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc

"====[ Set up smarter search behaviour ]=======================

set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       "...unless uppercase letters used

set hlsearch        "Highlight all matches
highlight clear Search
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
highlight    IncSearch    ctermfg=White  ctermbg=Red    cterm=bold

"===============================================================================
" From: Damian Conway, "More Instantly Better Vim" - OSCON 2013 - https://www.youtube.com/watch?v=aHm36-na4-4

" Highlight the 74th char from a line
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%74v', 100)
