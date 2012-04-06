call pathogen#infect()

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
	syntax on
	colorscheme torte
	set hlsearch
	set guifont=Monaco:h10
    set guioptions-=T   " hide toolbar
    " set guifont=Bitstream\ Vera\ Sans\ Mono:h12
    set lines=45 columns=150
endif

if has("autocmd")
	filetype plugin indent on
else
	set autoindent
endif

set tabstop=4
set shiftwidth=4
set expandtab
" set laststatus=2

