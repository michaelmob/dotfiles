" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-comentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-abolish'
Plug 'mattn/emmet-vim'
call plug#end()

" Color scheme
syntax on
colorscheme onedark

" New lines
nnoremap <Enter> o<Esc>
nnoremap <S-Enter> O<Esc>

" Indentation
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab


" Relative line numbers
set number
set relativenumber

" Splits
set splitbelow
set splitright

" Split navigation
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Mouse support
set mouse=a

" Airline
let g:airline#extensions#tabline#enabled = 1
