call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-dadbod'
Plug 'mechatroner/rainbow_csv'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
call plug#end()

syntax on
set laststatus=2 	" lightline requirement; always show status line
set mouse=a  		" change cursor per mode
set number  		" always show current line number
set expandtab		" convert tab to spaces
set tabstop=4		" 1 tab = 4 spaces
set updatetime=100  " fast update to gitgutter

colorscheme zenburn
