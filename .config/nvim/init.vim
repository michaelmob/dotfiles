if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup PLUG
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

call plug#begin('~/.local/share/nvim/plugged')


" Colorschemes
Plug 'chriskempson/base16-vim'
Plug 'dylanaraps/wal.vim'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Sensible defaults
" Plug 'tpope/vim-sensible'

" Ranger file browser: <space>f
Plug 'francoiscabrol/ranger.vim'

" Better netrw defaults: <hyphen>
Plug 'tpope/vim-vinegar'

" S in visual mode, followed by characters to surround with
" <C-y><comma> to surround with tag
Plug 'tpope/vim-surround'

" gc in visual mode, or gc and movement to un/comment line
Plug 'tpope/vim-commentary'

" Git :Gstatus :Gcommit
Plug 'tpope/vim-fugitive'
"
" Enable repeat for supported plugins
Plug 'tpope/vim-repeat'

" Press tab after tag text to insert tag
" html:5<tab> to insert html base template
Plug 'mattn/emmet-vim'

" Language packs
Plug 'sheerun/vim-polyglot'

" Fuzzy finding, :Files, :Buffers, :Tags
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Register viewer
Plug 'junegunn/vim-peekaboo'

" Vim alignment, vipga then delimeter, gaip then delimeter
Plug 'junegunn/vim-easy-align'

" Jump to any location with s/S
Plug 'justinmk/vim-sneak'

" Linter
Plug 'w0rp/ale'

" Seamless tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Close vim buffer without messing up layout, :Bdelete
Plug 'moll/vim-bbye'

" Spaces indent character
Plug 'Yggdroot/indentLine'

" File icons
Plug 'ryanoasis/vim-devicons'

" Completion
"Plug 'Valloric/YouCompleteMe'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

call plug#end()


" Encoding
set encoding=UTF-8


" Colors
syntax on
set t_Co=256
set background=dark
colorscheme base16-monokai

if (has('termguicolors'))
 set termguicolors
endif


" Commands
set showcmd
nmap ; :


" Line navigation
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Speed
" set ttyfast
" set lazyredraw
set regexpengine=1


" Timeouts
set timeoutlen=1000 ttimeoutlen=0


" Rulers
set colorcolumn=80


" Wrap
set wrap!


" Indentation
set shiftwidth=2
set tabstop=4
set softtabstop=4
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
noremap <Leader>j :bprev<CR>
noremap <Leader>k :bnext<CR>
noremap <Leader>q :Bdelete<CR>


" Tab navigation
noremap <Leader>h :tabp<CR>
noremap <Leader>l :tabn<CR>


" Terminal
tnoremap <leader><Esc> <C-\><C-n>


" Cut and Paste
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P


" Save
noremap <Leader> :w<CR>
noremap <C-s> :w<CR>


" Airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline_theme = 'atomic'
let g:airline_powerline_fonts = 1


" Netrw
"let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

function! NetrwBuf()
  nmap <buffer> h -
  nmap <buffer> l <CR>
endfunction


" Sneak
let g:sneak#label = 1

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


" FZF
noremap <Leader>b :Buffers<CR>
noremap <Leader>s :Snippets<CR>
noremap <C-p> :FZF<CR>
noremap <Leader>t :Windows<CR>
noremap <Leader>m :Marks<CR>


" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)


" List
set list
set listchars=tab:▸·,trail:·,precedes:^,extends:$


" Indents
" let g:indentLine_char = '¦'
let g:indentLine_char = ''
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1


" File Types
augroup FILETYPES
  autocmd FileType c setlocal shiftwidth=4
  autocmd FileType cpp setlocal shiftwidth=4
  autocmd FileType py setlocal shiftwidth=4
  autocmd FileType go setlocal shiftwidth=4
  autocmd FileType netrw call NetrwBuf()
augroup END
