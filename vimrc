" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'w0rp/ale'
Plug 'NovaDev94/lightline-onedark'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
call plug#end()


" Colors
syntax on
set background=dark
colorscheme palenight

if (has('termguicolors'))
  set termguicolors
endif


" Speed
set ttyfast
set lazyredraw
set regexpengine=1


" Timeouts
set timeoutlen=1000 ttimeoutlen=0


" New lines
nnoremap <Enter> o<Esc>
nnoremap <S-Enter> O<Esc>


" Rulers
set colorcolumn=80


" Indentation
set shiftwidth=4
set smarttab
set expandtab


" Relative line numbers
set number
set relativenumber


" Splits
set splitbelow
set splitright


" Leader
let g:mapleader = ' ' 


" Split navigation
map <Space> <Nop>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>


" Buffer navigation
noremap zn :bnext<CR>
noremap zp :bprev<CR>
noremap <C-q> :close<CR>


" Tab navigation
noremap <C-t>n :tabp<CR>
noremap <C-t>p :tabn<CR>
noremap tn :bprev<CR>


" Terminal
tnoremap <Esc> <C-\><C-n>


" Cut and Paste
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P


" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme = 'onedark'


" Netrw
let g:netrw_liststyle = 3
let g:netrw_mousemaps = 0


" Sneak
let g:sneak#label = 1

map f <Plug>Sneak_f

map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


" FZF
noremap <Leader>b :Buffers<CR>
noremap <C-p> :FZF<CR>


" File Types
augroup filetypes
  autocmd FileType html setlocal shiftwidth=2 tabstop=2
  autocmd FileType vimrc setlocal shiftwidth=2 tabstop=2
augroup END 
