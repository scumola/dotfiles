set nocompatible
set wildmenu
set ttyfast

execute pathogen#infect()

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
	syntax on
"	colorscheme torte
"	colorscheme desert
"	set hlsearch
"    set incsearch
"	set guifont=Monaco:h10
"    set guioptions-=T   " hide toolbar
    " set guifont=Bitstream\ Vera\ Sans\ Mono:h12
endif

if has("autocmd")
	filetype plugin indent on
else
	set autoindent
    set smartindent
endif

set ignorecase
set noerrorbells

" set foldmethod=indent

set tabstop=4
set shiftwidth=4
" set expandtab
" set smarttab
" set laststatus=2
set scrolloff=3

set splitbelow
set splitright

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
    set undofile
endif
set history=10000
set encoding=utf-8 nobomb

set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words

set statusline=
set statusline+=%2*#%n%*\        " Flags and buf num.
set statusline+=%t\              " Tail of the filename
set statusline+=%y\              " Filetype
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " File encoding
set statusline+=%{&ff}]\         " File form
set statusline+=%r               " Read only flag
set statusline+=%m               " Modified flag
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=%=        " Left/right separator
set statusline+=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}
set statusline+=c=%02c,   " x=cursor column
set statusline+=l=%l/%L   " y=cursor line/total lines
set statusline+=\ (%P)    " percent through file

set magic
set autoread

let g:dbext_default_profile = 'mysql_local'
let g:dbext_default_profile_mysql_local = 'type=MYSQL:host=10.0.0.14:user=swebb:passwd=pw:dbname=tweets'
let g:dbext_default_profile_dany_prod = 'type=MYSQL:host=prod-radish01-slave02.cuuvfxxjlwmd.us-east-1.rds.amazonaws.com:user=dishonline:passwd=pw:dbname=dishonline'
let g:dbext_default_profile_dany_prod_users = 'type=MYSQL:host=prod-radish01-users-master.cuuvfxxjlwmd.us-east-1.rds.amazonaws.com:user=dishonline:passwd=pw:dbname=dishonline'
let g:dbext_default_profile_dany_qa = 'type=MYSQL:host=qa-radish01-master.cuuvfxxjlwmd.us-east-1.rds.amazonaws.com:user=dishonline:passwd=pw:dbname=dishonline'
" let g:dbext_default_profile_mysql_local = 'type=MYSQL:host=10.0.0.14:user=swebb:passwd=pw:dbname=tweets:extra=-t'
" let g:dbext_default_profile_mysql_local = 'type=MYSQL:user=root:passwd=pw:dbname=mysql:extra=--batch --raw --silent'
" let g:dbext_default_profile_mysql_local_DBI = 'type=DBI:user=swebb:passwd=pw:driver=mysql:conn_parms=database=tweets;host=10.0.0.14'
" let g:dbext_default_profile_mysql_local_ODBC = 'type=ODBC:user=root:passwd=pw:dsnname=mysql'
let NERDTreeShowHidden=1
