" plugins with vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-dadbod'
Plug 'mechatroner/rainbow_csv'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
"Plug 'sirver/ultisnips'
Plug 'dusans/vim-hardmode'
Plug 'jalvesaq/Nvim-R'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
call plug#end()

filetype plugin on
filetype indent on
syntax on

" key mappings
let mapleader="-"
"inoremap <c-u> <esc>vbUea 
"nnoremap <c-u> vbUe<esc>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap jk <esc> 
vnoremap jk <esc> 
"remapping <esc> to <nop> causes major issues. this is a hack!
inoremap <esc><nop> <nop>
vnoremap <esc><nop> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>

" options
set laststatus=2 	" lightline requirement; always show status line
set mouse=a  		" change cursor per mode
set number  		" always show current line number
set expandtab		" convert tab to spaces
set tabstop=4		" 1 tab = 4 spaces
set updatetime=100  " fast update to gitgutter
set clipboard=unnamed "yank to clipboard
set backspace=indent,eol,start "normal backspace usage

" snippet config
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'vertical'
colorscheme zenburn

" vimtex settings
let g:tex_flavor='latex'
"let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
"let g:Tex_ViewRule_pdf='zathura'
set conceallevel=1
let g:tex_conceal='abdmg'
"let g:Imap_FreezeImap=1
"let g:vimtex_fold_enabled
set foldmethod=expr
set foldexpr=vimtex#fold#level(v:lnum)
set foldtext=vimtex#fold#text()

" Mappings for compiling Latex file
" autocmd FileType tex nmap <buffer> <C-T> :!xelatex %<CR>
" autocmd FileType tex nmap <buffer> T :!open -a Skim %:r.pdf<CR><CR>
" autocmd FileType tex nmap <buffer> T :!open -a zathura %:r.pdf<CR><CR>
