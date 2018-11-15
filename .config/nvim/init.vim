" vim: set filetype=vim:
"""
""" Plugins
"""
if has('nvim')
  let vimpath = '~/.local/share/nvim'
  let plugpath = vimpath . '/site/autoload/plug.vim'
  let pluginspath = vimpath . '/plugged'
else
  let vimpath = '~/.vim'
  let plugpath = vimpath . '/autoload/plug.vim'
  let pluginspath = vimpath . '/plugged'
endif


" Plug Installer
if empty(glob(plugpath))
  exec 'silent !curl -fLo ' . plugpath . ' --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  augroup PLUG
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif


" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Neovim-specific or Vim-specific
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/denite.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-vinegar'       " Better netrw defaults; <hyphen>
Plug 'tpope/vim-surround'      " Surround text; [visual]S <p>
Plug 'tpope/vim-commentary'    " Commenting; [visual]gc
Plug 'tpope/vim-fugitive'      " Git; :Gstatus, :Gcommit, ...
Plug 'tpope/vim-repeat'        " Repeat for supported plugins
Plug 'tpope/vim-sleuth'        " Indentation detection
Plug 'morhetz/gruvbox'                  " Gruvbox colorscheme
Plug 'vim-airline/vim-airline'          " Status line
Plug 'vim-airline/vim-airline-themes'   " Status line themes
Plug 'mhinz/vim-startify'               " Vim start screen
Plug 'sheerun/vim-polyglot'    " Defaults for languages
Plug 'junegunn/vim-easy-align' " Text alignment; [visual]ga
Plug 'justinmk/vim-sneak'      " Easy cursor jumping; s/S
" Plug 'moll/vim-bbye'  " Close buffer; :Bdelete
Plug 'Yggdroot/indentLine'  " Space indentation
Plug 'ryanoasis/vim-devicons'  " File icons
Plug 'christoomey/vim-tmux-navigator'  " Tmux split navigation
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'  " Snippets for FZF
Plug 'zchee/deoplete-jedi'

call plug#end()


"""
""" Built-in Settings
"""
syntax on
colorscheme gruvbox
set encoding=UTF-8
set t_Co=256
set background=dark
if has('termguicolors')
 set termguicolors
endif

" Mouse
set mouse=a

" Cursor
set scrolloff=2

" List
set list
set listchars=tab:\ ,trail:\ ,precedes:^,extends:$,eol:¬

" Commands
set showcmd

" Speed
set regexpengine=1

" Timeouts
set timeoutlen=1000
set ttimeoutlen=0

" Rulers
set colorcolumn=80

" Wrapping
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

" Status
set cmdheight=2

" Splits
set splitbelow
set splitright

" Leader
let g:mapleader = ' '

" Sessions
let g:sessions_dir = '~/vim-sessions'

" Messages
set shortmess+=c

" Completion
set completeopt+=menuone,noinsert
set completeopt-=preview


"""
""" Built-in Mappings
"""
" Commands
nmap ; :

" Indentation
nnoremap <Tab> a<Tab><Esc>
nnoremap <S-Tab> i<Tab><Esc>
vnoremap <Tab> >><Esc>'[V']
vnoremap <S-Tab> <<<Esc>'[V']

" New lines
nnoremap <Enter> i<Enter><Esc>

" Remove highlight
nnoremap <Esc> :nohlsearch<CR>

" Write current directory
nnoremap <leader>L :!echo %:p:h > ~/.last-dir<CR><CR>

" Source
nnoremap <leader>S :source $MYVIMRC<CR>

" Terminal
tnoremap <leader><Esc> <C-\><C-n>
tnoremap <C-P> i<C-P>
tnoremap <C-H> <C-\><C-n><C-W><C-H>
tnoremap <C-J> <C-\><C-n><C-W><C-J>
tnoremap <C-K> <C-\><C-n><C-W><C-K>
tnoremap <C-L> <C-\><C-n><C-W><C-L>

" Cut and Paste
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P

" Save
noremap <Space><Esc> :w<CR>
noremap <C-s> :w<CR>

" Line navigation
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

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

" Visual 
vnoremap - g_


"""
""" Plugin Settings
"""
" Airline
let g:airline_powerline_fonts = 1

" Netrw
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Sneak
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Denite
noremap <Leader>b :Denite buffer<CR>
noremap <Leader>g :Denite grep<CR>
noremap <Leader>f :Denite buffer file<CR>
noremap <Leader>m :Denite mark<CR>
noremap <Leader>t :Denite tag<CR>
noremap <Leader>r :Denite register<CR>
noremap <Leader>d :Denite dictionary<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><C-g> deoplete#undo_completion()
inoremap <expr><C-n> deoplete#manual_complete()
imap <expr><silent><CR> pumvisible() ? deoplete#mappings#close_popup() .
  \ '<Plug>(neosnippet_jump_or_expand)' : '<CR>'
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? 
  \ '<Plug>(neosnippet_expand_or_jump)' : '<TAB>'

" Echodoc
let g:echodoc#enable_at_startup = 1

" Easy Align
xmap ga <Plug>(EasyAlign)

" Indents
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#454545'

let g:indentLine_leadingSpaceChar = ' '
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_concealcursor = ''

" Ultisnips
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<F5>'
let g:UltiSnipsJumpForwardTrigger = '<C-L>'
let g:UltiSnipsJumpBackwardTrigger = '<C-K>'



"""
""" Autocmd Groups
"""
" File Types
augroup FILETYPES
  autocmd FileType c setlocal shiftwidth=4
  autocmd FileType cpp setlocal shiftwidth=4
  autocmd FileType py setlocal shiftwidth=4
  autocmd FileType go setlocal shiftwidth=4
augroup END

" Vim Events
augroup EVENTS
  autocmd FocusGained,VimResized * :redraw!
augroup END
