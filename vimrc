" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup PLUG
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif


call plug#begin('~/.local/share/nvim/plugged')

Plug 'flazz/vim-colorschemes'
" Colorschemes 

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Line

Plug 'tpope/vim-sensible'
" Sensible defaults

Plug 'justinmk/vim-dirvish'
" <hyphen> to open dirvish

Plug 'tpope/vim-surround'
" S in visual mode, followed by characters to surround with
" <C-y><comma> to surround with tag

Plug 'tpope/vim-commentary'
" gc in visual mode, or gc and movement to un/comment line

Plug 'tpope/vim-fugitive'
" Git :Gstatus :Gcommit

Plug 'mattn/emmet-vim'
" Press tab after tag text to insert tag
" html:5<tab> to insert html base template

Plug 'sheerun/vim-polyglot'
" Language packs 

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Fuzzy finding, :Files, :Buffers, :Tags

Plug 'justinmk/vim-sneak'
" Jump to any location with s/S

Plug 'w0rp/ale'
" Linter

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Snippets

call plug#end()


" Colors
syntax on
set background=dark
colorscheme molokai

if (has('termguicolors'))
  set termguicolors
endif


" Speed
" set ttyfast
" set lazyredraw
set regexpengine=1


" Timeouts
set timeoutlen=1000 ttimeoutlen=0


" Rulers
set colorcolumn=80


" Indentation
set shiftwidth=2
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


" Sessions
let g:sessions_dir = '~/vim-sessions'


" New lines
nnoremap <Enter> o<Esc>
nnoremap <S-Enter> O<Esc>


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
let g:airline_theme = 'molokai'


" Netrw
" let g:netrw_liststyle = 3


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
augroup FILETYPES
  autocmd FileType c setlocal shiftwidth=4
  autocmd FileType py setlocal shiftwidth=4
  autocmd FileType go setlocal shiftwidth=4
  autocmd FileType cpp setlocal shiftwidth=4
augroup END
